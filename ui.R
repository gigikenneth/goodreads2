# ui.R
fluidPage(
  tags$head(
    # Browser tab title with emoji
    tags$title("📚 Goodreads Wrapped"),
    tags$link(href = "https://fonts.googleapis.com/css2?family=Quicksand:wght@300;400;500;600;700&display=swap",
              rel = "stylesheet"),
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),

  titlePanel(div(style = "text-align: center; padding: 20px;",
                 "✨ My Reading Journey ✨")),

  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload your Goodreads CSV",
                accept = c(".csv")),

      selectInput("year", "Select Year:",
                  choices = c("All Time" = "all")),

      actionButton("load_example", "Try Example Data",
                   style = "background-color: #ffb6c1; color: white; width: 100%; border: none; border-radius: 20px;"),

      width = 3
    ),

    mainPanel(
      tabsetPanel(
        # Summary Tab
        tabPanel("📚 Summary",
                 fluidRow(
                   column(4,
                          div(class = "stats-box",
                              div(class = "stats-number", textOutput("total_books")),
                              div(class = "stats-label", "Total Books"))),
                   column(4,
                          div(class = "stats-box",
                              div(class = "stats-number", textOutput("avg_rating")),
                              div(class = "stats-label", "Average Rating"))),
                   column(4,
                          div(class = "stats-box",
                              div(class = "stats-number", textOutput("total_pages")),
                              div(class = "stats-label", "Pages Read")))
                 ),
                 br(),
                 plotlyOutput("read_status_plot", height = "400px")),

        tabPanel("⭐ Ratings",
                 plotlyOutput("ratings_plot"),
                 div(class = "stats-box", uiOutput("rating_stats"))),

        tabPanel("📈 Progress",
                 plotlyOutput("cumulative_plot")),

        tabPanel("📚 Books",
                 div(class = "stats-box",
                     DTOutput("books_table")),
                 br(),
                 div(class = "stats-box",
                     h4(style = "color: #ff69b4;", "Recently Added Books"),
                     DTOutput("recent_books"))),

        tabPanel("✍️ Authors",
                 plotlyOutput("authors_plot"),
                 div(class = "stats-box", DTOutput("top_authors_table"))),

        tabPanel("📖 Book Lengths",
                 plotlyOutput("lengths_plot"),
                 div(class = "stats-box", uiOutput("length_stats"))),

        tabPanel("🌟 Title Cloud",
                 wordcloud2Output("title_cloud", height = "600px"))
      ),
      width = 9
    )
  )
)
