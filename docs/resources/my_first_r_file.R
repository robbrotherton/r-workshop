# Doing sums --------------------------------------------------------------

1 + 1

(-3)^2

# here's a comment. comments do not get executed even if they contain valid code

# 2 + 2

# write a sum of your own.
# run the code and make sure you get the answer you're expecting



# Data structures ---------------------------------------------------------

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


### Overwriting -----------------------------------------------------------

number <- 1

number * 2

number <- 2

number * 2 # what answer will this give?


number <- 1

number <- number * 2 # what if you run this a few times?

number


# Functions ---------------------------------------------------------------

sum(c(1, 2, 3, 4, 5))

numbers <- c(1, 2, 3, 4, 5)

sum(numbers)

length(numbers)

mean(numbers)

sd(numbers)

min(numbers)

max(numbers)



# Doing stuff -------------------------------------------------------------

numbers <- c(3, 1, 4, 1, 5, 9)

numbers[1] # first element

numbers[1:3] # multiple consecutive elements

# can you pick out the 1st, 3rd, and 5th elements?


## Vector math ------------------------------------------------------------

numbers <- c(1, 2, 3, 4, 5)

numbers * 2

6 - numbers

numbers * c(1, 2)

numbers * numbers


### Math and functions ----------------------------------------------------

sd(numbers) / length(numbers) # standard error

numbers - mean(numbers) # deviations

(numbers - mean(numbers))^2 # squared deviations

# can you compute the sum of squared deviations?


