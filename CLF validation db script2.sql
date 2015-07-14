------------------------------------------------------------------Replace--------------------------------------------------------
------------------------Mentioned Below-------------------------------------------------------------------------------------------





-----------------------------------------------------------------Reinsurance-------------------------------------------------------------------
SET ANSI_WARNINGS ON
SET ANSI_NULLS ON
SET ARITHABORT ON
--SET NOCOUNT ON

Declare @AnalysisName as varchar(50)
Declare @resDB  as varchar(50)
Declare @resultsid as varchar(50)
Declare @perspective as varchar(50)
Declare @sql as varchar(max)
Declare @sql1 as varchar(max)
Declare @sql2 as varchar(max)
Declare @sql3 as varchar(max)
Declare @sql4 as varchar(max)
Declare @sql5 as varchar(max)
Declare @sql6 as varchar(max)
Declare @sql7 as varchar(max)
Declare @sql8 as varchar(max)
Declare @reinsid as varchar(max)
Declare @yearid as varchar(max)
Declare @resultsid1 as varchar(max)
Declare @reinsurancetable  as varchar(max)
Declare @reinsurancedimtable  as varchar(max)

set @AnalysisName    = 'One-Beacon - Loss Analysis'      --Replace with analysis name
set @resDB           = 'One-Beacon-Results'          ------Replace with result DB name
set @yearid=10000 -----------------------------------------Replace with yearid used in exports for CLF which is th 

--use [xx_TS_ResDBName_xx]---- Result DB

use [One-Beacon-Results]----- ResultDB

IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ReinsTemp2') Begin try Drop table  ReinsTemp2 end try begin catch end catch

SET @resultsid1 = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')
SET @reinsid='t'+@resultsid1+'_LOSS_ByReinsurance'
if exists(SELECT  TOP 1 TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE  TABLE_CATALOG='One-Beacon-Results' and table_name='t'+@resultsid1+'_LOSS_ByReinsurance' )  begin

if exists(SELECT name
FROM master..sysdatabases where name='One-Beacon-Results') begin  


SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')
--Set @resultsid=  'select resultsid from [dbo].[tAnalysisResult] where' + ' analysisname='+'''One-Beacon - Loss Analysis'''
--exec(@resultsid)
print(@resultsid)
Set @sql= 'Select  t1.Modelcatalogtypeperspective,sum(GroundupLoss) as GroundupLoss into ReinsTemp2 from 
(Select (t.Naming + ''_''+ t.Model + ''_'' + t.ReinsuranceID) Modelcatalogtypeperspective,(GroundUpLoss) from 
(SELECT distinct a.CatalogTypeCode,EventID,YearID,PerilSetCode,a.ReinsuranceSID,GroundUpLoss,GrossLoss,ReinsuranceRecoveryLoss,
ReinsuranceID,ReinsuranceTypeCode
      ,c.[CatalogSize1]
      ,c.[ModelCode]
      ,c.[Naming]
      ,c.[Model]
      ,c.[CatalogSize2] 
  FROM [dbo].[t2_LOSS_ByReinsurance] a
   join [dbo].[t2_LOSS_DimReinsurance] b on a.ReinsuranceSID=b.ReinsuranceSID
  join [dbo].[CLFvalidationreference] c on a.ModelCode=c.Model and a.CatalogTypeCode=c.catalogtypecode) t) t1
Group by t1.Modelcatalogtypeperspective'
  

exec(@sql)
end 
end




--if exists(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ReinsTemp2') begin
--Select * from ReinsTemp2
--end


--------------------------------------------------------------------Non Reinsurance--------------------------------------------------------------------------------

				IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GUtemp') Begin try Drop table  GUtemp end try begin catch end catch
				IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'POSTtemp') Begin try Drop table  POSTtemp end try begin catch end catch
				IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GRtemp') Begin try Drop table  GRtemp end try begin catch end catch
				IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'NTtemp') Begin try Drop table   NTtemp end try begin catch end catch
				IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TRERtemp') Begin try Drop table TRERtemp end try begin catch end catch
				IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TRRERtemp') Begin try Drop table TRRERtemp end try begin catch end catch
				IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TCRERtemp') Begin try Drop table TCRERtemp end try begin catch end catch
