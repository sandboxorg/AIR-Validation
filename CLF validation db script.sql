
use [CLFdetailLoss_m60Allrerun22]
--Replace by the result DB name

select convert(varchar(max),catalogtypecode)+'_'+convert(varchar(max),ModelCode)+'_'+
convert(varchar(max),ReinsuranceID) as Modeltype
 ,sum(GroundUpLoss) as LOBSum from 
(SELECT case when CatalogTypeCode='HIST' then 'R0HKE'
when CatalogTypeCode='STC' then 'R10KE' 
when CatalogTypeCode='RDS' then 'R0RKE' end catalogtypecode,ModelCode,GroundUpLoss,ReinsuranceID
  FROM [dbo].[t2_LOSS_ByReinsurance] a
  join [dbo].[t2_LOSS_DimReinsurance] b
  on a.ReinsuranceSID=b.ReinsuranceSID) t
  group by ModelCode,catalogtypecode,ReinsuranceID

  union

  /****** Script for SelectTopNRows command from SSMS  ******/
Select convert(varchar(max),catalogtypecode)+'_'+convert(varchar(max),ModelCode)+'_'+'GU' as Modeltype
 ,sum(GroundUpLoss) as LOBSum from 
(SELECT case when CatalogTypeCode='HIST' then 'R0HKE'
when CatalogTypeCode='STC' then 'R10KE' 
when CatalogTypeCode='RDS' then 'R0RKE' end catalogtypecode,ModelCode,GroundUpLoss
FROM [dbo].[t1_LOSS_ByEvent]) t
group by ModelCode,catalogtypecode

union 

Select convert(varchar(max),catalogtypecode)+'_'+convert(varchar(max),ModelCode)+'_'+'RT' as Modeltype
 ,sum(RetainedLoss) as LOBSum from 
(SELECT case when CatalogTypeCode='HIST' then 'R0HKE'
when CatalogTypeCode='STC' then 'R10KE' 
when CatalogTypeCode='RDS' then 'R0RKE' end catalogtypecode,ModelCode,RetainedLoss
FROM [dbo].[t1_LOSS_ByEvent]) t
group by ModelCode,catalogtypecode

union

Select convert(varchar(max),catalogtypecode)+'_'+convert(varchar(max),ModelCode)+'_'+'GR' as Modeltype
 ,sum(GrossLoss) as LOBSum from 
(SELECT case when CatalogTypeCode='HIST' then 'R0HKE'
when CatalogTypeCode='STC' then 'R10KE' 
when CatalogTypeCode='RDS' then 'R0RKE' end catalogtypecode,ModelCode,GrossLoss
FROM [dbo].[t1_LOSS_ByEvent]) t
group by ModelCode,catalogtypecode

union

Select convert(varchar(max),catalogtypecode)+'_'+convert(varchar(max),ModelCode)+'_'+'NT' as Modeltype
 ,sum(NetOfPreCATLoss) as LOBSum from 
(SELECT case when CatalogTypeCode='HIST' then 'R0HKE'
when CatalogTypeCode='STC' then 'R10KE' 
when CatalogTypeCode='RDS' then 'R0RKE' end catalogtypecode,ModelCode,NetOfPreCATLoss
FROM [dbo].[t1_LOSS_ByEvent]) t
group by ModelCode,catalogtypecode

union 



Select convert(varchar(max),catalogtypecode)+'_'+convert(varchar(max),ModelCode)+'_'+'TRER' as Modeltype
 ,sum(TRER) as LOBSum from 
(SELECT case when CatalogTypeCode='HIST' then 'R0HKE'
when CatalogTypeCode='STC' then 'R10KE' 
when CatalogTypeCode='RDS' then 'R0RKE' end catalogtypecode,ModelCode,GrossLoss-PostCATNetLoss as TRER
FROM [dbo].[t1_LOSS_ByEvent]) t
group by ModelCode,catalogtypecode

union

Select convert(varchar(max),catalogtypecode)+'_'+convert(varchar(max),ModelCode)+'_'+'TRRER' as Modeltype
 ,sum(TRRER) as LOBSum from 
(SELECT case when CatalogTypeCode='HIST' then 'R0HKE'
when CatalogTypeCode='STC' then 'R10KE' 
when CatalogTypeCode='RDS' then 'R0RKE' end catalogtypecode,ModelCode,GrossLoss-NetOfPreCATLoss as TRRER
FROM [dbo].[t1_LOSS_ByEvent]) t
group by ModelCode,catalogtypecode


union

Select convert(varchar(max),catalogtypecode)+'_'+convert(varchar(max),ModelCode)+'_'+'TCRER' as Modeltype
 ,sum(TCRER) as LOBSum from 
(SELECT case when CatalogTypeCode='HIST' then 'R0HKE'
when CatalogTypeCode='STC' then 'R10KE' 
when CatalogTypeCode='RDS' then 'R0RKE' end catalogtypecode,ModelCode,NetOfPreCATLoss-PostCATNetLoss as TCRER
FROM [dbo].[t1_LOSS_ByEvent]) t
group by ModelCode,catalogtypecode






  