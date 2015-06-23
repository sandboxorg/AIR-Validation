mysummary1 <- function(a,b) {
  if (nrow(a)>nrow(b)) {
    a<-data.frame(a[c(1:(nrow(b)+1)),])
  } else {
    a<-a
  }
  
  result <- a
  return(result)
}
