pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  notnadata<-NA
  for (i in id){
    filenum<-sprintf("%03d",i)
    filename <- paste("./",directory,"/",filenum,".csv",sep="")
    data <- read.csv(filename)
    pollutantdata<-data[pollutant]
    notnadata<-c(notnadata[!is.na(notnadata)], pollutantdata[!is.na(pollutantdata)])
  }
  return (signif(mean(as.numeric(notnadata)),4))  
 
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
}