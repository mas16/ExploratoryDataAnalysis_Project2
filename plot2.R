## Exploratory Data Analysis
## Coursera / JHU
## Peer Graded Assignment #2

## plot2

## Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Isolate baltimore data by fips == 24150
balt_data <- subset(NEI, NEI$fips=="24510")

## Sum of emitted PM2.5 by year
balt_totalbyyear <- tapply(balt_data$Emissions, balt_data$year, sum)
## Convert tons to kilotons to make y-axis more readable
balt_kilo <- balt_totalbyyear / 1000

## Make color gradient 
grayscale <- 1-balt_kilo/max(balt_kilo)+0.4
grayscale <- gray(grayscale)

## Plot
png("plot2.png")
barplot(balt_kilo , xlab="Year", ylab = expression("Total PM"[2.5]* " Emitted (kiloTons)"), 
        main="Baltimore City, Maryland Total PM2.5 Emissions by Year", col=grayscale)
dev.off()