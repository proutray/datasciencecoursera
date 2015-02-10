NEI <- readRDS("summarySCC_PM25.rds")
plot1data <- aggregate(NEI[4], by=list(NEI$year), FUN=sum, na.rm=TRUE)
plot1data$Emissions = plot1data$Emissions/1000000 #converting tons to million tons.
plot(plot1data$Group.1, plot1data$Emissions, type = "h", col = "red", main = "Total Emission", xlab = "Year", ylab = "Emission (in million tons)" , xaxt = "n", lwd = 10)
axis(1,plot1data$Group.1)
dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()