SET @resultsid1 = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')
		
		
if exists (SELECT COLUMN_NAME
					FROM INFORMATION_SCHEMA.COLUMNS
						WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and COLUMN_NAME='GroundUpLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')




				Set @sql1='select * into GUtemp from (Select naming+''_''+convert(varchar(max),ModelCode)+''_''+''GU'' as Modeltype
				 ,sum(GroundUpLoss) as LOBSum  from 
				(SELECT distinct a.*,b.naming,b.catalogsize1,b.catalogsize2
				  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent] a
				  left join [dbo].[CLFvalidationreference] b
				  on a.ModelCode=b.model and a.CatalogTypeCode=b.catalogtypecode where yearid<=' + @yearid + ' and (b.catalogsize2=' +@yearid+'  or ( b.catalogsize2=0 and b.catalogsize2!='''')' + ')) t
				  group by t.ModelCode,t.catalogtypecode,naming) t1'
  
 
 Exec(@sql1)

 end
    

	

if exists (SELECT COLUMN_NAME
                 FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and COLUMN_NAME='PostCATNetLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')

  
				  Set @sql2='select * into POSTtemp from (Select naming+''_''+convert(varchar(max),ModelCode)+''_''+''POST'' as Modeltype
				 ,sum(PostCATNetLoss) as LOBSum  from 
				(SELECT distinct a.*,b.naming,b.catalogsize1,b.catalogsize2
				  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent] a
				  left join [dbo].[CLFvalidationreference] b
				  on a.ModelCode=b.model and a.CatalogTypeCode=b.catalogtypecode where yearid<=' + @yearid + ' and (b.catalogsize2=' +@yearid+'  or ( b.catalogsize2=0 and b.catalogsize2!='''')' + ')) t
				  group by t.ModelCode,t.catalogtypecode,naming) t1'
  
Exec(@sql2)
end



  
  
if exists (SELECT COLUMN_NAME
              FROM INFORMATION_SCHEMA.COLUMNS
                  WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and COLUMN_NAME='GrossLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')

  
					  Set @sql3='select * into GRtemp from (Select naming+''_''+convert(varchar(max),ModelCode)+''_''+''GR'' as Modeltype
					 ,sum(GrossLoss) as LOBSum  from 
					(SELECT distinct a.*,b.naming,b.catalogsize1,b.catalogsize2
					  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent] a
					  left join [dbo].[CLFvalidationreference] b
					 on a.ModelCode=b.model and a.CatalogTypeCode=b.catalogtypecode where yearid<=' + @yearid + ' and (b.catalogsize2=' +@yearid+'  or ( b.catalogsize2=0 and b.catalogsize2!='''')' + ')) t
				  group by t.ModelCode,t.catalogtypecode,naming) t1'
  
Exec(@sql3)
end


 
if exists (SELECT COLUMN_NAME
                FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and COLUMN_NAME='NetOfPreCATLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')

  
						  Set @sql5='select * into NTtemp from (Select naming+''_''+convert(varchar(max),ModelCode)+''_''+''NT'' as Modeltype
						 ,sum(NetOfPreCATLoss) as LOBSum  from 
						(SELECT distinct a.*,b.naming,b.catalogsize1,b.catalogsize2
						  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent] a
						  left join [dbo].[CLFvalidationreference] b
						   on a.ModelCode=b.model and a.CatalogTypeCode=b.catalogtypecode where yearid<=' + @yearid + ' and (b.catalogsize2=' +@yearid+'  or ( b.catalogsize2=0 and b.catalogsize2!='''')' + ')) t
				  group by t.ModelCode,t.catalogtypecode,naming) t1'
  
Exec(@sql5)
end

 
 
if exists (SELECT COLUMN_NAME
                  FROM INFORMATION_SCHEMA.COLUMNS
                       WHERE TABLE_NAME = 't1_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and COLUMN_NAME='GrossLoss' )  begin 

    if exists (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                           WHERE TABLE_NAME = 't1_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and COLUMN_NAME='PostCATNetLoss' ) begin


SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')

  
					  Set @sql6='select * into TRERtemp from (Select naming+''_''+convert(varchar(max),ModelCode)+''_''+''TRER'' as Modeltype
					 ,sum(GrossLoss-PostCATNetLoss) as LOBSum  from 
					(SELECT distinct a.*,b.naming,b.catalogsize1,b.catalogsize2
					  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent] a
					  left join [dbo].[CLFvalidationreference] b
					  on a.ModelCode=b.model and a.CatalogTypeCode=b.catalogtypecode where yearid<=' + @yearid + ' and (b.catalogsize2=' +@yearid+'  or ( b.catalogsize2=0 and b.catalogsize2!='''')' + ')) t
				  group by t.ModelCode,t.catalogtypecode,naming) t1'
  
Exec(@sql6)
end 
end 




if exists (SELECT COLUMN_NAME
                    FROM INFORMATION_SCHEMA.COLUMNS
                            WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and COLUMN_NAME='GrossLoss')  begin 


if exists (SELECT COLUMN_NAME
                     FROM INFORMATION_SCHEMA.COLUMNS
                              WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and  COLUMN_NAME='NetOfPreCATLoss') begin 


SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')

  
						  Set @sql7='select * into TRRERtemp from (Select naming+''_''+convert(varchar(max),ModelCode)+''_''+''TRRER'' as Modeltype
						 ,sum(GrossLoss-NetOfPreCATLoss) as LOBSum  from 
						(SELECT distinct a.*,b.naming,b.catalogsize1,b.catalogsize2
						  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent] a
						  left join [dbo].[CLFvalidationreference] b
						  on a.ModelCode=b.model and a.CatalogTypeCode=b.catalogtypecode where yearid<=' + @yearid + ' and (b.catalogsize2=' +@yearid+'  or ( b.catalogsize2=0 and b.catalogsize2!='''')' + ')) t
				  group by t.ModelCode,t.catalogtypecode,naming) t1'
  
Exec(@sql7)
end
end


if exists (SELECT COLUMN_NAME
                  FROM INFORMATION_SCHEMA.COLUMNS
                         WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and COLUMN_NAME='PostCATNetLoss' )  begin 

if exists (SELECT COLUMN_NAME
                  FROM INFORMATION_SCHEMA.COLUMNS
                          WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='One-Beacon-Results' and  COLUMN_NAME='NetOfPreCATLoss')  begin 

SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='One-Beacon - Loss Analysis')

  
							  Set @sql8='select * into TCRERtemp from (Select naming+''_''+convert(varchar(max),ModelCode)+''_''+''TCRER'' as Modeltype
							 ,sum(NetOfPreCATLoss-PostCATNetLoss) as LOBSum  from 
							(SELECT distinct a.*,b.naming,b.catalogsize1,b.catalogsize2
							  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent] a
							  left join [dbo].[CLFvalidationreference] b
							   on a.ModelCode=b.model and a.CatalogTypeCode=b.catalogtypecode where yearid<=' + @yearid + ' and (b.catalogsize2=' +@yearid+'  or ( b.catalogsize2=0 and b.catalogsize2!='''')' + ')) t
				  group by t.ModelCode,t.catalogtypecode,naming) t1'
  
Exec(@sql8)
end
end 
 
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Mastertemp') DROP TABLE MasterTemp
 CREATE TABLE MasterTemp
 (
 ModelType VARCHAR(MAX),
 LOBSum float 
 )
 --SELECT * FROM MasterTemp
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GUtemp') begin  INSERT INTO MasterTemp SELECT * FROM GUTemp end 
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ReinsTemp2') begin  INSERT INTO MasterTemp SELECT * FROM ReinsTemp2 end 
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'POSTtemp') begin  INSERT INTO MasterTemp  select * from POSTtemp end 
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GRtempp') begin  INSERT INTO MasterTemp  Select * from GRtemp end
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'NTtemp') begin  INSERT INTO MasterTemp  Select * from NTtemp end

 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TRERtemp') begin INSERT INTO MasterTemp   Select * from TRERtemp end
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TRRERtemp') begin INSERT INTO MasterTemp Select * from TRRERtemp end
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TCRERtemp') begin INSERT INTO MasterTemp   Select * from TCRERtemp end

 select * from MasterTemp
 
  




