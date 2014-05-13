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

#Make the first plot the histogram of global active power
png(filename="plot1.png", bg= "transparent")
hist(myData$Global_active_power, xlab="Global Active Power (kilowatts)", main= "Global Active Power", col="red")
dev.off()
