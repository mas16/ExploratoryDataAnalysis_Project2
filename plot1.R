## Exploratory Data Analysis
## Coursera / JHU
## Peer Graded Assignment #2

## plot1

## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Sum of emitted PM2.5 by year
totalbyyear <- tapply(NEI$Emissions, NEI$year, sum)

## Convert tons to kilotons to make y-axis more readable
total_kilo <- totalbyyear / 1000

## Make color gradient 
grayscale <- 1-total_kilo/max(total_kilo)+0.4
grayscale <- gray(grayscale)

## Plot
png("plot1.png")
barplot(total_kilo, xlab="Year", ylab = expression("Total PM"[2.5]* " Emitted (kiloTons)"), 
        main="United States Total PM2.5 Emissions by Year", col=grayscale)
dev.off()