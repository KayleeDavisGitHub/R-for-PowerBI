# PowerBI Notes:
# Load Data from R Script
#   - check working directory because by default it will not know from script.
#   - Avoid load times longer than 30mins.
#   - Avoid interfaces or user checks, as this will interrupt the PBI upload.
# Select all data sources you wish to load.
#   - At this point in time you can edit the data and make any last-minute changes
# Select "R" under the graphs option for including any R Graphs you had built.
#   - select all data used in creation of graph (multiple variables if whole dataset)
#   - use the renamed variable defined by the comment upon creating graph object
#   - Note (currently) the only way to make these interactive is by using HTML
#   - Yet, graph will update as data refreshes (remember the R data pull script!)



# Load packages in a far too fancy of a way, suppressing warnings helps PowerBI
packages <- c("haven", "dplyr")
suppressWarnings( lapply(packages, require, character.only = TRUE) )
rm(packages) # remove packages list

## Read data - Make sure to set working directory full path
beer.dta <- read_dta(file = "beer.dta")
beer.dta <- as.data.frame(beer.dta) # PBI works best with data.frame data

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

# Making a function to better sort data into columns rather than identity matrix
flattenCorrMatrix <- function(cormat, pmat) { #Takes cor.matrix, p.matrix
     ut <- upper.tri(cormat)                  #Upends it, then puts in df
     data.frame(
          row = rownames(cormat)[row(cormat)[ut]],
          column = rownames(cormat)[col(cormat)[ut]],
          cor  =(cormat)[ut],
          p = pmat[ut]
     )
}


library(Hmisc)
hmisc_cor <- rcorr(as.matrix(beer.dta[,3:10]))

# Let's make another dataset for these correlation values we can upload to PBI
cor_data <- flattenCorrMatrix(hmisc_cor$r, hmisc_cor$P)

## Set up Graphs for PowerBI:
library(corrplot)
corrplot(hmisc_cor$r, order="hclust", tl.col = "black",
         tl.pos = "d", type = "upper", method = "number",
         p.mat = hmisc_cor$P, sig.level = 0.01, insig = "blank")
# Remove environment object not used beyond this point. We can always recalculate in PBI using R.
rm(hmisc_cor)

## So then the example graph above would use the following PowerBI Conversion to read the graph:

# The following code to create a dataframe and remove duplicated rows is always executed and acts as a preamble for your script:
# dataset <- data.frame(cor)
# dataset <- unique(dataset)
# Paste or type your script code here:
#library(corrplot)
#library(Hmisc)

#hmisc_cor <- rcorr(as.matrix(dataset))

## Set up Graphs for PowerBI:
#corrplot(hmisc_cor$r, order="hclust", tl.col = "black", tl.pos = "d", type = "upper", method = "number",
#         p.mat = hmisc_cor$P, sig.level = 0.01, insig = "blank")

