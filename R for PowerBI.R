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



## Set up additional data table for PowerBI:


## Set up Graphs for PowerBI: