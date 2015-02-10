# Reproducible Research: Peer Assessment 2
Piyush Routray @p_routray [12-01-2015]  
###Synopsis: 
As a part of coursework on Coursera, provided by the JHU, this report tries to analyze the storm data and help answer the following questions regarding effect of a particular kind of storm event on lives and economy of the United States of America.
1. Across the USA, which of the events are most harmful with respect to population health?
from the given data, we add the number of *deaths* and *injuries* to get to the final number.
2. Across the USA, which of the events have the greatest economic consequences?
from the given data, we add the amount of *property and crops damaged.* Each data was multiplied by the factors ((k)thousand, (m)million or (b)billion) as per the explanation. [NOTE: *Unrecognised factors were assumed to be typos and replaced with 1.*]

###Data Processing:

```r
data <- read.csv(bzfile('repdata_data_StormData.csv.bz2'), strip.white=TRUE)
#Processing for 1st part
#==========================

data$EVTYPE <- tolower(data$EVTYPE);
data$FATALITIES <- as.numeric(data$FATALITIES); data$INJURIES <- as.numeric(data$INJURIES)
data$POPULATIONHEALTH <- data$FATALITIES + data$INJURIES
#Choosing relevant columns ONLY
data1 <- data.frame(data$EVTYPE, data$POPULATIONHEALTH) 

#Processing for 2nd part
#==========================
  
data$PROPDMG <- as.numeric(data$PROPDMG)
#Converting k to 1000, m to million , b to billion and all other to 1 for Property Damage explanation
data$PROPDMGEXP <- tolower(data$PROPDMGEXP)
data$PROPDMGEXP[is.na(data$PROPDMGEXP)] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == ""] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "-"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "+"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "?"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "h"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "0"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "2"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "3"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "4"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "5"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "6"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "7"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "8"] <- 1
data$PROPDMGEXP[data$PROPDMGEXP == "k"] <- 1000 #thousand
data$PROPDMGEXP[data$PROPDMGEXP == "m"] <- 1000000 #million
data$PROPDMGEXP[data$PROPDMGEXP == "b"] <- 1000000000 #billion
data$PROPDMGEXP <- as.numeric(data$PROPDMGEXP)

data$CROPDMG = as.numeric(data$CROPDMG)
#Converting k to 1000, m to million , b to billion and all other to 1 for Crop Damage explanation
data$CROPDMGEXP <- tolower(data$CROPDMGEXP)
data$CROPDMGEXP[data$CROPDMGEXP == ""] <- 1
data$CROPDMGEXP[data$CROPDMGEXP == "?"] <- 1
data$CROPDMGEXP[data$CROPDMGEXP == "0"] <- 1
data$CROPDMGEXP[data$CROPDMGEXP == "2"] <- 1
data$CROPDMGEXP[data$CROPDMGEXP == "k"] <- 1000
data$CROPDMGEXP[data$CROPDMGEXP == "m"] <- 1000000
data$CROPDMGEXP[data$CROPDMGEXP == "b"] <- 1000000000
data$CROPDMGEXP = as.numeric(data$CROPDMGEXP)
data$EconomicDamage = (data$PROPDMG * data$PROPDMGEXP) + (data$CROPDMG * data$CROPDMGEXP)
data2 <- data.frame(data$EVTYPE, data$EconomicDamage)
rm(data)#Free the memory
```

###Results:

1. Across the USA, the following types of events are most harmful with respect to population health:

```r
names(data1)[1] <- "Event"; names(data1)[2]<- "PopulationHealth" #Renaming the columns

#Renaming certain particular values
data1$Event[data1$Event == "rip currents"] = "rip current"
data1$Event[data1$Event == "thunderstorm winds"] = "thunderstorm wind"

aggr_data1 <- aggregate(cbind(data1$PopulationHealth), by = list(category = data1$Event), FUN = sum)
ordrd_data1 <- aggr_data1[order(aggr_data1$V1, decreasing = T),]

output1 <- head(ordrd_data1, 20); rownames(output1) <- NULL
output1$V1 <- round(output1$V1/1000, digits = 2)
names(output1)[1] <- "Name_of_theEvent"; names(output1)[2] <- "Number_of1000People_affected"
output1$Name_of_theEvent = as.character(output1$Name_of_theEvent)
output1$Number_of1000People_affected = as.numeric(output1$Number_of1000People_affected)

output1
```

```
##     Name_of_theEvent Number_of1000People_affected
## 1            tornado                        96.98
## 2     excessive heat                         8.43
## 3          tstm wind                         7.46
## 4              flood                         7.26
## 5          lightning                         6.05
## 6               heat                         3.04
## 7        flash flood                         2.75
## 8  thunderstorm wind                         2.59
## 9          ice storm                         2.06
## 10      winter storm                         1.53
## 11         high wind                         1.38
## 12              hail                         1.38
## 13 hurricane/typhoon                         1.34
## 14        heavy snow                         1.15
## 15       rip current                         1.10
## 16          wildfire                         0.99
## 17          blizzard                         0.91
## 18               fog                         0.80
## 19  wild/forest fire                         0.56
## 20         heat wave                         0.55
```

The above is a list of 20 most harmful weather events which affect human population. 

Plotting the data of **top 20 events with maximum effect on people's lives**

```r
plot(Number_of1000People_affected~factor(Name_of_theEvent), output1, las = 2, xlab = "", ylab = "* 1000 people affected", main = "Top 20 Events with maximum effect on people's lives")
```

![](PA2_template_files/figure-html/unnamed-chunk-3-1.png) 

2. Across the USA, the following types of events have the greatest economic consequences: 

```r
names(data2)[1]<- "Event"; names(data2)[2]<- "EconomicDamage" #Renaming the columns
aggr_data2 <- aggregate(cbind(data2$EconomicDamage), by = list(category = data2$Event), FUN = sum)
ordrd_data2 <- aggr_data2[order(aggr_data2$V1, decreasing = T),]

output2 <- head(ordrd_data2, 20); rownames(output2) <- NULL
output2$V1 <- round(output2$V1/1000000000, digits = 2)
names(output2)[1] <- "Name_of_Event"; names(output2)[2] <- "Loss_in_billion_dollars"
output2$Name_of_Event <- as.character(output2$Name_of_Event)
output2$Loss_in_billion_dollars <- as.numeric(output2$Loss_in_billion_dollars)
output2
```

```
##                Name_of_Event Loss_in_billion_dollars
## 1                      flood                  150.32
## 2          hurricane/typhoon                   71.91
## 3                    tornado                   57.35
## 4                storm surge                   43.32
## 5                       hail                   18.76
## 6                flash flood                   17.56
## 7                    drought                   15.02
## 8                  hurricane                   14.61
## 9                river flood                   10.15
## 10                 ice storm                    8.97
## 11            tropical storm                    8.38
## 12              winter storm                    6.72
## 13                 high wind                    5.91
## 14                  wildfire                    5.06
## 15                 tstm wind                    5.04
## 16          storm surge/tide                    4.64
## 17         thunderstorm wind                    3.90
## 18            hurricane opal                    3.19
## 19          wild/forest fire                    3.11
## 20 heavy rain/severe weather                    2.50
```

Plotting the data of ** top 20 events with maximum economic consequences**

```r
plot(Loss_in_billion_dollars~factor(Name_of_Event), output2, las = 2, xlab = "", ylab = "Loss in billion $", main = "Top 20 Events with Maximum Economic Consequences")
```

![](PA2_template_files/figure-html/unnamed-chunk-5-1.png) 
