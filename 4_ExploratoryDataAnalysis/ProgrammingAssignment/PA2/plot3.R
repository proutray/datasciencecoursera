library(dplyr)
library(ggplot2) 
NEI <- readRDS("summarySCC_PM25.rds")
data <- filter(NEI, fips == "24510")
plot3data <- aggregate(data[4], by=list(data$year, data$type), FUN=sum, na.rm=TRUE)
yrange = range(0,plot3data$Emissions)
ggplot(plot3data, aes(plot3data$Group.1[1:4], fill = 'LEGEND')) + 
  scale_x_continuous( breaks=c(1999,2002,2005,2008)) +
  geom_line(aes(y = plot3data$Emissions[1:4], colour = "NONPOINT")) + 
  geom_line(aes(y = plot3data$Emissions[5:8], colour = "NON-ROAD")) + 
  geom_line(aes(y = plot3data$Emissions[9:12], colour = "ON-ROAD")) + 
  geom_line(aes(y = plot3data$Emissions[13:16], colour = "POINT")) + 
  theme(axis.ticks.x = element_line(size = 1))+xlab("Year")+ylab("Total emission (in tons)") 
ggsave("plot3.png")
