## Exploratory Data Analysis
## Coursera / JHU
## Peer Graded Assignment #2

## plot3

## import ggplot2 and dplyr
library(ggplot2)
library(dplyr)

## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Isolate baltimore data by fips == 24150
balt_data <- subset(NEI, NEI$fips=="24510")

## Sum emissions by year and type
balt_agg <- aggregate(Emissions ~ year + type, data=balt_data, FUN=sum)
## Convert tons to kilotons to make y-axis more readable but keep as dataframe
balt_aggkt <- mutate(balt_agg, EmissionskT = Emissions/1000)

## Plot
png("plot3.png", width = 900, height = 480)
g <- ggplot(balt_aggkt, aes(year, EmissionskT))
plot3 <- g + facet_grid(. ~ type) + 
        geom_smooth(method="lm", se=FALSE, aes(color="Linear Model")) +
        geom_line(linetype=2) +
        geom_point(size=3) +
        xlab("Year") +
        ylab(expression("Total PM"[2.5]* " Emitted (kiloTons)")) +
        ggtitle("Baltimore City, Maryland Total PM2.5 Emissions by Year and Type") +
        scale_color_manual(name = "Legend", values="blue") +
        theme(plot.title = element_text(face="bold", hjust=0.5, size=14)) + 
        theme(axis.text = element_text(size=12)) +
        theme(axis.title = element_text(size=14))

print(plot3)
dev.off()