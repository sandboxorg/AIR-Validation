#
library("RODBC")
library(compare)
library(gdata)                 
mydata = read.csv("//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/UPXTest.csv",header=FALSE,stringsAsFactors = FALSE)  # read from first sheet 
upxmydata<-data.frame(mydata)
GMAC.data <- odbcConnect("SAmerica")

GMAC.data1  <- as.data.frame(sqlQuery(GMAC.data, "select Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='VE' and AreaScheme='1011'"), stringsAsFactors = TRUE)
GMAC.data2<-  GMAC.data1
GMAC.data3<-GMAC.data1
GMAC.data1$latitude[GMAC.data1$latitude>0 | GMAC.data1$latitude<0 ] <- 0
GMAC.data1$longitude[GMAC.data1$longitude>0 | GMAC.data1$longitude<0] <- 0

GMAC.data3$latitude[GMAC.data3$latitude>0 | GMAC.data3$latitude<0 ] <- GMAC.data3$latitude+0.0002
GMAC.data3$longitude[GMAC.data3$longitude>0 | GMAC.data3$longitude<0] <- GMAC.data3$longitude+0.0002
SACrestaAllData<-rbind(GMAC.data2,GMAC.data3,GMAC.data1)
SACrestaAllData[is.na(SACrestaAllData)] <- 'X'
SACrestaAllData$countrycode <- as.character(SACrestaAllData$countrycode)
upxmydata1<-(mysummary(upxmydata,SACrestaAllData))
upxmydata1[c(3:nrow(upxmydata1)),c(8,9,10,11,12,13,14)]<-(SACrestaAllData[,c(1,2,6,8,9,11,12)])

