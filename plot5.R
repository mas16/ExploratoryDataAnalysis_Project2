## Exploratory Data Analysis
## Coursera / JHU
## Peer Graded Assignment #2

## plot5

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

## Extract Baltimore data
car_data <- subset(NEI, NEI$SCC %in% SCC_codes & NEI$fips=="24510")

## Sum emissions
totalbyyear <- aggregate(Emissions ~ year, data=car_data, FUN=sum)

## Plot
png("plot5.png", width = 600, height = 480)
g <- ggplot(totalbyyear, aes(year, Emissions))
plot5 <- g + geom_smooth(method="lm", se=FALSE, aes(color="Linear Model")) +
        geom_point(size=3) +
        ylim(0,450) +
        xlab("Year") +
        ylab(expression("Total PM"[2.5]* " Emitted (Tons)")) +
        ggtitle("Total Motor Vehicle PM2.5 Emissions in Baltimore City, Maryland by Year") +
        scale_color_manual(name = "Legend", values="blue") +
        theme(plot.title = element_text(face="bold", hjust=0.5, size=14)) + 
        theme(axis.text = element_text(size=12)) +
        theme(axis.title = element_text(size=14))
print(plot5)
dev.off()