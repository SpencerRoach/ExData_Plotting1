## Read the data in as a data frame stored under the name "raw_data".
raw_data <- read.table("household_power_consumption.txt", header = TRUE, 
                       sep = ";", na.strings = "?")

## Convert Date column in raw_data from class "character" to class "POSIXlt"
raw_data$Date <- strptime(raw_data$Date, format = "%d/%m/%Y")

## Load dplyr package, then using filter() function retrieve only data from 
## Feb 1 2007 and Feb 2 2007. Store as a new data frame called "table".
library(dplyr)
table <- filter(raw_data, Date == "2007-02-01 CST" | Date == "2007-02-02 CST")

## Combine the Date and Time columns into a single column called "DateTime", 
## then convert DateTiem from class "character" to class "POSIXlt"
DateTime <- paste(table$Date, table$Time)
table$DateTime <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")

## Create the desired plot, and copy it over to a png file named "plot4.png".  
par(mfrow = c(2, 2), mar = c(5, 4, 4, 2), cex = 0.7)
with(table, plot(DateTime, Global_active_power, type = "l", 
                  xlab = "", ylab = "Global Active Power"))
with(table, plot(DateTime, Voltage, type = "l", 
                  xlab = "datetime", ylab = "Voltage"))
with(table, plot(DateTime, Sub_metering_1, type = "l", col = "black", 
                  xlab = "", ylab = "Energy sub metering"))
lines(table$DateTime, table$Sub_metering_2, type = "l", col = "red")
lines(table$DateTime, table$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")
with(table, plot(DateTime, Global_reactive_power, type = "l", 
                  xlab = "datetime", ylab = "Global_reactive_power"))
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()