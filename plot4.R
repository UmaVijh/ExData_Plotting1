setwd("~/Documents/Coursera/ExploratoryDataAnalysis/Project1")
library("sqldf")
# Url at which the data set is located
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Download zip file
download.file(fileUrl, destfile="household_power_consumption.zip", method="curl")
require("sqldf")
myfile <- "household_power_consumption.txt"
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
myData <- read.csv2.sql(myfile, mySql, colClasses = "character", na.string="?")

myData$DateTime <- strptime(paste(myData$Date,myData$Time), "%d/%m/%Y %H:%M:%S")

#Make the fourth plot 
png(filename="plot4.png", bg= "transparent")

par(mfrow=c(2,2)) #Makes a 4X4 plot

#top right: Global Active Power as a function of the day/time
plot(myData$DateTime,myData$Global_active_power, ylab="Global Active Power", xlab = "", type="l")

#top left: Voltage as a function of the day/time
plot(myData$DateTime,myData$Voltage, ylab="Voltage", xlab = "datetime", type="l")

#bottom right: the energy submetering as a function of the day/time
plot(myData$DateTime,myData$Sub_metering_1, ylab="Energy sub metering", xlab = "", type="l")
lines(myData$DateTime,myData$Sub_metering_2,col="red")
lines(myData$DateTime,myData$Sub_metering_3,col="blue")
legend("topright", lty=1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

#bottom left: Global Reactive Power as a function of day/time
plot(myData$DateTime,myData$Global_reactive_power, ylab="Global_rective_power", xlab = "datetime", type="l")
dev.off()