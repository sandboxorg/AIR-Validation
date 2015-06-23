#
library("RODBC")
library(compare)
library(gdata)                 
mydata = read.csv("//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/CSVTest.csv",header=FALSE,stringsAsFactors = FALSE)  # read from first sheet 
upxmydata<-data.frame(mydata)
GMAC.data <- odbcConnect("SAmerica")

GMAC.data1  <- as.data.frame(sqlQuery(GMAC.data, "select    Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='PE' and remappedgeographysid is NULL and AreaScheme='1011'"), stringsAsFactors = FALSE)
GMAC.data2<-  GMAC.data1
GMAC.data3<-GMAC.data1
GMAC.data1$latitude[GMAC.data1$latitude>0 | GMAC.data1$latitude<0 ] <- ''
GMAC.data1$longitude[GMAC.data1$longitude>0 | GMAC.data1$longitude<0] <- ''

GMAC.data3$latitude[GMAC.data3$latitude>0 | GMAC.data3$latitude<0 ] <- GMAC.data3$latitude+0.0002
GMAC.data3$longitude[GMAC.data3$longitude>0 | GMAC.data3$longitude<0] <- GMAC.data3$longitude+0.0002
SACrestaAllData<-rbind(GMAC.data2,GMAC.data3,GMAC.data1)
SACrestaAllData[is.na(SACrestaAllData)] <- ' '
SACrestaAllData$countrycode <- as.character(SACrestaAllData$countrycode)
upxmydata1<-(mysummary1(upxmydata,SACrestaAllData))
upxmydata1[c(2:nrow(upxmydata1)),c(13,14,15,17,18,19)]<-(SACrestaAllData[,c(6,4,2,9,11,12)])
# nrow(upxmydata1)
# nrow(SACrestaAllData)
#write.table(SACrestaAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/vencsvalldata/COLCrestaAllData.csv") 
#write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/vencsvalldata/CrestaAllData.upx.txt", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 
write.table( upxmydata1,"//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/vencsvalldata/PeruLCrestaAllDatalocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE)
upxmydata1new<-upxmydata1
#Regiondata
Region.data1  <- as.data.frame(sqlQuery(GMAC.data, "select Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='PE' and remappedgeographysid is NULL and AreaScheme='1054'"), stringsAsFactors = TRUE)
Region.data2<-Region.data1
Region.data1[, c(2,3)]<-''
Region.data2[, c(2,3,6:8)]<-''
Region.data2[, 1]<-1052
Region.data2[, 11]<- -11.949700       
Region.data2[, 12]<- -77.132301
SARegionAllData<-rbind(Region.data1,Region.data2)
SARegionAllData[is.na(SARegionAllData)] <- ' '
SARegionAllData$countrycode <- as.character(SARegionAllData$countrycode)
upxmydata1<-(mysummary1(upxmydata,SARegionAllData))
upxmydata1[c(2:nrow(upxmydata1)),c(15,14,13,16,17,18,19)]<-(SARegionAllData[,c(2,4,6,8,9,11,12)])
upxmydata2new<-upxmydata1

#write.table(SARegionAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/vencsvalldata/CORegionAllData.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData/vencsvalldata/PeruRegionAllDatalocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 


#Municipality
Municipality.data1  <- as.data.frame(sqlQuery(GMAC.data, "select     Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='PE' and remappedgeographysid is NULL and AreaScheme='1073'"), stringsAsFactors = TRUE)
Municipality.data3<-Municipality.data1
Municipality.data1[, c(2:3,8)]<-''
Municipality.data2<-Municipality.data1
Municipality.data4<-Municipality.data1
Municipality.data2$latitude[Municipality.data2$latitude>0 | Municipality.data2$latitude<0 ] <- Municipality.data2$latitude+0.0001
Municipality.data2$longitude[Municipality.data2$longitude>0 | Municipality.data2$longitude<0] <- Municipality.data2$longitude+0.0001
Municipality.data4$latitude[Municipality.data4$latitude>0 | Municipality.data4$latitude<0 ] <- Municipality.data4$latitude+0.0010
Municipality.data4$longitude[Municipality.data4$longitude>0 | Municipality.data4$longitude<0] <- Municipality.data4$longitude+0.0010
Municipality.data3<-Municipality.data1
Municipality.data3$latitude[Municipality.data3$latitude>0 | Municipality.data3$latitude<0 ] <- ''
Municipality.data3$longitude[Municipality.data3$longitude>0 | Municipality.data3$longitude<0] <- ''
SAMunicipalityAllData<-rbind(Municipality.data1,Municipality.data2,Municipality.data4,Municipality.data3)
SAMunicipalityAllData[is.na(SAMunicipalityAllData)] <- ' '
SAMunicipalityAllData$countrycode <- as.character(SAMunicipalityAllData$countrycode)
upxmydata1<-(mysummary1(upxmydata,SAMunicipalityAllData))
upxmydata1[c(2:nrow(upxmydata1)),c(15,14,13,16,17,18,19)]<-(SAMunicipalityAllData[,c(2,4,6,8,9,11,12)])

upxmydata3new<-upxmydata1

#write.table(SAMunicipalityAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/COMunicipalityAllData.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/PeruMunicipalityAllDatalocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 

#Region Municipality
RegionMunicipality.data1  <- as.data.frame(sqlQuery(GMAC.data, "select     Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='PE' and AreaScheme='1055'"), stringsAsFactors = TRUE)
RegionMunicipality.data2<-RegionMunicipality.data1
RegionMunicipality.data2[,c(11,12)]<-RegionMunicipality.data2[,c(11,12)]+0.0002
RegionMunicipality.data3<-RegionMunicipality.data2
RegionMunicipality.data3[,c(11,12)]<-''
RegionMunicipality.data4<-RegionMunicipality.data1
RegionMunicipality.data4[,c(6,7)]<-'BR'
RegionMunicipality.data4[,c(11,12)]<-''
RegionMunicipalityAllData<-rbind(RegionMunicipality.data1,RegionMunicipality.data2,RegionMunicipality.data3,RegionMunicipality.data4)
RegionMunicipalityAllData[is.na(RegionMunicipalityAllData)] <- ' '
RegionMunicipalityAllData$countrycode <- as.character(RegionMunicipalityAllData$countrycode)
upxmydata1<-(mysummary1(upxmydata,RegionMunicipalityAllData))
upxmydata1[c(2:nrow(upxmydata1)),c(15,14,13,16,17,18,19)]<-(RegionMunicipalityAllData[,c(2,4,6,8,9,11,12)])
upxmydata4new<-upxmydata1

#write.table(RegionMunicipalityAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/CORegionMunicipality.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/PeruRegionMunicipalitylocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 

#Cresta Municipality
CrestaMunicipality.data1  <- as.data.frame(sqlQuery(GMAC.data, "select     Areascheme,crestacode,Crestaname,AreaCode,AreaName,subareaCode,Subareaname,postalcode,countrycode,CountryName,latitude,longitude from AIRGeography..tGeography where CountryCode='PE' and remappedgeographysid is NULL and AreaScheme='1073'"), stringsAsFactors = TRUE)
CrestaMunicipality.data2<-CrestaMunicipality.data1
CrestaMunicipality.data2[, c(2,3)]<-'10.4'
CrestaMunicipality.data3<-CrestaMunicipality.data1
CrestaMunicipality.data4<-CrestaMunicipality.data1
CrestaMunicipality.data3[,c(11,12)]<-CrestaMunicipality.data3[,c(11,12)]+0.0001
CrestaMunicipality.data4[,c(11,12)]<-CrestaMunicipality.data3[,c(11,12)]+0.0012
CrestaMunicipality.data4[, c(2,3)]<-'10.4'
CrestaMunicipality.data5<-CrestaMunicipality.data1
CrestaMunicipality.data6<-CrestaMunicipality.data1
CrestaMunicipality.data5[,c(11,12)]<-''
CrestaMunicipality.data6[,c(11,12)]<-''
CrestaMunicipality.data5[,c(2,3)]<-'10.4'
CrestaMunicipality.data6[,c(6,7)]<-'0123'
CrestaMunicipalityAllData<-rbind(CrestaMunicipality.data1,CrestaMunicipality.data2,CrestaMunicipality.data3,CrestaMunicipality.data4
                                 ,CrestaMunicipality.data5,CrestaMunicipality.data6)
CrestaMunicipalityAllData[is.na(CrestaMunicipalityAllData)] <- ' '
CrestaMunicipalityAllData$countrycode <- as.character(CrestaMunicipalityAllData$countrycode)

upxmydata1<-(mysummary1(upxmydata,CrestaMunicipalityAllData))
upxmydata1[c(2:nrow(upxmydata1)),c(15,14,13,16,17,18,19)]<-(CrestaMunicipalityAllData[,c(2,4,6,8,9,11,12)])

upxmydata5new<-upxmydata1
#write.table(CrestaMunicipalityAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/COCrestaMunicipalityAllData.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/PeruCrestaMunicipalityAllDatalocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 


#Cresta Municipality City
CrestaMunicipalityCity.data1  <- as.data.frame(sqlQuery(GMAC.data, "select     a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'PE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
                                                        join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
                                                        where b.CountryCode='PE' and remappedgeographysid is NULL and b.AreaScheme='1073'"), stringsAsFactors = FALSE)
CrestaMunicipalityCity.data1[,1]<-as.character(CrestaMunicipalityCity.data1[,1]) 

CrestaMunicipalityCity.data2<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data2[, 1]<-'Bright'
CrestaMunicipalityCity.data3<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data3[, c(12,13)]<-''
CrestaMunicipalityCity.data4<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data4[, c(12,13)]<-''
CrestaMunicipalityCity.data5<-CrestaMunicipalityCity.data1
CrestaMunicipalityCity.data5[, c(12,13)]<-''
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
                                     CrestaMunicipalityCity.data4,CrestaMunicipalityCity.data5)

CrestaMunicipalityCityAllData[is.na(CrestaMunicipalityCityAllData)] <- ' '
CrestaMunicipalityCityAllData$countrycode <- as.character(CrestaMunicipalityCityAllData$countrycode)

upxmydata1<-(mysummary1(upxmydata,CrestaMunicipalityCityAllData))
upxmydata1[c(2:nrow(upxmydata1)),c(11,15,14,13,16,17,18,19)]<-CrestaMunicipalityCityAllData[,c(1,3,5,7,9,10,12,13)]

upxmydata6new<-upxmydata1
#write.table(CrestaMunicipalityCityAllData, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/COCrestaMunicipalityCity.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/PeruCrestaMunicipalityCitylocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 


#City
City.data1  <- as.data.frame(sqlQuery(GMAC.data, "select     a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'PE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
                                      join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
                                      where b.CountryCode='PE' and remappedgeographysid is NULL and b.AreaScheme='1073'"), stringsAsFactors = TRUE)
City.data1[,1]<-as.character(City.data1[,1]) 
City.data2<-City.data1 
City.data3<-City.data1 
City.data4<-City.data1 
City.data1[,c(3,4,7,8)]<-''
City.data2[,c(3,4,7,8)]<-''
City.data3[,c(3,4,7,8)]<-''
City.data4[,c(3,4,7,8)]<-''
City.data2[,1]<-'Bright'
City.data3[,c(12,13)]<-''
City.data4[,c(12,13)]<-''
City.data4[,1]<-'Bright'
CityAlldata<-rbind(City.data1,City.data2,City.data3,City.data4)
CityAlldata[is.na(CityAlldata)] <- ' '
CityAlldata$countrycode <- as.character(CityAlldata$countrycode)

upxmydata1<-(mysummary1(upxmydata,CityAlldata))
upxmydata1[c(2:nrow(upxmydata1)),c(11,15,14,13,16,17,18,19)]<-(CityAlldata[,c(1,3,5,7,9,10,12,13)])
upxmydata7new<-upxmydata1

#write.table(CityAlldata, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/COCityAlldata.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/PeruCityAlldatalocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 



#CrestaCity
CrestaCity.data1  <- as.data.frame(sqlQuery(GMAC.data, "select     a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'PE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
                                            join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
                                            where b.CountryCode='PE' and remappedgeographysid is NULL and b.AreaScheme='1073'"), stringsAsFactors = TRUE)
CrestaCity.data1[,1]<-as.character(CrestaCity.data1[,1])
CrestaCity.data2<-CrestaCity.data1 
CrestaCity.data3<-CrestaCity.data1 
CrestaCity.data4<-CrestaCity.data1
CrestaCity.data1[,c(7,8)]<-''
CrestaCity.data2[,c(7,8)]<-''
CrestaCity.data3[,c(7,8)]<-''
CrestaCity.data4[,c(7,8)]<-''
CrestaCity.data2[,1]<-'Bright'
CrestaCity.data3[,c(12,13)]<-'' 
CrestaCity.data4[,c(12,13)]<-''
CrestaCity.data4[,1]<-'Bright'
CrestaCityAlldata<-rbind(CrestaCity.data1,CrestaCity.data2,CrestaCity.data3,CrestaCity.data4)
CrestaCityAlldata[is.na(CrestaCityAlldata)] <- ' '
CrestaCityAlldata$countrycode <- as.character(CrestaCityAlldata$countrycode)

upxmydata1<-(mysummary1(upxmydata,CrestaCityAlldata))
upxmydata1[c(2:nrow(upxmydata1)),c(11,15,14,13,16,17,18,19)]<-(CrestaCityAlldata[,c(1,3,5,7,9,10,12,13)])

upxmydata8new<-upxmydata1
#write.table(CrestaCityAlldata, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/COCrestaCityAlldata.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/PeruCrestaCityAlldatalocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 



#MunicipalityCity
MunicipalityCity.data1  <- as.data.frame(sqlQuery(GMAC.data, "select     a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'PE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
                                                  join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
                                                  where b.CountryCode='PE' and remappedgeographysid is NULL and b.AreaScheme='1073'"), stringsAsFactors = TRUE)
MunicipalityCity.data1 [,1]<-as.character(MunicipalityCity.data1 [,1])
MunicipalityCity.data2<-MunicipalityCity.data1 
MunicipalityCity.data3<-MunicipalityCity.data1 
MunicipalityCity.data4<-MunicipalityCity.data1 
MunicipalityCity.data1[,c(3,4)]<-''
MunicipalityCity.data2[,c(3,4)]<-''
MunicipalityCity.data3[,c(3,4)]<-''
MunicipalityCity.data4[,c(3,4)]<-''
MunicipalityCity.data2[,1]<-'Bright'
MunicipalityCity.data3[,c(12,13)]<-'' 
MunicipalityCity.data4[,c(12,13)]<-''
MunicipalityCity.data4[,1]<-'Bright'
MunicipalityCityAlldata<-rbind(MunicipalityCity.data1,MunicipalityCity.data2,MunicipalityCity.data3,MunicipalityCity.data4)
MunicipalityCityAlldata[is.na(MunicipalityCityAlldata)] <- ' '
MunicipalityCityAlldata$countrycode <- as.character(MunicipalityCityAlldata$countrycode)

upxmydata1<-(mysummary1(upxmydata,MunicipalityCityAlldata))
upxmydata1[c(2:nrow(upxmydata1)),c(11,15,14,13,16,17,18,19)]<-(MunicipalityCityAlldata[,c(1,3,5,7,9,10,12,13)])
upxmydata9new<-upxmydata1

#write.table(MunicipalityCityAlldata, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/COMunicipalityCityAlldata.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/PeruMunicipalityCityAlldatalocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 
#dataperu<-rbind(upxmydata1new,upxmydata2new,upxmydata3new,upxmydata4new,upxmydata5new,upxmydata6new,upxmydata7new,upxmydata8new,upxmydata9new)
#write.table(dataperu, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/dataperu.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 


#RegionCity
RegionCity.data1  <- as.data.frame(sqlQuery(GMAC.data, "select     a.strCityName,AreaScheme,CRESTACode,CRESTAName,AreaCode,AreaName,SubareaCode,SubareaName,PostalCode,'PE' as countrycode,CountryName,Latitude,Longitude  FROM [AIRGeography].[dbo].[tGeography] b 
                                            join [AIRGeography].[dbo].[TblAreaCity] a on a.guidExternal=b.GuidExternal
                                            where b.CountryCode='PE' and remappedgeographysid is NULL and b.AreaScheme='1073'"), stringsAsFactors = TRUE)
RegionCity.data1[,1]<-as.character(RegionCity.data1[,1])
RegionCity.data2<-RegionCity.data1 
RegionCity.data3<-RegionCity.data1 
RegionCity.data4<-RegionCity.data1
RegionCity.data1[,c(7,8)]<-''
RegionCity.data2[,c(7,8)]<-''
RegionCity.data3[,c(7,8)]<-''
RegionCity.data4[,c(7,8)]<-''
RegionCity.data1[,c(3,4)]<-''
RegionCity.data2[,c(3,4)]<-''
RegionCity.data3[,c(3,4)]<-''
RegionCity.data4[,c(3,4)]<-''
RegionCity.data1[,c(5)]<-1
RegionCity.data2[,c(5)]<-1
RegionCity.data3[,c(5)]<-1
RegionCity.data4[,c(5)]<-1
RegionCity.data1[,c(6)]<-'Amazonas'
RegionCity.data2[,c(6)]<-'Amazonas'
RegionCity.data3[,c(6)]<-'Amazonas'
RegionCity.data4[,c(6)]<-'Amazonas'
RegionCity.data2[,1]<-'Bright'
RegionCity.data3[,c(12,13)]<-'' 
RegionCity.data4[,c(12,13)]<-'' 
RegionCity.data4[,1]<-'Bright'
RegionCityAlldata<-rbind(RegionCity.data1,RegionCity.data2,RegionCity.data3,RegionCity.data4)
RegionCityAlldata[is.na(RegionCityAlldata)] <- ' '
RegionCityAlldata$countrycode <- as.character(RegionCityAlldata$countrycode)

upxmydata1<-(mysummary1(upxmydata,RegionCityAlldata))
upxmydata1[c(2:nrow(upxmydata1)),c(11,15,14,13,16,17,18,19)]<-(RegionCityAlldata[,c(1,3,5,7,9,10,12,13)])

upxmydata10new<-upxmydata1
#write.table(RegionCityAlldata, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/CORegionCityAlldata.data1.csv") 
write.table(upxmydata1, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/PeruRegionCityAlldatalocation.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 
#dataperu<-rbind(upxmydata1new,upxmydata2new,upxmydata3new,upxmydata4new,upxmydata5new,upxmydata6new,upxmydata7new,upxmydata8new,upxmydata9new,upxmydata10new)
#write.table(dataperu, "//qafile2/Leonardo/Feature Data/SouthAmerica/InputFiles/VenezuelaALLData//vencsvalldata/dataperunew.csv", sep=",",quote=FALSE, row.names=FALSE,col.names=FALSE) 
