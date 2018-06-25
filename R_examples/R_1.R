2 * 3  #=> 6
sqrt(36)  #=> 6, square root
log10(100)  #=> 2, log base 10
10 / 3  #=> 3.3, 10 by 3
10 %/% 3  #=> 3, quotient of 10 by 3
10 %% 3  #=> 1, remainder of 10 by 3

# The Assignment Operator

a <- 10  # assign 10 to 'a'
a = 11  # same as above
12 -> a  # assign 10 to 'a'
10 = a  # Wrong!. This will try to assign `a` to 10.

# Classes or Data types

class(a)  # numeric

a <- as.character(a)
print(a)  # prints out the value of a
class(a)  # character

# What is a R package and how to install them?

install.packages("car")  # install car package

library(car)  # initialize the pkg 'car'
require(car)  # another way to initialize
library()  # see list of all installed packages
library(help=dplyr)  # see info about 'car' pkg

# Getting Help

help(merge)  # get help page for 'merge'
?merge  # lookup 'merge' from installed pkgs
??merge  # vague search
example(merge)  # show code examples

# ctrl+L to clean the console

# What is a working directory and how to set up one?

# A working directory is the reference directory from 
# which R has direct access to read in files. You can 
# read in and write files directly to the working directory 
# without using the full file path. The directory names should 
# be separated by forward slash / or double back slash \\ instead
# of \ even for a windows PC.

dirname = "C:/Users/SKL/Documents/DLMLPYRTRAINING/Day7/"
getwd()  # gets the working directory
setwd(dirname)  # set the working directory to dir name

# How to import and export data?
read.csv

myData <- read.table("C:/Users/SKL/Documents/DLMLPYRTRAINING/Day7/data/data2.csv", header = TRUE, sep=",", 
                     colClasses=c("integer","character","numeric")) 
                     # import "|" separated .txt file
                     

myData <- read.csv("https://raw.githubusercontent.com/DLMLPYRTRAINING/Day3/master/Datasets/Linear1.csv", header=FALSE)  # import csv file
write.csv(myData, "C:/Users/SKL/Documents/DLMLPYRTRAINING/Day7/data/data_write.csv")  # export 

# How to view and delete objects in your console ?

a <- 10
b <- 20
ls()  # list objects in global env
rm(a)  # delete the object 'a'
rm(list = ls())  # caution: delete all objects in .GlobalEnv
gc()  # free system memory

# However if you choose, you can create a new environment and store them there.

rm(list=ls())  # remove all objects in work space
env1 <- new.env()  # create a new environment
assign("a", 3, envir = env1)  # store a=3 inside env1
ls()  # returns objects in .GlobalEnv
ls(env1)  # returns objects in env1
get('a', envir=env1)  # retrieve value from env1

# How to create a vector?

vec1 <- c(10, 20, 15, 40)  # numeric vector
vec2 <- c("a", "b", "c", NA)  # character vector
vec3 <- c(TRUE, FALSE, TRUE, TRUE)  # logical vector
vec4 <- gl(4, 1, 4, label = c("l1", "l2", "l3", "l4"))  # factor with 4 levels
vec5 <- c(1,"B",TRUE)

# How to reference elements of a vector?

length(vec1)  # 4
print(vec1[1])  # 10
print(vec1[1:3])  # 10, 20, 15

# Here is how to initialize a numeric vector:

numericVector <- numeric(100) # length 100 elements

# How To Manipulate Vectors
# Subsetting

logic1 <- vec1 < 15  # create a logical vector, TRUE if value < 15
vec1[logic1]  # elements in TRUE positions will be included in subset
vec1[vec1 < 15] # direct logic filter implementation
vec1[1:2]  # returns elements in 1 & 2 positions.
vec1[c(1,3)]  # returns elements in 1 & 3 positions
vec1[-1]  # returns all elements except in position 1.

# Sorting

sort(vec1)  # ascending sort
sort(vec1, decreasing = TRUE)  # Descending sort 

vec1[order(vec1)]  # ascending sort
vec1[rev(order(vec1))]  # descending sort

# Creating vector sequences and repetitions

seq(1, 10, by = 2)  # diff between adj elements is 2
seq(1, 10, length=25)  # length of the vector is 25
rep(2, 5)  # repeat 1, five times.
rep(1:3, 5)  # repeat 1:3, 5 times
rep(1:3, each=5)  # repeat 1 to 3, each 5 times.

# How To Remove Missing values

