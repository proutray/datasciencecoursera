library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
data <- filter(NEI, fips == "24510")
plot2data <- aggregate(data[4], by=list(data$year), FUN=sum, na.rm=TRUE)
plot2data$Emissions = plot2data$Emissions/1000 #converting tons to thousand tons.
plot(plot2data, type = "h", col = "blue", main = "Total Emission in Baltimore City, MD", xlab = "Year", ylab = "Emission (in thousand tons)" , xaxt = "n", lwd = 10)
axis(1,plot2data$Group.1)
dev.copy(png, "plot2.png", width=480, height=480, units="px")
dev.off()