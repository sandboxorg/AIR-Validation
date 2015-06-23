#
library("RODBC")
library(compare)
library(gdata) 
GMAC.data <- odbcConnect("SAmerica")
GMAC.data1  <- as.data.frame(sqlQuery(GMAC.data, "SELECT ExposureSetName,city,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,CountryCode,CountryName,Latitude,Longitude,GeographySID
  FROM [SA_Test_Chile_DB].[dbo].[tLocation] a join [SA_Test_Chile_DB].[dbo].[tExposureSet] b on a.ExposureSetSID=b.ExposureSetSID"), stringsAsFactors = FALSE,header=T)

b<-data.frame('ExposureSetName','city','CRESTACode','CRESTAName','AreaCode','AreaName','SubareaCode','SubareaName','PostalCode','CountryCode','CountryName','Latitude','Longitude','GeographySID',stringsAsFactors = FALSE)
Importdata<-GMAC.data1
a <- matrix(1, ncol = ncol(Importdata), nrow = nrow(Importdata))

for (j in 1:nrow(Importdata)){
  for (i in 1:ncol(Importdata)){
    
        if (Importdata[j,i]==''|is.na(Importdata[j,i]) )
          {
          a[j,i]<-'';
          }else 
            {
          a[j,i]<-as.character(Importdata[j,i]);
        }
    
      }
}
b<-data.frame(b)
a<-data.frame(a)
names(a)<-names(b)
importresult<-data.frame(a)
write.table(importresult, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/vencsvalldata/ALLdata/Alldataresults/Chilealldata.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=TRUE) 


        
        
        
        
        
        
        
      