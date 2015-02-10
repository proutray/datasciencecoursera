best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  if (!(state %in% data[,7])){
    stop('invalid state')
  }
  if (outcome == 'heart attack'){
    ha <- data[which(data$State == state),c(2,11)]
    ha[2] <-sapply(ha[2],as.numeric)
    op <- ha[order(ha$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, na.last = TRUE),]
  } else if (outcome == 'heart failure') {
    hf <- data[which(data$State == state),c(2,17)]
    hf[2] <-sapply(hf[2],as.numeric)
    op <- hf[order(hf$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, na.last = TRUE),]
  } else if (outcome == 'pneumonia') {
    pn<- data[which(data$State == state),c(2,23)]
    pn[2] <-sapply(pn[2],as.numeric)
    op <- pn[order(pn$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, na.last = TRUE),]
  } else {
    stop('invalid outcome')
  }
  ## Return hospital name in that state with lowest 30-day death
  op[1,1]
  ## rate
}