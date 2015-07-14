  library("ff")
  x<-(read.csv.ffdf(file="//qaresults/TS/3.0/SQA/NonLoss_ClientBooks/RC2/6 - Loss Group/Loss to CSV Export/ARFarm-ASCOT/ARFarm-ASCOT_EventLossbyTreaty.csv", header=TRUE,sep=',', VERBOSE=TRUE, fileEncoding="UTF-16",first.rows=2, next.rows=50000, colClasses=NA))
  
  
#   structure(x, class = "data.frame")
#   do.call(rbind,x)
#   
#   
#   
#   L <- list(a = 1:4, b = 4:1) # test input
