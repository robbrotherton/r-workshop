

# Typos -------------------------------------------------------------------

## spelling mistakes ----

numbers <- c(1, 2, 3, 4, 5)

numbers # this shows the contents of 'numbers'

# try typing the name wrong and see what error message you get


nummbers <- c(1, 2, 3, 4, 5)

numbers # oh dear, can you see the mistake?


## parentheses ----

sqrt(mean(seq(1, 10, 2)))

# try adding/deleting/moving some closing parentheses



# Overwriting objects -----------------------------------------------------

number <- 1

number * 2

number <- 2 # no warning when you reuse a name

number * 2


number <- 1

number <- number * 2 # what if you run this a few times?

number


## tidying up the Global Environment

rm(nummbers) # remove a particular object by name

rm(list = ls()) # remove everything in the global environment


# Vectors -----------------------------------------------------------------

## math edge case ----

numbers <- c(1, 2, 3, 4, 5)

numbers * c(1, 2, 3, 4, 5) # makes sense...

numbers * c(1, 2) # what happens here?

## vector coercion ----

numbers <- c(1, 2, 3, 4, 5)
numbers

numbers <- c(1, 2, "three", 4, 5)
numbers

numbers <- c(1, 2, "3", 4, 5)
numbers

mean(numbers)

## data.frame column coercion ----

df <- data.frame(a = c(1, 2, 3),
                 b = c("one", "two", "three"),
                 c = c(1, 2, "3"))

str(df)

mean(df$c)


## coercion: confusing results ----

1 < "2"

22 < "11"

3 > "two"

# why?


## doing math with logicals ----

bool <- c(TRUE, FALSE, FALSE, TRUE)
bool

as.numeric(bool)

sum(bool) # count of TRUEs

mean(bool) # proportion of TRUEs


# Factors -----------------------------------------------------------------

data <- c("female", "male", "male", "female")

data_factor <- factor(data)

data_factor

as.numeric(data_factor)


## From numeric raw data to labelled factor ----

data <- c(1, 2, 2, 1) # gender coded numerically

factor(data, levels = c(1, 2), labels = c("female", "male"))


## Ordered factors ----

data <- c("medium", "low", "high", "medium", "high", "high")

unordered <- factor(data)

ordered <- factor(data,
                  levels = c("low", "medium", "high"),
                  ordered = TRUE)


# can you make an ordered factor out of this ordinal data?

survey_data <- c("agree", "agree", "disagree", "neutral", "disagree")

