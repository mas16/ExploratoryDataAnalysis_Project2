## Exploratory Data Analysis
## Coursera / JHU
## Peer Graded Assignment #2

## plot4

## import ggplot2 and dplyr
library(ggplot2)
library(dplyr)

## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract coal-related SCC numbers
keep <- grep("Coal", SCC$EI.Sector, ignore.case = TRUE)
SCC_coal <- SCC[keep,]
SCC_codes <- SCC_coal$SCC

## Extract coal-related PM25 data
coal_data <- subset(NEI, NEI$SCC %in% SCC_codes)

## Sum Emissions from coal-related sources
totalbyyear <- aggregate(Emissions ~ year, data=coal_data, FUN=sum)
total_kilo <- mutate(totalbyyear, EmissionskT = Emissions / 1000)

## Plot
png("plot4.png", width = 600, height = 480)
g <- ggplot(total_kilo, aes(year, EmissionskT))
plot4 <- g + geom_smooth(method="lm", se=FALSE, aes(color="Linear Model")) +
        geom_point(size=3) +
        ylim(200,800) +
        xlab("Year") +
        ylab(expression("Total PM"[2.5]* " Emitted (kiloTons)")) +
        ggtitle("Total Coal PM2.5 Emissions by Year") +
        scale_color_manual(name = "Legend", values="blue") +
        theme(plot.title = element_text(face="bold", hjust=0.5, size=14)) + 
        theme(axis.text = element_text(size=12)) +
        theme(axis.title = element_text(size=14))
print(plot4)
dev.off()