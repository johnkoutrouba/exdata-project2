# Course Project 2, Question 6
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
baltautos$city <- "Baltimore"
laautos <- autos[autos$fips == "06037",]
laautos$city <- "LA"
balttotal <- ddply(baltautos, .(year, city), summarise
                   , totemissions = sum(Emissions, na.rm = TRUE))
balttotal$totemissions <- balttotal$totemissions - mean(balttotal$totemissions)
latotal <- ddply(laautos, .(year, city), summarise
                   , totemissions = sum(Emissions, na.rm = TRUE))
latotal$totemissions <- latotal$totemissions - mean(latotal$totemissions)
baltlatotal <- rbind(balttotal, latotal)

## Plot Data
library(ggplot2)
png("plot6.png")
g <- ggplot(baltlatotal, aes(x = year, y = totemissions))
g <- g + geom_line(aes(color = city)) 
g <- g + geom_smooth(method = "lm", aes(color = city), linetype = "dashed", se = FALSE)
g + labs(x = "Year"
              , y = "Mean Differenced Total Emissions (Tons)"
              , title = "Auto Emissions in Baltimore Declined More Than in LA 2000 - 2008")
dev.off()