setwd("~/Documents/Coursera/ExploratoryDataAnalysis/Project1")
library("sqldf")
# Url at which the data set is located
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Download zip file
if(!file.exists("./exdata-data-household_power_consumption.zip")){
    download.file(fileUrl, destfile="household_power_consumption.zip", method="curl")
    }
if(!file.exists("./household_power_consumption.txt")){
    unzip("./exdata-data-household_power_consumption.zip", exdir="./")
    }
require("sqldf")
myfile <- "household_power_consumption.txt"
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv2.sql(myfile, mySql, colClasses = "character", na.string="?")

myData$DateTime <- strptime(paste(myData$Date,myData$Time), "%d/%m/%Y %H:%M:%S")

#Make the second plot the global active power as a function of the day
png(filename="plot2.png", bg= "transparent")
plot(myData$DateTime,myData$Global_active_power, ylab="Global Active Power (kilowatts)", xlab = "", type="l")
dev.off()
