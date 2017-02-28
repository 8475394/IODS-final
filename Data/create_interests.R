# Author: Heidi Maanonen
# Date: 27.2.2017

# File description: Data wrangling for the final assignment in IODS-course

# Data source: "Young People Survey" from Kaggle, https://www.kaggle.com/miroslavsabo/young-people-survey

library(tidyr)
library(readr)
library(dplyr)

# Reading the data from my computer
young_people <- read.table(file.path("C:/Users/heidi/Documents/YLIOPISTO/TILASTOTIEDE/INTRODUCTION TO OPEN DATA SCIENCE/IODS-final/data", "raw_young_people_survey.csv"),
                           header = TRUE, sep = ",")

# Exploring the content
str(young_people) # Original data contains 1010 observations and 150 variables
colnames(young_people) # checking the column names to see the correct names of variables

# Choosing varibales considering young people interests and hobbies and some of demographics
keep_interest <- c("History", "Psychology", "Politics", "Mathematics", "Physics", "Internet", "PC",
                   "Economy.Management", "Biology", "Chemistry", "Reading", "Geography", "Foreign.languages",
                   "Medicine", "Law", "Cars", "Art.exhibitions", "Religion", "Countryside..outdoors", "Dancing",
                   "Musical.instruments", "Writing", "Passive.sport", "Active.sport", "Gardening", "Celebrities",
                   "Shopping", "Science.and.technology", "Theatre", "Fun.with.friends", "Adrenaline.sports", "Pets",
                   "Age", "Gender")

# Selecting the variables of interestst and hobbies + age and gender
interest1 <- select(young_people, one_of(keep_interest))

# Verifying the content the kept and selected variables
str(interest1) # 1010 observations and 34 variables


# Renaming some variables to shorter and some to more descriptive 
interest2 <- rename(interest1,
                    Economy = Economy.Management,
                    rPoetry = Reading,
                    Languages = Foreign.languages,
                    Art = Art.exhibitions,
                    Outdoor = Countryside..outdoors,
                    Instruments = Musical.instruments,
                    wPoetry = Writing,
                    sLeisure = Passive.sport,
                    sCompetitive = Active.sport,
                    SciTec = Science.and.technology,
                    Social = Fun.with.friends,
                    sAdrenaline = Adrenaline.sports)

# Verifying the column names and dimensions
colnames(interest2) # everything is ok
dim(interest2) # still 1010 observations and 34 variables


# Exploring if the data contains any missing values
complete.cases(interest2) # there are missing values but how much?
table(is.na(interest2)) # there are 163 missing value


# Removing the rows with missing values
comp1 <- complete.cases(interest2)
interest <- filter(interest2, comp1 == TRUE)
complete.cases(interest) # verifying that all cases are TRUE
dim(interest) # Now there are 881 observations and 34 variables


# Saving the the datset to the data folder
setwd("C:/Users/heidi/Documents/YLIOPISTO/TILASTOTIEDE/INTRODUCTION TO OPEN DATA SCIENCE/IODS-final/data")
getwd() # Verifying the path

# Saving the dataset
write.table(interest, file = "interests_dem.txt") # saving
interests <- read.table("interests_dem.txt", header = TRUE) # reading
str(interests) # and again verifying and everything seem to right


# DATA WRANGLING PART 2

# I noticed that the gender factor contains the third empty category, which wasn't assigned to NA, it was just empty

# Recoding empty values as NA:s
recode <- c(male = "male", female = "female")
(interests_dem$Gender <- factor(interests_dem$Gender, levels = recode, labels = names(recode)))

# Verifying that 3 of the values belong to NA:s
table(is.na(interests_dem$Gender)) # Now there are 3 NA:s

# Removing the "new" rows with missing values
comp2 <- complete.cases(interests_dem)
comp2
int <- filter(interests_dem, comp2 == TRUE)
complete.cases(int) # verifying that all cases are TRUE
dim(int) # Now there are 8 observations and 34 variables


# Saving the dataset again
write.table(int, file = "interests_dem.txt") # saving
Hobbies <- read.table("interests_dem.txt", header = TRUE) # reading
str(Hobbies) # Yes, i did it. Gender has now two levels

