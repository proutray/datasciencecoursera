library(dplyr)
#Read the raw data
traindata <- read.table("train/X_train.txt", stringsAsFactors = F)
testdata <- read.table("test/X_test.txt", stringsAsFactors = F)

#Read the list of activities done.
trname <- read.table("train/y_train.txt")
tename <- read.table("test/y_test.txt")

#Read the subject number.
subtest <- read.table("test/subject_test.txt")
subtrain <- read.table("train/subject_train.txt")

#Read the label and features data set
label <- read.table("activity_labels.txt")
features <- read.table("features.txt", stringsAsFactors = F)

#Update Column Names
feat <- c(features$V2)
colnames(testdata) <- feat
colnames(traindata) <- feat

#Update the activity list with name of activity.
for (i in 1:nrow(trname)){
  trname$V1[i] <- (as.character(label$V2[label$V1 == trname$V1[i]]))
}
for (i in 1:nrow(tename)){
  tename$V1[i] <- (as.character(label$V2[label$V1 == tename$V1[i]]))
}

#Add the number of subject and name of the activities to data.
testdata <- cbind(subtest,tename,testdata)
colnames(testdata)[1] = "Subject"
colnames(testdata)[2] = "Activity"
traindata <- cbind(subtrain, trname,traindata)
colnames(traindata)[1] = "Subject"
colnames(traindata)[2] = "Activity"

data <- rbind(testdata,traindata)

#Filtering Data with column names having -mean() or -std()
data2 <- cbind(data[1],data[2])
for(i in 2:562){
  if (grepl("-mean()",colnames(data[i]),fixed = T)){
    data2 <- cbind(data2,data[i])
    }
  if (grepl("-std()",colnames(data[i]),fixed = T)){
    data2 <- cbind(data2,data[i])
    }
  }
#Final Data containing avg of each var, for each (Subject and Activity) pair.
finaldata <-aggregate(data2[3:68], by=list(data2$Subject,data2$Activity), FUN=mean, na.rm=TRUE)
colnames(finaldata)[1] = "Subject"
colnames(finaldata)[2] = "Activity"
finaldata <- arrange(finaldata, Subject, Activity)

#Write the Final Data into text file
write.table(finaldata, "run_analysis_Output.txt", row.name = FALSE )
