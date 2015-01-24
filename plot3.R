# Course Project 2, Question 3
## Download Data and Read Data
download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        , destfile = "proj2data.zip"
        , method = "curl"
)
unzip("proj2data.zip")
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

## Process Data
library(plyr)
balttype <- ddply(nei[nei$fips == "24510",], .(year, type), summarise
                   , total_emissions = sum(Emissions, na.rm = TRUE))
balttype$type <- as.factor(balttype$type)

## Plot Data
library(ggplot2)
png("plot3.png")
g <- ggplot(balttype, aes(x = year, y = total_emissions))
g + facet_grid(. ~ type) + geom_line() + labs(x = "Year"
                                              , y = "Total Emissions (Tons)"
                                              , title = "All Types Except Point Declined 2000 - 2008")
dev.off()