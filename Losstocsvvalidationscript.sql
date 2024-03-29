------------------------------------------------------------------Replace--------------------------------------------------------
---------------------------------------------------------------Mentioned Below---------------------------------------------------

-----------------------------------------------------------------Reinsurance-----------------------------------------------------
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
Declare @TCID  as nvarchar(max)

set @AnalysisName    = 'Feature Loss 10k_073005067970'----Replace with analysis name
set @resDB           = 'CLFdetail_Rescsv3'          ------Replace with result DB name
-----------Replace - 'XXTCIDXX' with Test case ID-------------------------------------------

use [CLFdetail_Rescsv3]----- ResultDB

SET @resultsid1 = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='Feature Loss 10k_073005067970')

--------------------------------------------------------------------Getting Loss from By event table by catalog type and also total loss as well----------------------------------

 IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GUtemp') Begin try Drop table  GUtemp end try begin catch end catch
 IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'POSTtemp') Begin try Drop table  POSTtemp end try begin catch end catch
 IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GRtemp') Begin try Drop table  GRtemp end try begin catch end catch
 IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'NTtemp') Begin try Drop table   NTtemp end try begin catch end catch
 IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RTtemp') Begin try Drop table   RTtemp end try begin catch end catch
 IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PreLtemp') Begin try Drop table    PreLtemp end try begin catch end catch  
            

--------------------------------------------------------------------------Gross Loss by catalog---------------------------------------------------------------------------

  
if exists (SELECT COLUMN_NAME
              FROM INFORMATION_SCHEMA.COLUMNS
                  WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='CLFdetail_Rescsv3' and COLUMN_NAME='GrossLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='Feature Loss 10k_073005067970')

  
                                    Set @sql3='SELECT  sum(GrossLoss) as  Gross,CatalogTypeCode as CatalogTypeCode into GRtemp
  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent]
Group by CatalogTypeCode'
  
Exec(@sql3)
end
        




--------------------------------------------------------------------------Retained Loss by catalog---------------------------------------------------------------------------



if exists (SELECT COLUMN_NAME
                FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='CLFdetail_Rescsv3' and COLUMN_NAME='RetainedLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='Feature Loss 10k_073005067970')

  
                                           Set @sql6='SELECT  sum(RetainedLoss) as  Retained,CatalogTypeCode as CatalogTypeCode into RTtemp
  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent]
Group by CatalogTypeCode'
  
Exec(@sql6)
end






--------------------------------------------------------------------------Groundup Loss by catalog---------------------------------------------------------------------------




if exists (SELECT COLUMN_NAME
                                  FROM INFORMATION_SCHEMA.COLUMNS
                                         WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='CLFdetail_Rescsv3' and COLUMN_NAME='GroundUpLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='Feature Loss 10k_073005067970')




                           Set @sql1='SELECT  sum(GroundUploss) as GroundUP,CatalogTypeCode as CatalogTypeCode into GUtemp
  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent]
Group by CatalogTypeCode'
  
 
 Exec(@sql1)

end
    


--------------------------------------------------------------------------PostCATNetLoss Loss by catalog---------------------------------------------------------------------------
       

if exists (SELECT COLUMN_NAME
                 FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='CLFdetail_Rescsv3' and COLUMN_NAME='PostCATNetLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='Feature Loss 10k_073005067970')

  
                             Set @sql2='SELECT  sum(PostCATNetLoss) as PostCATNet,CatalogTypeCode as CatalogTypeCode into POSTtemp
  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent]
Group by CatalogTypeCode'
  
Exec(@sql2)
end


                                                                                                 

--------------------------------------------------------------------------NetOfPreCATLoss Loss by catalog---------------------------------------------------------------------------
   

if exists (SELECT COLUMN_NAME
                FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='CLFdetail_Rescsv3' and COLUMN_NAME='NetOfPreCATLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='Feature Loss 10k_073005067970')

  
                                           Set @sql5='SELECT  sum(NetOfPreCATLoss) as  PreCATNet,CatalogTypeCode as CatalogTypeCode into NTtemp
  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent]
Group by CatalogTypeCode'
  
Exec(@sql5)
end




--------------------------------------------------------------------------PreLayerGrossLoss Loss by catalog---------------------------------------------------------------------------
   


if exists (SELECT COLUMN_NAME                                                           
                FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_NAME = 't'+@resultsid1+'_LOSS_ByEvent' and TABLE_CATALOG='CLFdetail_Rescsv3' and COLUMN_NAME='PreLayerGrossLoss')  begin 
SET @resultsid = (select convert(varchar(100),resultsid)  from [dbo].[tAnalysisResult] where analysisname='Feature Loss 10k_073005067970')

  
                                           Set @sql7='SELECT  sum(PreLayerGrossLoss) as  PreLayerGross,CatalogTypeCode as CatalogTypeCode into PreLtemp
  FROM [dbo].[t' + @resultsid+'_LOSS_ByEvent]
Group by CatalogTypeCode'
  
Exec(@sql7)
end



------Create a temp table for dumping the loss results by catalog type and total loss just by STC----------

 
 If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Mastertemp') DROP TABLE MasterTemp
CREATE TABLE MasterTemp
(
GroundUP Float ,
Gross Float,
Retained Float,
PreCATNet Float,
PostCATNet Float, 
PreLayerGross Float,
CatalogTypeCode varchar(max) 
 )
--SELECT * FROM MasterTemp





If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GUtemp') begin  INSERT INTO MasterTemp(GroundUP,CatalogTypeCode) SELECT * FROM GUTemp end
If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PreLtemp') begin  INSERT INTO MasterTemp(PreLayerGross,CatalogTypeCode) SELECT * FROM PreLtemp end 
If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'POSTtemp') begin  INSERT INTO MasterTemp(PostCATNet,CatalogTypeCode)  select * from POSTtemp end 
If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GRtemp') begin  INSERT INTO MasterTemp(Gross,CatalogTypeCode)  Select * from GRtemp end
If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'NTtemp') begin  INSERT INTO MasterTemp(PreCATNet,CatalogTypeCode)  Select * from NTtemp end
If exists( SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RTtemp') begin  INSERT INTO MasterTemp(Retained,CatalogTypeCode)  Select * from RTtemp end


---------------------------------------------------------manipulating data to get in loss by catalog type and just by STC itself----------------------------

SELECT CatalogTypeCode, SUM(ISNULL(GroundUp,0)) GroundUP
,SUM(ISNULL(Gross,0)) Gross
,SUM(ISNULL(Retained,0)) Retained
,SUM(ISNULL(PreCATNet,0)) PreCATNet
,SUM(ISNULL(PostCATNet,0)) PostCATNet
,SUM(ISNULL(PreLayerGross,0)) PreLayerGross
FROM MasterTemp
GROUP BY CatalogTypeCode

union 

SELECT  'STCSummary' CatalogTypeCode,SUM(ISNULL(GroundUp,0)) GroundUP
,SUM(ISNULL(Gross,0)) Gross
,SUM(ISNULL(Retained,0)) Retained
,SUM(ISNULL(PreCATNet,0)) PreCATNet
,SUM(ISNULL(PostCATNet,0)) PostCATNet
,SUM(ISNULL(PreLayerGross,0)) PreLayerGross
FROM MasterTemp where CatalogTypeCode='STC' 
GROUP BY CatalogTypeCode




