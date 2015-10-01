### Analyzing patient data

getwd()
setwd()
getwd()

dir(path=".")

# load data
read.csv(file="data/inflammation-01.csv", header=FALSE)

# variable, a name for a value
# letters, numbers, "_", and "." only
weight_kg  <- 55
weight_kg
weight_kg * 2.2
# introduce #
# weight in pounds
weight_pd <- weight_kg * 2.2

dat <- read.csv(file="data/inflammation-01.csv", header=FALSE)
dat
head(dat)

# know the data, type and shape
class(dat)
dim(dat)

dat[1, 1]
dat[30, 20]
dat[1:5, 1:10]
dat[6:10, 2:10]
dat[c(3, 8, 37, 56), c(10, 14, 29)]
dat[5,]
dat[,16]
dat[,]

patient_1 <- dat[1, ]
max(patient_1)
max(dat[2, ]) # combine selection and function call

min(dat[, 7])
mean(dat[, 7])
median(dat[, 7])
sd(dat[, 7])

# What if we need the maximum inflammation for all patients, or the average for each day?
?apply

avg_patient_inflammation <- apply(dat, 1, mean)

avg_day_inflammation <- apply(dat, 2, mean)

max_day_inflammation <- apply(dat, 2, max)
plot(max_day_inflammation)

min_day_inflammation <- apply(dat, 2, min)
plot(min_day_inflammation)

sd_day_inflammation <- apply(dat, 2, sd)
plot(sd_day_inflammation)

# plot they together
n_days <- length(avg_day_inflammation)
days <- 1:n_days
CI_up <- avg_day_inflammation + sd_day_inflammation
CI_dn <- avg_day_inflammation - sd_day_inflammation
plot(days, avg_day_inflammation, ylim=c(0,20))
arrows(days, CI_dn, days, CI_up, code=3, length=0.05, angle=90, col="red")


#
# Creating functions
#
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin)
}

fahr_to_kelvin(32) # freezing point of water
fahr_to_kelvin(212) # boiling point of water

kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.15
  return(celsius)
}

kelvin_to_celsius(0) # absolute zero in Celsius

# Composing function: fahrenheit to Celsius
fahr_to_celsius <- function(temp) {
  temp_k <- fahr_to_kelvin(temp)
  result <- kelvin_to_celsius(temp_k)
  return(result)
}

fahr_to_celsius(32) # freezing point of water in C
# taste of how larger programs are built

# Stack frame (environments in R), closer look at what happens when call fahr_to_celsius(32)
original <- 32
final <- fahr_to_celsius(original)
temp

span <- function(a) {
  diff <- max(a) - min(a)
  return(diff)
}

dat <- read.csv(file = "data/inflammation-01.csv", header=FALSE)
span(dat)

diff <- read.csv(file = "data/inflammation-01.csv", header=FALSE)
span(diff)

### Testing and Documenting
center <- function(data, desired) {
  new_data <- (data - mean(data)) + desired
  return(new_data)
}
# simple test
z <- c(0, 0, 0, 0)
z
center(z, 3)
#real test
dat <- read.csv(file = "data/inflammation-01.csv", header = FALSE)
centered <- center(dat[, 4], 0)
head(centered)

mean(dat[, 4])
mean(centered)
sd(dat[, 4])
sd(centered)
all.equal(sd(dat[, 4]), sd(centered))

# add comment to remind 6 months later
center <- function(data, desired) {
  # return a new vector containing the original data centered around the
  # desired value.
  # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
  new_data <- (data - mean(data)) + desired
  return(new_data)
}

###  defining defaults
dat <- read.csv("data/inflammation-01.csv", FALSE)
dat <- read.csv(header = FALSE, file = "data/inflammation-01.csv")
dat <- read.csv(FALSE, "data/inflammation-01.csv")

center <- function(data, desired = 0) {
  # return a new vector containing the original data centered around the
  # desired value (0 by default).
  # Example: center(c(1, 2, 3), 0) => c(-1, 0, 1)
  new_data <- (data - mean(data)) + desired
  return(new_data)
}

test_data <- c(0, 0, 0, 0)
center(test_data, 3)

more_data <- 5 + test_data
more_data
center(more_data)

display <- function(a = 1, b = 2, c = 3) {
  result <- c(a, b, c)
  names(result) <- c("a", "b", "c")  # This names each element of the vector
  return(result)
}
# no arguments
display()
display(55)
display(55, 66)
display (55, 66, 77)
# only setting the value of c
display(c = 77)

#
# For loop
#

analyze <- function(filename) {
  # Plots the average, min, and max inflammation over time.
  # Input is character string of a csv file.
  dat <- read.csv(file = filename, header = FALSE)
  avg_day_inflammation <- apply(dat, 2, mean)
  plot(avg_day_inflammation)
  max_day_inflammation <- apply(dat, 2, max)
  plot(max_day_inflammation)
  min_day_inflammation <- apply(dat, 2, min)
  plot(min_day_inflammation)
}

analyze("data/inflammation-01.csv")
analyze("data/inflammation-02.csv")

best_practice <- c("Let", "the", "computer", "do", "the", "work")
print_words <- function(sentence) {
  print(sentence[1])
  print(sentence[2])
  print(sentence[3])
  print(sentence[4])
  print(sentence[5])
  print(sentence[6])
}

print_words(best_practice)
best_practice[-6]
print_words(best_practice[-6])

# better approach
print_words <- function(sentence) {
  for (word in sentence) {
    print(word)
  }
}

print_words(best_practice)
print_words(best_practice[-6])

# another example that repeatedly update a variable.
len <- 0
vowels <- c("a", "e", "i", "o", "u")
for (v in vowels) {
  len <- len + 1
}
# Number of vowels
len

letter <- "z"
for (letter in c("a", "b", "c")) {
  print(letter)
}
letter

length(vowels)

### Processing Multiple Files
#  The only thing that’s missing is a function that finds files whose names match a pattern
?list.files
list.files(path = "data", pattern = "csv")
list.files(path = "data", pattern = "inflammation")
list.files(path = "data", pattern = "inflammation", full.names = TRUE)

filenames <- list.files(path = "data", pattern = "inflammation", full.names = TRUE)
filenames <- filenames[1:3]
for (f in filenames) {
  print(f)
  analyze(f)
}