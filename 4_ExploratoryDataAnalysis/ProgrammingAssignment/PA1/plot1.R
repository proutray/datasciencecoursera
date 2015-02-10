library(datasets)
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                   colClasses = c(("character"),("NULL"),("character"),rep("NULL", 6)))
d1 <- data[grep("^1/2/2007$", data$Date),]
d2 <- data[grep("^2/2/2007$", data$Date),]
data <- rbind(d1,d2)
data$Global_active_power <- as.numeric(data$Global_active_power)
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     col = "red")
dev.copy(png, "plot1.png", width=480,height=480,units="px",bg = "transparent")
dev.off()
