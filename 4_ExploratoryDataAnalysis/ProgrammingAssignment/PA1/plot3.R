library(lubridate)
library(datasets)
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                   colClasses = c(("character"),("character"),rep("NULL", 4),rep("character",3)))
d1 <- data[grep("^1/2/2007$", data$Date),]
d2 <- data[grep("^2/2/2007$", data$Date),]
data <- rbind(d1,d2)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Date = dmy(data$Date)
data$timestamp <- strptime((paste(data$Date, data$Time)), format="%Y-%m-%d %H:%M:%S")
yrange <- range(0,data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3)
plot(data$timestamp, data$Sub_metering_1, type="l", ylim=yrange, xlab = "", ylab = "Energy sub metering")
lines(data$timestamp, data$Sub_metering_2, type="l", col = "blue", ylim=yrange)
lines(data$timestamp, data$Sub_metering_3, type="l", col = "red", ylim=yrange)
legend("topright", c("sub_metering_1","sub_metering_2","sub_metering_3"), cex=0.8, col=c("black", "blue","red"), lty=1, bty="n");
dev.copy(png, "plot3.png", width=480,height=480,units="px",bg = "transparent")
dev.off()