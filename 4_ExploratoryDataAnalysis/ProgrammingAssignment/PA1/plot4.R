library(lubridate)
library(datasets)
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                   colClasses = c(rep("character", 5),("NULL"),rep("character",3)))
d1 <- data[grep("^1/2/2007$", data$Date),]
d2 <- data[grep("^2/2/2007$", data$Date),]
data <- rbind(d1,d2)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

#Combining date and time
data$Date = dmy(data$Date)
data$timestamp <- strptime((paste(data$Date, data$Time)), format="%Y-%m-%d %H:%M:%S")

yrange <- range(0,data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3)

par( mfrow = c( 2, 2 ) )
## Plot1
plot(data$timestamp, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
## Plot2
plot(data$timestamp, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
## Plot3
plot(data$timestamp, data$Sub_metering_1, type="l", ylim=yrange, xlab = "", ylab = "Energy sub metering")
lines(data$timestamp, data$Sub_metering_2, type="l", col = "blue", ylim=yrange)
lines(data$timestamp, data$Sub_metering_3, type="l", col = "red", ylim=yrange)
legend("topright", c("sub_metering_1","sub_metering_2","sub_metering_3"), cex=0.35, col=c("black", "blue","red"), lty=1, bty="n");
##Plot4
plot(data$timestamp, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.copy(png, "plot4.png", width=480,height=480,units="px",bg = "transparent")
dev.off()