vec2 <- c("a", "b", "c", NA)  # character vector
is.na(vec2)  # missing TRUE
!is.na(vec2)  # missing FALSE
vec2 <- vec2[!is.na(vec2)]  # return non missing values from vec2

# Sampling

set.seed(1)  # optional. set it to get same random samples.
sample(vec1)  # sample all elements randomly
sample(vec1, 3)  # sample 3 elem without replacement
sample(vec1, 10, replace=T)  # sample with replacement
sample(vec1, 10, replace=F)  # sample without replacement

# Data Frames

myDf1 <- data.frame(vec1, vec2)  # make data frame with 2 columns
myDf2 <- data.frame(vec1, vec3, vec4)
myDf3 <- data.frame(vec1, vec2, vec3)

# Built-in Datasets and Basic Operations

library(datasets) # initialize
library(help=datasets) # display the datasets

# The below set of codes will be frequently used if you are going to 
# be playing around with data. 

class(airquality)  # get class
sapply(airquality, class)  # get class of all columns
str(airquality)  # structure
summary(airquality)  # summary of airquality
head(airquality)  # view the first 6 obs
fix(airquality)  # view spreadsheet like grid
rownames(airquality)  # row names
colnames(airquality)  # columns names
nrow(airquality)  # number of rows
ncol(airquality)  # number of columns

# Append data frames with cbind and rbind

cbind(myDf1, myDf2)  # columns append DFs with same no. rows
rbind(myDf1, myDf1)  # row append DFs with same no. columns

# Subset Data frame with number indices, subset() and which() methods

myDf1$vec1  # vec1 column
myDf1[, 1]  # df[row.num, col.num]
myDf2[, c(1,3)]  # columns 1 and 3
myDf1[c(1:5), c(2)]  # first 5 rows in column 2

# Below is a code that drops the Temp column from airquality data frame 
# and returns only those observations with Day=1. Note that the which() 
# is an independent function, therefore, the full object name must be used. 
# Just which(Day==1) will not work, since there is no variable called Day defined.

subset(airquality, Day == 1, select = -Temp)  # select Day=1 and exclude 'Temp'
airquality[which(airquality$Day==1), -c(4)]  # same as above

# Sampling

set.seed(100)
trainIndex <- sample(c(1:nrow(airquality)), size=nrow(airquality)*0.7, replace=F)  # get test sample indices
training <- airquality[trainIndex, ]  # training data
test <- airquality[-trainIndex, ]  # test data

# Merging Dataframes

merge(myDf1, myDf2, by="vec1")  # merge by 'vec1'

set.seed(100)
df1 = data.frame(StudentId = c(1:10), Subject = sample(c("Math", "Science", "Arts"), 10, replace=T))
df2 = data.frame(StudentNum = c(2, 4, 6, 12), Sport = sample(c("Football", "Tennis", "Chess"), 4, replace=T))

# The paste function

paste("a", "b")  # "a b"
paste0("a", "b")  # concatenate without space, "ab"
paste("a", "b", sep="*")  # same as paste0
paste(c(1:4), c(5:8), sep="")  # "15" "26" "37" "48"
paste(c(1:4), c(5:8), sep="", collapse="")  # "15263748"
paste0(c("var"), c(1:5))  # "var1" "var2" "var3" "var4" "var5"
paste0(c("var", "pred"), c(1:3))  # "var1" "pred2" "var3"
paste0(c("var", "pred"), rep(1:3, each=2))  # "var1" "pred1" "var2" "pred2" "var3" "pred3

# Dealing with dates

dateString <- "15/06/2014"
myDate <- as.Date(dateString, format="%d/%m/%Y")
class(myDate)  # "Date"
myPOSIXltDate <- as.POSIXlt(myDate)
class(myPOSIXltDate)  # POSIXlt
myPOSIXctDate <- as.POSIXct(myPOSIXltDate)  # convert to POSIXct

# How to view contents of an R object?

# If you come across a new type of R object that you are unfamiliar 
# with and want to see and access its contents, 
# typically one or more of these methods will work. 
# Lets take the example of the POSIXlt date object just created.

attributes(myPOSIXltDate)  # best
unclass(myPOSIXltDate)  # works!
names(myPOSIXltDate)  # doesn't work on a POSIXlt object
unlist(myPOSIXltDate)  # works!

# As you can notice, the POSIXlt object we just dissected does not 
# just contain the information displayed on the console when you type its name. 
# It is a good idea to check the object size to know if it has more 
# info that what meets the eye.

object.size(myDate)  # 216 bytes
object.size(myPOSIXltDate)  # 1816 bytes
object.size(myPOSIXctDate)  # 520 bytes

