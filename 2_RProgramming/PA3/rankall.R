rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  state <- sort(unique(data[,7]))
  df <- data.frame(state)
  hop <- cbind(hospital = 'hospital', df)
  hop$hospital<- as.character(hop$hospital)
  if (num == "best"){
    i = 1
    decflag = FALSE
  } else if (num == "worst"){
    i = 1
    decflag = TRUE
  } else {
    i = as.numeric(num)
    decflag = FALSE
  }
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  if (outcome == 'heart attack'){
    for (val in state){
      ha <- data[which(data$State == val),c(2,11)]
      ha[2] <-sapply(ha[2],as.numeric)
      op <- ha[order(ha$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, na.last = TRUE, decreasing = decflag),]
      if (nrow(op) < i){
        hop[hop$state == val,1] = NA
      } else if (is.null(op[i,1])){
        hop[hop$state == val,1] = NA
      } else {
        hop[hop$state == val,1] = op[i,1]
      }
    }
  } else if (outcome == 'heart failure') {
    for (val in state){
      ha <- data[which(data$State == val),c(2,17)]
      ha[2] <-sapply(ha[2],as.numeric)
      op <- ha[order(ha$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, na.last = TRUE, decreasing = decflag),]
      if (nrow(op) < i){
        hop[hop$state == val,1] = NA
      } else if (is.null(op[i,1])){
        hop[hop$state == val,1] = NA
      } else {
        hop[hop$state == val,1] = op[i,1]
      }
    }
  } else if (outcome == 'pneumonia') {
    for (val in state){
      ha <- data[which(data$State == val),c(2,23)]
      ha[2] <-sapply(ha[2],as.numeric)
      op <- ha[order(ha$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, na.last = TRUE, decreasing = decflag),]
      if (nrow(op) < i){
        hop[hop$state == val,1] = NA
      } else if (is.null(op[i,1])){
        hop[hop$state == val,1] = NA
      } else {
        hop[hop$state == val,1] = op[i,1]
      }
    }
  } else {
    stop('invalid outcome')
  }
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  hop
}