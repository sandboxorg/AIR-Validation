mysummary <- function(a,b) {
  if (nrow(a)>nrow(b)) {
    a<-data.frame(a[c(1:(nrow(b)+2)),])
  } else {
    a<-a
  }
  
  result <- a
  return(result)
}
