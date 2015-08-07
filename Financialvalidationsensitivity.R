install.packages("ggplot2")
install.packages("nPlot")
install.packages("RODBC")
install.packages("xlsx")

library(RODBC)
library(xlsx)
dbhandle <- odbcDriverConnect('driver={SQL Server};server=qa-ts-p9-db\\sql2014;trusted_connection=true')



########################################valid case#########################################################
sql_query <- paste("SELECT distinct b.Contractid,a.Grossloss
  FROM [Layer_Validation_Loss].[dbo].[t3_LOSS_ByContract] a join [Layer_Validation_Loss].[dbo].[t3_LOSS_DimContract] b  on a.contractsid=b.contractsid    --order by a.contractid
  WHERE EventID = (SELECT TOP 1 EventID FROM [Layer_Validation_Loss].[dbo].[t3_LOSS_ByEvent] ORDER BY GroundUpLoss desc )
    -- order by a.contractid")


FinacialSensitivity_Layer_1 <- data.frame(sqlQuery(dbhandle, sql_query, stringsAsFactors = FALSE))  
remove(dbhandle)
remove(sql_query)
odbcCloseAll()

FinacialSensitivity_Layer_1<-FinacialSensitivity_Layer_1[ order(FinacialSensitivity_Layer_1$Contractid), ] 
FinacialSensitivity_Layer_1<-data.frame(FinacialSensitivity_Layer_1,row.names=NULL)



