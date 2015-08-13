  library("ff")
  library(reshape2)
  x<-(read.csv.ffdf(file="//qaresults/TS/3.0/SQA/NonLoss_ClientBooks/RC2/6 - Loss Group/Loss to CSV Export/ARFarm-ASCOT/ARFarm-ASCOT_EventLossbyGeography.csv", header=TRUE,sep=',', VERBOSE=TRUE, fileEncoding="UTF-16",first.rows=2, next.rows=50000, colClasses=NA))
  ffd <- as.ffdf(x)
#   structure(x, class = "data.frame")
#   do.call(rbind,x)
#   
#   
 n <- length(x[[1]])
  DF <- structure(x, class = "data.frame")  
  DF<- do.call(rbind,x)
  
  
  
  install.packages("data.table")
  
  library(data.table)
  
  train <- fread("//qafile2/Leonardo/Feature Data/London Client issue/BRIT_Terrorism_Port_1_P6_Location.csv",na.strings='' )
  x<-train

  
  x$LocationID<-as.character(rownames(x))
  
  
  
  Repeat1 <- function(d, n) {
    return(do.call("rbind", replicate(n, d, simplify = FALSE)))
  }
  
  Repeat2 <- function(d, n) {
    return(Reduce(rbind, list(d)[rep(1L, times=n)]))
  }
  
  Repeat3 <- function(d, n) {
    if ("data.table" %in% class(d)) return(d[rep(seq_len(nrow(d)), n)])
    return(d[rep(seq_len(nrow(d)), n), ])
  }
  
  Repeat3.dt.convert <- function(d, n) {
    if ("data.table" %in% class(d)) d <- as.data.frame(d)
    return(d[rep(seq_len(nrow(d)), n), ])
  }
  
  
  mtcars1$LocationID<-as.character(rownames(  mtcars1))
  mtcars1[mtcars1==""] <- NA

  write.csv(mtcars1, "c:/londondata.csv",row.names=F,quote=FALSE,na="")
  # Try with data.frames
  mtcars1 <- Repeat1(x, 3)
  mtcars2 <- Repeat2(x, 3)
  mtcars3 <- rbind(mtcars1,mtcars2)
  
  gcinfo(TRUE)
  x <- rnorm(1e8)

  