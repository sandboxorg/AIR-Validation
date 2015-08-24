         





resultdb<-inputs$args[1]
ValID<-inputs$args[2]


sqlString<-paste('select * from','SaveBy_Res2..','MasterTemp',collapse="") 
server<-'qa-ngp-a-db1'
sqlconn <- odbcDriverConnect(sprintf("driver={SQL Server};server=%s;UID=sa;PWD=Clasic22", server))

sqlQuery(sqlconn,sqlString)