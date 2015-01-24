# Course Project 2, Question 1
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
neitotal <- ddply(nei, .(year), summarise
                  , total_emissions = sum(Emissions, na.rm = TRUE))

## Plot Data
png("plot1.png")
plot(neitotal$year, neitotal$total_emissions, type = "l"
     , xlab = "Year", ylab = "Total Emissions (Tons)"
     , main = "Total Emissions Decreased from 2000 - 2008"
)
dev.off()