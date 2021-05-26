#
# R file for cleaning data for PowerBI Dashboard
# < https://www.linkedin.com/in/kyledavisln/ >
# Kyle Davis
#

# Packages used:
library(haven)
library(dplyr)

# Read data
beer.dta <- read_dta(file = "beer.dta")


## Data Cleaning:
# Rename some variables to be more intuitive
beer.dta$regional <-  beer.dta$avail
beer.dta$us_made <- beer.dta$us

# Remove data not used:
beer.dta <- subset(beer.dta, select = -c(avail, us, good, verygood, origin))

# I'm also upset that Guinness is not in this data so I'll add it in here:
beer.dta[36,] <- list(1, "Guinness", 7.99, .67, 125, 10, 4.2, 1, 1, 3, 0, 0)

# I guess we'll balance it out with a very bad beer:
beer.dta[37,] <- list(3, "Keystone Light", 1.08, .08, 101, 0, 4.2, 1, 1, 1, 0, 1)


## Set up additional data table for PowerBI:




## Set up Graphs for PowerBI: