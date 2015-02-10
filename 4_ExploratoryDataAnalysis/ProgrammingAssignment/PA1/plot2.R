library(lubridate)
library(datasets)
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                   colClasses = c(("character"),("character"),("character"),rep("NULL", 6)))
d1 <- data[grep("^1/2/2007$", data$Date),]
d2 <- data[grep("^2/2/2007$", data$Date),]
data <- rbind(d1,d2)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Date = dmy(data$Date)
data$timestamp <- strptime((paste(data$Date, data$Time)), format="%Y-%m-%d %H:%M:%S")
plot(data$timestamp, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, "plot2.png", width=480,height=480,units="px",bg = "transparent")
dev.off()