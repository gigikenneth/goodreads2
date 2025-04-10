# Goodreads Wrapped: A Shiny App for Visualizing Your Reading Journey

Hey there! I'm excited to share version 2.0 of my Goodreads visualization project. Last year, I built this tool using Streamlit to help visualize reading habits (check out the [original version here](https://github.com/gigikenneth/goodreads)), and now I've rebuilt it using R Shiny, adding a bunch of new features and giving it a pretty pink makeover with help from [Claude](https://claude.ai/).

![Screen Recording 2024-12-24 at 10 39 35 PM](https://github.com/user-attachments/assets/a68ce9dd-2575-49ef-9cde-841c1ba67ff4)

## What's New in 2.0? 
I've kept all the others things from the original version but made them even better:
- Added a cute pink theme throughout the app (because why not?)
- Made the tables searchable and more interactive
- Created better visualizations for your reading stats
- Added a new Books section to browse through your entire collection
- Improved the word cloud to show your reading interests better

## What Can You Do With It?
1. 📚 Get an overview of your reading life with total books, ratings, and pages read
2. ✨ Explore a personalized Reading Story that analyzes your unique reading habits
3. 📱 Create shareable stats cards to post on social media
4. ⭐ See how you tend to rate books (are you a tough critic or an easy pleaser?)
5. 📈 Track how your reading habit has grown over time
6. 📚 Browse through all your books in one place
7. ✍️ Find out which authors you can't get enough of
8. 📖 See if you prefer doorstoppers or quick reads
9. 🌟 Get a pretty word cloud of your book titles

## Want to Try It?
It's super easy to get started:

1. Grab your data from Goodreads:
   - Head to [Goodreads.com](https://www.goodreads.com) and go to "My Books"
   - Look for "Import and Export"
   - Hit "Export Library"
   - Or use this [direct link to the export page](https://www.goodreads.com/review/import)

2. Then just:
   - Upload your file to the app
   - Or hit "Try Example Data" if you just want to explore.

## Built Using
I used R Shiny for this version, along with these libraries:
- 📊 **Plotly** for interactive charts
- ☁️ **WordCloud2** for the title visualization
- 📋 **DT** for interactive tables
- 📅 **lubridate** for handling dates
- 📑 **tidytext** for text analysis
- 🎨 Custom CSS for the pretty pink design throughout

## Check It Out!
You can find the app here: https://gkenneth.shinyapps.io/goodreads2/ 
I'd love to hear what you think about this new version! Feel free to try it out, and let me know if you have any suggestions for making it even better. 💕

## Read More
Check out the [blog post](https://blog.devgenius.io/from-streamlit-to-shiny-visualizing-my-goodreads-reading-journey-986e1304faf6) about how I built this app!
