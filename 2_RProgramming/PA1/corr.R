corr <- function(directory, threshold = 0) {
  op = ""
  flag <- 0
  for (i in 1:332){
    filenum <- sprintf("%03d",i)
    filename <- paste("./",directory,"/",filenum,".csv",sep="")
    data <- read.csv(filename)
    nobs <- sum(complete.cases(data))
    if (nobs > threshold){
      if(!flag){
        fin <- data.frame(cor(data["sulfate"], data["nitrate"], use = "complete.obs"))
        flag <- 1
      } else {
        fin<-rbind(fin, data.frame(cor(data["sulfate"], data["nitrate"], use = "complete.obs")))
      }
    }

  }
  fin["nitrate"]
}
