# Course Project 2, Question 2
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
balttotal <- ddply(nei[nei$fips == "24510",], .(year), summarise
                  , total_emissions = sum(Emissions, na.rm = TRUE))

## Plot Data
png("plot2.png")
plot(balttotal$year, balttotal$total_emissions, type = "l"
     , xlab = "Year", ylab = "Total Emissions (Tons)"
     , main = "Baltimore Emissions Decreased from 2000 - 2008"
)
dev.off()