write.table(SACrestaAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaAllData.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaAllData.upx.txt", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 
write.table( upxmydata1,"//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaAllData.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE)

#Regiondata
Region.data1  <- as.data.frame(sqlQuery(GMAC.data, "select Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='VE' and AreaScheme='1052'"), stringsAsFactors = TRUE)
Region.data2<-Region.data1
Region.data1[, c(2,3)]<-0
Region.data2[, c(2,3,6:8)]<-0
Region.data2[, 1]<-1052
Region.data2[, 11]<-10.1217
Region.data2[, 12]<--72.09651
SARegionAllData<-rbind(Region.data1,Region.data2)
SARegionAllData[is.na(SARegionAllData)] <- 'X'
SARegionAllData$countrycode <- as.character(SARegionAllData$countrycode)
upxmydata1<-(mysummary(upxmydata,SARegionAllData))
upxmydata1[c(3:nrow(upxmydata1)),c(8,9,10,11,12,13,14)]<-(SARegionAllData[,c(1,4,6,8,9,11,12)])


write.table(SARegionAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/RegionAllData.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/RegionAllData.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 


#Municipality
Municipality.data1  <- as.data.frame(sqlQuery(GMAC.data, "select Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='VE' and AreaScheme='1072'"), stringsAsFactors = TRUE)
Municipality.data3<-Municipality.data1
Municipality.data1[, c(2:3,8)]<-0
Municipality.data2<-Municipality.data1
Municipality.data4<-Municipality.data1
Municipality.data2$latitude[Municipality.data2$latitude>0 | Municipality.data2$latitude<0 ] <- Municipality.data2$latitude+0.0001
Municipality.data2$longitude[Municipality.data2$longitude>0 | Municipality.data2$longitude<0] <- Municipality.data2$longitude+0.0001
Municipality.data4$latitude[Municipality.data4$latitude>0 | Municipality.data4$latitude<0 ] <- Municipality.data4$latitude+0.0010
Municipality.data4$longitude[Municipality.data4$longitude>0 | Municipality.data4$longitude<0] <- Municipality.data4$longitude+0.0010
Municipality.data3<-Municipality.data1
Municipality.data3$latitude[Municipality.data3$latitude>0 | Municipality.data3$latitude<0 ] <- 0
Municipality.data3$longitude[Municipality.data3$longitude>0 | Municipality.data3$longitude<0] <- 0
SAMunicipalityAllData<-rbind(Municipality.data1,Municipality.data2,Municipality.data4,Municipality.data3)
SAMunicipalityAllData[is.na(SAMunicipalityAllData)] <- 'X'
SAMunicipalityAllData$countrycode <- as.character(SAMunicipalityAllData$countrycode)

upxmydata1<-(mysummary(upxmydata,SAMunicipalityAllData))
upxmydata1[c(3:nrow(upxmydata1)),c(8,9,10,11,12,13,14)]<-(SAMunicipalityAllData[,c(1,2,6,8,9,11,12)])



write.table(SAMunicipalityAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/MunicipalityAllData.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/MunicipalityAllData.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 

#Region Municipality
RegionMunicipality.data1  <- as.data.frame(sqlQuery(GMAC.data, "select Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='VE' and AreaScheme='1053'"), stringsAsFactors = TRUE)
RegionMunicipality.data2<-RegionMunicipality.data1
RegionMunicipality.data2[,c(11,12)]<-RegionMunicipality.data2[,c(11,12)]+0.0002
RegionMunicipality.data3<-RegionMunicipality.data2
RegionMunicipality.data3[,c(11,12)]<-0
RegionMunicipality.data4<-RegionMunicipality.data1
RegionMunicipality.data4[,c(6,7)]<-'BR'
RegionMunicipalityAllData<-rbind(RegionMunicipality.data1,RegionMunicipality.data2,RegionMunicipality.data3,RegionMunicipality.data4)
RegionMunicipalityAllData[is.na(RegionMunicipalityAllData)] <- 'X'
RegionMunicipalityAllData$countrycode <- as.character(RegionMunicipalityAllData$countrycode)

upxmydata1<-(mysummary(upxmydata,RegionMunicipalityAllData))
upxmydata1[c(3:nrow(upxmydata1)),c(8,9,10,11,12,13,14)]<-(RegionMunicipalityAllData[,c(1,4,6,8,9,11,12)])


write.table(RegionMunicipalityAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/RegionMunicipality.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/RegionMunicipality.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 

#Cresta Municipality
CrestaMunicipality.data1  <- as.data.frame(sqlQuery(GMAC.data, "select Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='VE' and AreaScheme='1072'"), stringsAsFactors = TRUE)
CrestaMunicipality.data2<-CrestaMunicipality.data1
CrestaMunicipality.data2[, c(2,3)]<-'Ventanilla'
CrestaMunicipality.data3<-CrestaMunicipality.data1
CrestaMunicipality.data4<-CrestaMunicipality.data1
CrestaMunicipality.data3[,c(11,12)]<-CrestaMunicipality.data3[,c(11,12)]+0.0001
CrestaMunicipality.data4[,c(11,12)]<-CrestaMunicipality.data3[,c(11,12)]+0.0012
CrestaMunicipality.data4[, c(2,3)]<-'Ventanilla'
CrestaMunicipality.data5<-CrestaMunicipality.data1
CrestaMunicipality.data6<-CrestaMunicipality.data1
CrestaMunicipality.data5[,c(11,12)]<-0
CrestaMunicipality.data6[,c(11,12)]<-0
CrestaMunicipality.data5[,c(2,3)]<-'Ventanilla'
CrestaMunicipality.data6[,c(6,7)]<-'Brigh'
CrestaMunicipalityAllData<-rbind(CrestaMunicipality.data1,CrestaMunicipality.data2,CrestaMunicipality.data3,CrestaMunicipality.data4
                                 ,CrestaMunicipality.data5,CrestaMunicipality.data6)
CrestaMunicipalityAllData[is.na(CrestaMunicipalityAllData)] <- 'X'
CrestaMunicipalityAllData$countrycode <- as.character(CrestaMunicipalityAllData$countrycode)

upxmydata1<-(mysummary(upxmydata,CrestaMunicipalityAllData))
upxmydata1[c(3:nrow(upxmydata1)),c(8,9,10,11,12,13,14)]<-(CrestaMunicipalityAllData[,c(1,2,6,8,9,11,12)])


write.table(CrestaMunicipalityAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaMunicipalityAllData.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaMunicipalityAllData.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 


#Cresta Municipality City
CrestaMunicipalityCity.data1  <- as.data.frame(sqlQuery(GMAC.data, "SELECT a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'VE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
where b.CountryCode='VE' and b.AreaScheme='1072'"), stringsAsFactors = FALSE)
CrestaMunicipalityCity.data1[,1]<-as.character(CrestaMunicipalityCity.data1[,1]) 

CrestaMunicipalityCity.data2<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data2[, 1]<-'Bright'
CrestaMunicipalityCity.data3<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data3[, c(12,13)]<-0
CrestaMunicipalityCity.data4<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data4[, c(12,13)]<-0
CrestaMunicipalityCity.data5<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data5[, c(12,13)]<-0
CrestaMunicipalityCity.data4[, (3)]<-'8.1'
CrestaMunicipalityCity.data4[, (4)]<-'Loreto'
CrestaMunicipalityCity.data4[, (7)]<-'160701'
CrestaMunicipalityCity.data4[, (8)]<-'Barranca'
CrestaMunicipalityCity.data5[, (1)]<-'Barr'
CrestaMunicipalityCity.data6<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data7<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data6[,c(12,13)]<-(CrestaMunicipalityCity.data6[,c(12,13)])+0.0002
CrestaMunicipalityCity.data7[,c(12,13)]<-CrestaMunicipalityCity.data7[,c(12,13)]+0.0002
CrestaMunicipalityCity.data7[, (1)]<-'Barr'
CrestaMunicipalityCityAllData<-rbind(CrestaMunicipalityCity.data1,CrestaMunicipalityCity.data2,CrestaMunicipalityCity.data3,
                                     CrestaMunicipalityCity.data4,CrestaMunicipalityCity.data5,CrestaMunicipalityCity.data6)

CrestaMunicipalityCityAllData[is.na(CrestaMunicipalityCityAllData)] <- 'X'
CrestaMunicipalityCityAllData$countrycode <- as.character(CrestaMunicipalityCityAllData$countrycode)

upxmydata1<-(mysummary(upxmydata,CrestaMunicipalityCityAllData))
upxmydata1[c(3:nrow(upxmydata1)),c(7,8,9,10,11,12,13,14)]<-(CrestaMunicipalityCityAllData[,c(1,2,3,7,9,10,12,13)])


write.table(CrestaMunicipalityCityAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaMunicipalityCity.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaMunicipalityCity.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 


#City
City.data1  <- as.data.frame(sqlQuery(GMAC.data, "SELECT a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'VE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
where b.CountryCode='VE' and b.AreaScheme='1072'"), stringsAsFactors = TRUE)
City.data1[,1]<-as.character(City.data1[,1]) 
City.data2<-City.data1 
City.data3<-City.data1 
City.data4<-City.data1 
City.data1[,c(3,4,7,8)]<-0
City.data2[,c(3,4,7,8)]<-0
City.data3[,c(3,4,7,8)]<-0
City.data4[,c(3,4,7,8)]<-0
City.data2[,1]<-'Bright'
City.data3[,c(12,13)]<-0 
City.data4[,c(12,13)]<-0 
City.data4[,1]<-'Bright'
CityAlldata<-rbind(City.data1,City.data2,City.data3,City.data4)
CityAlldata[is.na(CityAlldata)] <- 'X'
CityAlldata$countrycode <- as.character(CityAlldata$countrycode)

upxmydata1<-(mysummary(upxmydata,CityAlldata))
upxmydata1[c(3:nrow(upxmydata1)),c(7,8,9,10,11,12,13,14)]<-(CityAlldata[,c(1,2,3,7,9,10,12,13)])


write.table(CityAlldata, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CityAlldata.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CityAlldata.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 



#CrestaCity
CrestaCity.data1  <- as.data.frame(sqlQuery(GMAC.data, "SELECT a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'VE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
where b.CountryCode='VE' and b.AreaScheme='1072'"), stringsAsFactors = TRUE)
CrestaCity.data1[,1]<-as.character(CrestaCity.data1[,1])
CrestaCity.data2<-CrestaCity.data1 
CrestaCity.data3<-CrestaCity.data1 
CrestaCity.data4<-CrestaCity.data1
CrestaCity.data1[,c(7,8)]<-0
CrestaCity.data2[,c(7,8)]<-0
CrestaCity.data3[,c(7,8)]<-0
CrestaCity.data4[,c(7,8)]<-0
CrestaCity.data2[,1]<-'Bright'
CrestaCity.data3[,c(12,13)]<-0 
CrestaCity.data4[,c(12,13)]<-0 
CrestaCity.data4[,1]<-'Bright'
CrestaCityAlldata<-rbind(CrestaCity.data1,CrestaCity.data2,CrestaCity.data3,CrestaCity.data4)

CrestaCityAlldata[is.na(CrestaCityAlldata)] <- 'X'
CrestaCityAlldata$countrycode <- as.character(CrestaCityAlldata$countrycode)
upxmydata1<-(mysummary(upxmydata,CrestaCityAlldata))
upxmydata1[c(3:nrow(upxmydata1)),c(7,8,9,10,11,12,13,14)]<-(CrestaCityAlldata[,c(1,2,3,7,9,10,12,13)])


write.table(CrestaCityAlldata, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaCityAlldata.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CrestaCityAlldata.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 



#MunicipalityCity
MunicipalityCity.data1  <- as.data.frame(sqlQuery(GMAC.data, "SELECT a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'VE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
where b.CountryCode='VE' and b.AreaScheme='1072'"), stringsAsFactors = TRUE)
MunicipalityCity.data1 [,1]<-as.character(MunicipalityCity.data1 [,1])
MunicipalityCity.data2<-MunicipalityCity.data1 
MunicipalityCity.data3<-MunicipalityCity.data1 
MunicipalityCity.data4<-MunicipalityCity.data1 
MunicipalityCity.data1[,c(3,4)]<-0
MunicipalityCity.data2[,c(3,4)]<-0
MunicipalityCity.data3[,c(3,4)]<-0
MunicipalityCity.data4[,c(3,4)]<-0
MunicipalityCity.data2[,1]<-'Bright'
MunicipalityCity.data3[,c(12,13)]<-0 
MunicipalityCity.data4[,c(12,13)]<-0 
MunicipalityCity.data4[,1]<-'Bright'
MunicipalityCityAlldata<-rbind(MunicipalityCity.data1,MunicipalityCity.data2,MunicipalityCity.data3,MunicipalityCity.data4)
MunicipalityCityAlldata[is.na(MunicipalityCityAlldata)] <- 'X'
MunicipalityCityAlldata$countrycode <- as.character(MunicipalityCityAlldata$countrycode)

upxmydata1<-(mysummary(upxmydata,MunicipalityCityAlldata))
upxmydata1[c(3:nrow(upxmydata1)),c(7,8,9,10,11,12,13,14)]<-(MunicipalityCityAlldata[,c(1,2,3,7,9,10,12,13)])


write.table(MunicipalityCityAlldata, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/MunicipalityCityAlldata.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/MunicipalityCityAlldata.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 

#RegionCity
RegionCity.data1  <- as.data.frame(sqlQuery(GMAC.data, "SELECT *
  FROM [dbo].[TblAreaCity] WHERE intLevel1 IN (29)"), stringsAsFactors = TRUE)
#RegionCity.data1[,1]<-as.character(City.data1[,1]) 
RegionCity.data1$strCityName <-as.character(RegionCity.data1$strCityName )
RegionCity.data1<-data.frame(RegionCity.data1[,c(2,3,6,7,8)] )

RegionCity.data2<-data.frame(RegionCity.data1 )
RegionCity.data3<-RegionCity.data1 
RegionCity.data4<-RegionCity.data1 

RegionCity.data2[,3]<-'Bright'
RegionCity.data3[,c(4,5)]<-0 
RegionCity.data4[,c(4,5)]<-0 
RegionCity.data4[,3]<-'Bright'
RegionCityAlldata<-rbind(RegionCity.data1,RegionCity.data2,RegionCity.data3,RegionCity.data4)
RegionCityAlldata[is.na(RegionCityAlldata)] <- 'X'
#RegionCityAlldata$countrycode <- as.character(RegionCityAlldata$countrycode)

upxmydata1<-(mysummary(upxmydata,RegionCityAlldata))
upxmydata1[c(3:nrow(upxmydata1)),c(7,9,12,13,14)]<-(RegionCityAlldata[,c(3,2,1,4,5)])
upxmydata1[,c(10,11)]<-0

write.table(RegionCityAlldata, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//RegionCityAlldata.data1.txt") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//RegionCityAlldatalocation.upx", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 

