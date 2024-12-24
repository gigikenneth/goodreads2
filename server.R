# server.R
function(input, output, session) {
  rv <- reactiveValues(data = NULL)

  # Load example data
  observeEvent(input$load_example, {
    rv$data <- example_data %>%
      mutate(
        `Date Added` = as.character(`Date Added`),
        `Date Read` = as.character(`Date Read`),
        `Number of Pages` = as.numeric(`Number of Pages`),
        `My Rating` = as.numeric(`My Rating`),
        `Exclusive Shelf` = as.character(`Exclusive Shelf`)
      )

    years <- sort(unique(year(as.Date(rv$data$`Date Added`, format = "%Y/%m/%d"))),
                  decreasing = TRUE)
    updateSelectInput(session, "year",
                      choices = c("All Time" = "all", years))
  })

  # File upload handling
  observeEvent(input$file, {
    req(input$file)
    rv$data <- read.csv(input$file$datapath, check.names = FALSE)

    # Update year choices
    years <- sort(unique(year(as.Date(rv$data$`Date Added`, format = "%Y/%m/%d"))), decreasing = TRUE)
    updateSelectInput(session, "year",
                      choices = c("All Time" = "all", years))
  })

  # Filter data by year
  filtered_data <- reactive({
    req(rv$data)
    data <- rv$data %>%
      mutate(
        Date_Added = as.Date(`Date Added`, format = "%Y/%m/%d"),
        Date_Read = as.Date(`Date Read`, format = "%Y/%m/%d"),
        Number_of_Pages = as.numeric(`Number of Pages`),
        My_Rating = as.numeric(`My Rating`)
      )

    if (input$year != "all") {
      data <- data %>% filter(year(Date_Added) == input$year)
    }
    data
  })

  # Summary Statistics
  output$total_books <- renderText({
    req(filtered_data())
    nrow(filtered_data())
  })

  output$avg_rating <- renderText({
    req(filtered_data())
    mean_rating <- mean(filtered_data()$My_Rating[filtered_data()$My_Rating > 0], na.rm = TRUE)
    sprintf("%.1f ⭐", mean_rating)
  })

  output$total_pages <- renderText({
    req(filtered_data())
    total <- sum(filtered_data()$Number_of_Pages[filtered_data()$`Exclusive Shelf` == "read"],
                 na.rm = TRUE)
    format(total, big.mark = ",")
  })

  # Books Table
  output$books_table <- renderDT({
    req(filtered_data())

    filtered_data() %>%
      select(Title, Author, `Number of Pages`, `My Rating`, `Date Added`, `Exclusive Shelf`) %>%
      arrange(desc(`Date Added`)) %>%
      mutate(
        `Date Added` = as.Date(`Date Added`, format = "%Y/%m/%d"),
        `My Rating` = ifelse(`My Rating` == 0, NA, `My Rating`)
      ) %>%
      datatable(
        options = list(
          pageLength = 10,
          order = list(list(4, 'desc')),  # Sort by Date Added by default
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().container()).css({'background-color': '#ffeef2', 'border-radius': '10px', 'padding': '15px'});",
            "}"
          )
        ),
        style = "bootstrap",
        class = "compact"
      )
  })

  # Recent Books
  output$recent_books <- renderDT({
    req(filtered_data())

    tryCatch({
      filtered_data() %>%
        select(Title, Author, `My Rating`, `Date Added`) %>%
        mutate(
          `Date Added` = as.Date(`Date Added`, format = "%Y/%m/%d"),
          `My Rating` = case_when(
            is.na(`My Rating`) ~ "Not Rated",
            `My Rating` == 0 ~ "Not Rated",
            TRUE ~ paste(rep("⭐", `My Rating`), collapse = "")
          )
        ) %>%
        arrange(desc(`Date Added`)) %>%
        head(5) %>%
        datatable(
          options = list(
            dom = 't',
            ordering = FALSE,
            initComplete = JS(
              "function(settings, json) {",
              "$(this.api().table().container()).css({'background-color': '#ffeef2', 'border-radius': '10px', 'padding': '15px'});",
              "}"
            )
          ),
          style = "bootstrap",
          class = "compact"
        )
    }, error = function(e) {
      # Return an empty datatable if there's an error
      datatable(
        data.frame(
          Title = character(),
          Author = character(),
          `My Rating` = character(),
          `Date Added` = as.Date(character())
        ),
        options = list(dom = 't'),
        style = "bootstrap",
        class = "compact"
      )
    })
  })
  # Ratings Plot
  output$ratings_plot <- renderPlotly({
    req(filtered_data())

    plot_data <- filtered_data() %>%
      filter(My_Rating > 0) %>%
      count(My_Rating)

    plot_ly(plot_data, x = ~My_Rating, y = ~n, type = "bar",
            marker = list(color = "#ffb6c1")) %>%
      layout(
        title = list(text = "Book Ratings", font = list(family = "Quicksand")),
        xaxis = list(title = "Rating"),
        yaxis = list(title = "Count"),
        paper_bgcolor = "rgba(0,0,0,0)",
        plot_bgcolor = "rgba(0,0,0,0)"
      )
  })

  # Progress Plot
  output$cumulative_plot <- renderPlotly({
    req(filtered_data())

    plot_data <- filtered_data() %>%
      arrange(Date_Added) %>%
      mutate(cumulative = row_number())

    plot_ly(plot_data, x = ~Date_Added, y = ~cumulative, type = "scatter",
            mode = "lines", line = list(color = "#ffb6c1")) %>%
      layout(
        title = list(text = "Reading Journey", font = list(family = "Quicksand")),
        xaxis = list(title = "Date"),
        yaxis = list(title = "Number of Books"),
        paper_bgcolor = "rgba(0,0,0,0)",
        plot_bgcolor = "rgba(0,0,0,0)"
      )
  })

  # Authors Plot
  output$authors_plot <- renderPlotly({
    req(filtered_data())

    plot_data <- filtered_data() %>%
      count(Author, sort = TRUE) %>%
      head(10)

    plot_ly(plot_data, x = ~reorder(Author, n), y = ~n, type = "bar",
            marker = list(color = "#ffb6c1")) %>%
      layout(
        title = list(text = "Most Read Authors", font = list(family = "Quicksand")),
        xaxis = list(title = "Author"),
        yaxis = list(title = "Count"),
        paper_bgcolor = "rgba(0,0,0,0)",
        plot_bgcolor = "rgba(0,0,0,0)"
      )
  })

  # Read Status Plot
  output$read_status_plot <- renderPlotly({
    req(filtered_data())

    plot_data <- filtered_data() %>%
      count(`Exclusive Shelf`)

    colors <- c("#ffb6c1", "#ffd1dc", "#ffe4e1", "#ff69b4")

    plot_ly(plot_data, labels = ~`Exclusive Shelf`, values = ~n, type = "pie",
            marker = list(colors = colors)) %>%
      layout(
        title = list(text = "Reading Status", font = list(family = "Quicksand")),
        paper_bgcolor = "rgba(0,0,0,0)",
        plot_bgcolor = "rgba(0,0,0,0)"
      )
  })

  # Book Lengths Plot
  output$lengths_plot <- renderPlotly({
    req(filtered_data())

    plot_ly(filtered_data(), x = ~Number_of_Pages, type = "histogram",
            marker = list(color = "#ffb6c1")) %>%
      layout(
        title = list(text = "Book Lengths", font = list(family = "Quicksand")),
        xaxis = list(title = "Number of Pages"),
        yaxis = list(title = "Count"),
        paper_bgcolor = "rgba(0,0,0,0)",
        plot_bgcolor = "rgba(0,0,0,0)"
      )
  })

  # Title Word Cloud
  output$title_cloud <- renderWordcloud2({
    req(filtered_data())

    # Load stop words
    data("stop_words", package = "tidytext")
    custom_stops <- c("the", "and", "to", "a", "in", "of", "for", "on", "with", "at", "by", "from", "up", "about", "into", "over", "after")
    all_stops <- unique(c(stop_words$word, custom_stops))

    words <- filtered_data()$Title %>%
      str_split(" ") %>%
      unlist() %>%
      str_remove_all("[[:punct:]]") %>%
      str_to_lower() %>%
      # Remove stop words
      .[!(. %in% all_stops)] %>%
      # Remove very short words
      .[nchar(.) > 1] %>%
      table()

    word_data <- data.frame(word = names(words),
                            freq = as.numeric(words)) %>%
      # Additional filtering for common words
      filter(!word %in% c("vol", "volume", "book", "part"))

    wordcloud2(word_data,
               color = rep(c("#ffb6c1", "#ffd1dc", "#ff69b4"), length.out = nrow(word_data)),
               backgroundColor = "#fff5f7")
  })

  # Statistics outputs
  output$rating_stats <- renderUI({
    req(filtered_data())

    stats <- filtered_data() %>%
      filter(My_Rating > 0) %>%
      summarise(
        Average = mean(My_Rating, na.rm = TRUE),
        Median = median(My_Rating, na.rm = TRUE),
        Count = sum(!is.na(My_Rating))
      )

    div(
      h4(style = "color: #ff69b4;", "📊 Rating Statistics"),
      p(sprintf("Average Rating: %.2f ⭐", stats$Average)),
      p(sprintf("Median Rating: %.1f ⭐", stats$Median)),
      p(sprintf("Number of Rated Books: %d 📚", stats$Count))
    )
  })

  # Length Statistics
  output$length_stats <- renderUI({
    req(filtered_data())

    stats <- filtered_data() %>%
      filter(!is.na(Number_of_Pages)) %>%
      summarise(
        Average = mean(Number_of_Pages, na.rm = TRUE),
        Median = median(Number_of_Pages, na.rm = TRUE),
        Min = min(Number_of_Pages, na.rm = TRUE),
        Max = max(Number_of_Pages, na.rm = TRUE)
      )

    div(
      h4(style = "color: #ff69b4;", "📚 Length Statistics"),
      p(sprintf("Average Length: %d pages", round(stats$Average))),
      p(sprintf("Median Length: %d pages", stats$Median)),
      p(sprintf("Shortest Book: %d pages", stats$Min)),
      p(sprintf("Longest Book: %d pages", stats$Max))
    )
  })

  # Top Authors Table
  output$top_authors_table <- renderDT({
    req(filtered_data())

    filtered_data() %>%
      count(Author, sort = TRUE) %>%
      head(10) %>%
      rename("Number of Books" = n) %>%
      datatable(
        options = list(
          pageLength = 5,
          dom = 't',
          initComplete = JS(
            "function(settings, json) {",
            "$(this.api().table().container()).css({'background-color': '#ffeef2', 'border-radius': '10px', 'padding': '15px'});",
            "}"
          )
        ),
        style = "bootstrap",
        class = "compact"
      )
  })
}
