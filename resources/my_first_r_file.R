# Doing sums --------------------------------------------------------------

1 + 1

(-3)^2

# here's a comment. comments do not get executed even if they contain valid code

# 2 + 2

# write a sum of your own.
# run the code and make sure you get the answer you're expecting



# Vectors -----------------------------------------------------------------

# numeric vectors

c(1, 2, 3, 4, 5)

1:5

5:1

1 # is just a numeric vector of length 1

# character vector
c("hello", "world")

# logical vector
c(TRUE, FALSE)


## Assignment -------------------------------------------------------------

# name <- thing

numbers <- c(1, 2, 3, 4, 5)


# Functions ---------------------------------------------------------------

sum(c(1, 2, 3, 4, 5))

# assign a numeric vector then use as function input
numbers <- c(1, 2, 3, 4, 5)

sum(numbers)

length(numbers)

mean(numbers)

sd(numbers)

min(numbers)

max(numbers)



## Arguments --------------------------------------------------------------

seq(from = 1, to = 10, by = 2)

seq(1, 10, 2)

# try making a different sequence, with out without naming the arguments
# make sure you get the sequence you're expecting

# when in doubt, get some help
?seq

?mean

# Doing stuff with vectors -------------------------------------------------

## Indexing ----

numbers <- c(3, 1, 4, 1, 5, 9)

numbers[1] # first element

numbers[1:3] # multiple consecutive elements

# can you pick out the 1st, 3rd, and 5th elements?


## Vector math ----

numbers <- c(1, 2, 3, 4, 5)

numbers * 2

6 - numbers

numbers * numbers


### Math and functions ----------------------------------------------------

numbers - mean(numbers) # deviations

(numbers - mean(numbers))^2 # squared deviations

# can you compute the sum of squared deviations?


### Indexing -------------------------------------------------------------

numbers <- c(1, 2, 3, 4, 5)

numbers == 3

numbers != 3

numbers %in% c(1, 3)

numbers < 3

# getting vector elements by condition

numbers[numbers < 3]


# Missing values ----------------------------------------------------------

numbers <- c(1, 2, NA, 4, 5)

mean(numbers)

# can you solve the problem by looking at the help page for the mean function?



# dataframes --------------------------------------------------------------

df <- data.frame(a = c(1, 2, 3, 4, 5),
                 b = c(6, 7, 8, 9, 10),
                 c = c("this", "is", "a", "text", "column"),
                 d = c(TRUE, FALSE, FALSE, FALSE, TRUE))

# get a quick summary of each column

summary(df)


df$a * 2

df$a * df$b

df$a[df$d]



# The pipe ----------------------------------------------------------------

df |>
  summary()