# How To Make Contingency Tables

table(myData)

table(airquality$Month[c(1:60)], airquality$Temp[c(1:60)]) # first 60/code>

# List

myList <- list(vec1, vec2, vec3, vec4)

#=> Output
#=> [[1]]
#=> [1] 10 20 15 40
#=> [[2]]
#=> [1] "a" "b" "c" NA
#=> [[3]]
#=> [1] TRUE FALSE TRUE TRUE
#=> [[4]]
#=> [1] l1 l2 l3 l4
#=> Levels: l1 l2 l3 l4

# Referencing lists

myList[3]  # level 1

# [[3]]

# [1] TRUE FALSE TRUE TRUE

myList[[3]]  # level 2: access the vec3 directly
#=> [1] TRUE FALSE TRUE TRUE
myList[[2]][3]  # 3rd elem of vec3
#=> [1] TRUE
lapply(myList, length)  # length of each element as a list

# Unlisting

# unlist()  # flattens out into a one-level list.
unlist(myList)[7]  # flattens out

# If-Else

if(checkConditionIfTrue) {
  # ....statements..
  # ....statements..
} else {   # place the 'else' in same line as '}'
  # ....statements..
  # ....statements..
} 

# For-Loop

# Where ever possible it is recommended to use one of 
# apply family functions for loops. However the knowledge is essential.


n <- 10
for(counterVar in c(1:n)){
  # .... statements..
}

# The apply family

# Problem statement: Create a character vector with length 
# of number-of-rows-of-iris-dataset, 
# such that, each element gets a value “greater than 5” 
# if corresponding ‘Sepal.Length’ > 5, else it gets “lesser than 5”.

# apply(): Apply FUN through a data frame or matrix by rows or columns.

myData <- matrix(seq(1,16), 4, 4)  # make a matrix
apply(myData, 1, FUN=min)  # apply 'min' by rows
#=> [1] 1 2 3 4

apply(myData, 2, FUN=max)  # apply 'max' by columns
#=> [1] 4 8 12 16

apply(data.frame(1:5), 1, FUN=function(x) {x^2})  # square of 1,2,3,4,5
      #=> [1] 1 4 9 16 25

# lapply(): Apply FUN to each element in a list(or) to columns of a data frame and return the result as a list

list1 <- lapply(airquality, class)  # return classes of each column in 'airquality' in a list

# sapply(): Apply FUN to each element of a list(or) to columns of a data frame and return the result as a vector.

# Lets look at an example to get the class of each column in a data frame.

sapply(airquality, class)  # return classes of each column in 'airquality'
#=>    Ozone    Solar.R      Wind      Temp     Month       Day
#=> "integer" "integer" "numeric" "integer" "integer" "integer"

# vapply(): Similar to sapply() but faster. You need to supply an additional FUN.
# VALUE argument that is a sample value of the returned output. 
# A sample value could be character(0) for a string, numeric(0) or 0L for a number,
# logical(0) for a boolean.. and so on.

x <- list(a = 1, b = 1:3, c = 10:100)  # make a list
vapply(x, FUN = length, FUN.VALUE = 0L)  # FUN.VALUE defines a sample format of output

# Error Handling

# Error suppression
options(show.error.messages=F) # turn off
1 <-1  #=> No error message is displayed.

options(show.error.messages=T) # turn it back on
1 <- 1
#=> Error in 1 <- 1 : invalid(do_set) left-hand side to assignment

# Without the error handling feature
for(i in c(1:10)) {
  1 <- 1 # trigger the error
print(i) # i equals 1. Never ran through full loop
}

# with try
for(i in c(1:10)) {
  triedOut <- try(1 <- 1) # try an error prone statement.
print(i) # i equals 10. Runs through full loop
}

# Further more, you can find out if an error did really occur by checking 
# for the class of stored triedOut variable. If an error really did occur, 
# it will have the class named try-error. You can get creative by having a 
# condition that checks the class of this variable, and take alternative measures.

class(triedOut) # "try-error"

# Error handling with tryCatch()

tryCatch({
        1 <- 1; 
        print("Lets create an error")
        }, # First block
        error=function(err){
           print(err); 
           print("Error Line")
          },  # Second Block(optional)
         finally = {
           print("finally print this")
           })# Third Block(optional)
#=> [1] "Lets create an error"
#=> <simpleError in 1 <- 1: invalid(do_set) left-hand side to assignment>
#=> [1] "Error Line"
#=> [1] "finally print this"

