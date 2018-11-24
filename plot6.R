## Exploratory Data Analysis
## Coursera / JHU
## Peer Graded Assignment #2

## plot6

## import ggplot2 and dplyr
library(ggplot2)
library(dplyr)

## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract vehicle-related SCC numbers
keep <- grep("Vehicle", SCC$EI.Sector, ignore.case = TRUE)
SCC_car <- SCC[keep,]
SCC_codes <- SCC_car$SCC

## Extract Baltimore and LA data
car_data <- subset(NEI, NEI$SCC %in% SCC_codes)
car_cities <- subset(car_data, car_data$fips == "24510" | car_data$fips == "06037")

## Sum emissions data
totalbyyear <- aggregate(Emissions ~ year + fips, data=car_cities, FUN=sum)

## Change fips names to actual city names
totalbyyear[totalbyyear$fips=="06037",]$fips <- "Los Angeles County, California"
totalbyyear[totalbyyear$fips=="24510",]$fips <- "Baltimore City, Maryland"

## Plot
png("plot6.png", width=900, height=480)
g <- ggplot(totalbyyear, aes(year, Emissions))
plot6 <- g + facet_wrap(.~fips, scales='free') + 
        geom_smooth(method="lm", se=FALSE, aes(color="Linear Model")) +
        geom_point(size=5) +
        geom_line(linetype=2) +
        xlab("Year") +
        ylab(expression("Total PM"[2.5]* " Emitted (Tons)")) +
        ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore City, Maryland and Los Angeles County, California") +
        scale_color_manual(name = "Legend", values="blue") +
        theme(strip.text.x = element_text(size = 12)) +
        theme(plot.title = element_text(face="bold", hjust=0.5, size=14)) + 
        theme(axis.text = element_text(size=12)) +
        theme(axis.title = element_text(size=14))
print(plot6)
dev.off()
