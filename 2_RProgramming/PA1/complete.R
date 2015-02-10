complete <- function(directory, id = 1:332) {
  
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  flag<-0
  for (i in id){
    filenum<-sprintf("%03d",i)
    filename <- paste("./",directory,"/",filenum,".csv",sep="")
    data <- read.csv(filename)
    nobs <- sum(complete.cases(data))
    if(!flag){
      fin <- data.frame(id = i, nobs = nobs)
      flag <- 1
    } else {
      fin<-rbind(fin, data.frame(id=i, nobs = nobs))
    }
  }
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  return(fin)
}