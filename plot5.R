# Course Project 2, Question 5
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
autosources <- scc[scc$Data.Category == "Onroad",]
autos <- join(nei, autosources, by = c("SCC"), type = "inner")
baltautos <- autos[autos$fips == "24510",]
balttotal <- ddply(baltautos, .(year), summarise
                   , total_emissions = sum(Emissions, na.rm = TRUE))

## Plot Data
library(ggplot2)
png("plot5.png")
g <- ggplot(balttotal, aes(x = year, y = total_emissions))
g + geom_line() + labs(x = "Year"
                       , y = "Total Emissions (Tons)"
                       , title = "Auto Emissions in Baltimore Declined 2000 - 2008")
dev.off()