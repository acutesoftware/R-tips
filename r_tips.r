# r_tips.r	written by Duncan Murray 2/10/2013
# useful tips found while learning R

# to specify a column class (headings) on an unknown file
# read the first 100 lines, take the colClass then re-read
# it properly and apply the colClass to the full load

initial <- read.table("datatable.txt", nrows=100)
classes <- sapply(initial, class)
tabAll <- read.table("datatable.txt", colClasses = classes)

# NOTE - read.table (and its sister read.csv) read the
# entire file into memory, so if filesize > RAM you are in strife

# Functions
################
# functions return the LAST variable evaluated
f <- function(a,b) {   # Lazy evaluation - you dont need ALL params if not used
	a^2
}
f(2) # returns 4

# The ... argument passes all other default parameters to a sub function
# you can use partial matching function params but DONT

z <- 10

func_with_free_variable <-  function(a, b) {
	a + b + z
}

func_with_free_variable(2,4)






# Scoping Rules
################
# you can use a variable in a function which is NOT declared theere - this is a 
# Free variable which can be declared by the parent (YIKES!) - dont do this!




# Example Code 
################


x <- 99
if ( x > 2) {
	y <- 10
} else {
	y <- 0
}
print(y)



for(n in 1:10) {
	print (n)
}

h <- matrix(1:6)

for (i in seq_along(h)) {
	print(x[i])
}



# apply
# less typing than a loop
str(apply)
# function (X, MARGIN, FUN, ... )

xx <- matrix(rnorm(200), 20, 10)
apply(xx, 2, mean)  # returns a vector of length 10 - takes mean of column

apply(xx, 1, sum)  # means of all ROWS of array ( vector of length 20) 

# use rowSums, rowMeans, colMeans, colSums is FASTER than apply

# split
library(datasets)
head(airquality)

# split into monthly pieces
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")],na.rm = TRUE))

# to see ALL columns 
 sapply(s, function(x) colMeans(x[, ],na.rm = TRUE))

# splitting on more than one level
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
f1
f2
interaction(f1, f2)

# list calls interaction
str(split(x, list(f1, f2), drop = TRUE))

# mapply - applies a function in parallel over a set of arguments

m <- mapply(mean, ... , SIMPLIFY = TRUE, USE.NAMES = TRUE )

# mapply(rep, 1:4, 4:1)  # rep = repeat function

noise <- function(n, mean, sd) {
	rnorm(n, mean, sd)
}

noise(5,1,2)

mapply(noise, 1:5, 1:5, 2)

### DEBUGGING TOOLS ### 

# debug - flags a function for debug mode which allows you to step through execution one line at a time


# quiz questions 
s <- split(iris, iris$Species)
lapply(s, function(x) colMeans(x[, c("Ozone") ],na.rm = TRUE))

# apply(iris[, 1:4], 2, mean)
s <- split(iris, iris$Species)
mean(s$virginica[,1])

#colMeans(iris[.1:4])
#apply(iris["Sepal.Length"], 2, mean)

sapply(split(mtcars$mpg, mtcars$cyl), mean)

apply(split(mtcars$hp, mtcars$cyl), mean)

# s <- split(airquality, airquality$Month)
# lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))

## Dates
t <- Sys.time()
d <- as.date("2013-09-09")

#### Working Directory
getwd()    						# returns C:/user
setwd("C:/user/dev/src/R")			# set the working dir
homicides <- readLines("homicides.txt")	# load the file to data
str(homicides)       				# show the structure 
homicides[954]					# show a single row


length(homicides)					# returns size 1250

# default data sets
length(state.name)				# list of US states

# plot monthly homicide counts
r <- regexec("<dd>[F|f]ound on (.*?)</dd>", homicides)
m <- regmatches(homicides, r)
dates <- sapply(m, function(x) x[2])
dates <- as.Date(dates, "%B %d, %Y")
hist(dates, "month", freq = TRUE)



