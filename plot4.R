# Course Project 2, Question 4
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
coalsources <- scc[grep("Coal", scc$Short.Name),]
coalnei <- join(nei, coalsources, by = c("SCC"), type = "inner")
coaltotal <- ddply(coalnei, .(year), summarise
                  , total_emissions = sum(Emissions, na.rm = TRUE))

## Plot Data
library(ggplot2)
png("plot4.png")
g <- ggplot(coaltotal, aes(x = year, y = total_emissions))
g + geom_line() + labs(x = "Year"
                       , y = "Total Emissions (Tons)"
                       , title = "Coal Emissions Declined 2000 - 2008")
dev.off()