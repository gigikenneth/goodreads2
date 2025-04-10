# data/example_data.R
example_data <- data.frame(
  `Book Id` = 1:15,
  `Title` = c(
    "The 48 Laws of Power",
    "Thinking, Fast and Slow",
    "Atomic Habits",
    "The Psychology of Money",
    "Deep Work",
    "The Laws of Human Nature",
    "Sapiens: A Brief History of Humankind",
    "The Power of Habit",
    "Quiet: The Power of Introverts",
    "Rich Dad Poor Dad",
    "Mindset: The New Psychology of Success",
    "The 7 Habits of Highly Effective People",
    "Grit: The Power of Passion and Perseverance",
    "The Subtle Art of Not Giving a F*ck",
    "Think and Grow Rich"
  ),
  `Author` = c(
    "Robert Greene",
    "Daniel Kahneman",
    "James Clear",
    "Morgan Housel",
    "Cal Newport",
    "Robert Greene",
    "Yuval Noah Harari",
    "Charles Duhigg",
    "Susan Cain",
    "Robert T. Kiyosaki",
    "Carol S. Dweck",
    "Stephen R. Covey",
    "Angela Duckworth",
    "Mark Manson",
    "Napoleon Hill"
  ),
  `Author l-f` = c(
    "Greene, Robert",
    "Kahneman, Daniel",
    "Clear, James",
    "Housel, Morgan",
    "Newport, Cal",
    "Greene, Robert",
    "Harari, Yuval Noah",
    "Duhigg, Charles",
    "Cain, Susan",
    "Kiyosaki, Robert T.",
    "Dweck, Carol S.",
    "Covey, Stephen R.",
    "Duckworth, Angela",
    "Manson, Mark",
    "Hill, Napoleon"
  ),
  `Additional Authors` = NA,
  `ISBN` = paste0("=\"", sprintf("%010d", 1:15), "\""),
  `ISBN13` = paste0("=\"978", sprintf("%010d", 1:15), "\""),
  `My Rating` = c(5, 4, 5, 4, 4, 0, 5, 4, 4, 3, 5, 4, 4, 3, 0),
  `Average Rating` = c(4.2, 4.5, 4.4, 4.6, 4.3, 4.4, 4.5, 4.2, 4.3, 4.1, 4.2, 4.3, 4.4, 4.0, 4.2),
  `Publisher` = c(
    "Penguin Books",
    "Farrar, Straus and Giroux",
    "Avery",
    "Harriman House",
    "Grand Central Publishing",
    "Viking",
    "Harper",
    "Random House",
    "Crown",
    "Plata Publishing",
    "Ballantine Books",
    "Free Press",
    "Scribner",
    "Harper",
    "Think and Grow Rich"
  ),
  `Number of Pages` = c(452, 499, 320, 256, 304, 624, 443, 371, 333, 336, 276, 381, 352, 224, 238),
  `Year Published` = c(2000, 2011, 2018, 2020, 2016, 2018, 2015, 2012, 2012, 1997, 2006, 1989, 2016, 2016, 1937),
  `Original Publication Year` = c(1998, 2011, 2018, 2020, 2016, 2018, 2014, 2012, 2012, 1997, 2006, 1989, 2016, 2016, 1937),
  `Date Read` = c(
    NA,
    "2024/03/10",
    "2024/03/05",
    "2024/02/28",
    "2024/02/20",
    NA,
    "2024/02/15",
    "2024/02/10",
    "2024/02/05",
    "2024/01/28",
    "2024/01/20",
    "2024/01/15",
    "2024/01/10",
    "2024/01/05",
    NA
  ),
  `Date Added` = c(
    "2024/03/15",
    "2024/03/10",
    "2024/03/05",
    "2024/02/28",
    "2024/02/20",
    "2024/02/18",
    "2024/02/15",
    "2024/02/10",
    "2024/02/05",
    "2024/01/28",
    "2024/01/20",
    "2024/01/15",
    "2024/01/10",
    "2024/01/05",
    "2024/01/01"
  ),
  `Bookshelves` = c(
    "to-read", "read", "read", "read", "read",
    "to-read", "read", "read", "read", "read",
    "read", "read", "read", "read", "to-read"
  ),
  `Bookshelves with positions` = paste0(
    c("to-read", "read", "read", "read", "read",
      "to-read", "read", "read", "read", "read",
      "read", "read", "read", "read", "to-read"),
    " (#", 1:15, ")"
  ),
  `Exclusive Shelf` = c(
    "to-read", "read", "read", "read", "read",
    "to-read", "read", "read", "read", "read",
    "read", "read", "read", "read", "to-read"
  ),
  `My Review` = NA,
  `Spoiler` = NA,
  `Private Notes` = NA,
  `Read Count` = c(0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0),
  `Owned` = c(0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0),
  check.names = FALSE,
  stringsAsFactors = FALSE
)

