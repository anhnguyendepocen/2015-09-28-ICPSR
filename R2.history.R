getwd()
setwd("~/Desktop/swc-r-day1/")
getwd()

#
# Making choices
#

### saving plots
analyze <- function(filename) {
  # Plots the average, min, and max inflammation over time.
  # Input is character string of a csv file.
  dat <- read.csv(file = filename, header = FALSE)
  avg_day_inflammation <- apply(dat, 2, mean)
  plot(avg_day_inflammation, main=filename)
  max_day_inflammation <- apply(dat, 2, max)
  plot(max_day_inflammation, main=filename)
  min_day_inflammation <- apply(dat, 2, min)
  plot(min_day_inflammation, main=filename)
}

analyze_all <- function(pattern) {
  # Runs the function analyze for each file in the current working directory
  # that contains the given pattern.
  filenames <- list.files(path = "data", pattern = pattern, full.names = TRUE)
  for (f in filenames) {
    analyze(f)
  }
}

analyze("data/inflammation-01.csv")
analyze_all("inflammation")

pdf("inflammation-01.pdf")
analyze("data/inflammation-01.csv")
dev.off()

# it would be nice to chose display or save
### conditionals
num <- 37
if (num > 100) {
  print("greater")
} else {
  print("not greater")
}
print("done")

num > 100
num < 100

# it is ok not to include else
num <- 53
if (num > 100) {
  print("num is greater than 100")
}

sign <- function(num) {
  if (num > 0) {
    return(1)
  } else if (num == 0) {
    return(0)
  } else {
    return(-1)
  }
}
sign(-3)
sign(0)
sign(2/5)

10 >= 10
10 <= 10
10 != 10

# & and |
if (1 > 0 & -1 > 0) {
  print("both parts are true")
} else {
  print("at least one part is not true")
}

if (1 > 0 | -1 > 0) {
  print("at least one part is true")
} else {
  print("both part is false")
}

### smart function for displaying or saving figures
analyze <- function(filename, output = NULL) {
  # Plots the average, min, and max inflammation over time.
  # Input:
  #    filename: character string of a csv file
  #    output: character string of pdf file for saving
  if (!is.null(output)) {
    pdf(output)
  }
  dat <- read.csv(file = filename, header = FALSE)
  avg_day_inflammation <- apply(dat, 2, mean)
  plot(avg_day_inflammation, main=filename)
  max_day_inflammation <- apply(dat, 2, max)
  plot(max_day_inflammation, main=filename)
  min_day_inflammation <- apply(dat, 2, min)
  plot(min_day_inflammation, main=filename)
  if (!is.null(output)) {
    dev.off()
  }
}

output <- NULL
is.null(output)
!is.null(output)

# interactive to check and then save
analyze("data/inflammation-01.csv")
analyze("data/inflammation-01.csv", output = "inflammation-01.pdf")

# We need to substitute the filename ending “csv” with “pdf”
f <- "data/inflammation-01.csv"
sub("csv", "pdf", f)

analyze_all <- function(pattern) {
  # Runs the function analyze for each file in the current working directory
  # that contains the given pattern.
  filenames <- list.files(path = "data", pattern = pattern, full.names = TRUE)
  for (f in filenames) {
    pdf_name <- sub("csv", "pdf", f)
    analyze(f, output = pdf_name)
  }
}

analyze_all("inflammation")
