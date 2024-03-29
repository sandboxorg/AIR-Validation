
-----------------------------------------##################### ALL VALID CASE ######################----------------------------------------------------------------------
select * from 
((select t4.City,t4.Crestcode as CRESTACode,AreaCode,SubareaCode,PostalCode,Countrycode,latitude,longitude from (select *, ROW_NUMBER() over (PARTITION by t3.cityid,t3.crestaid,t3.areaid,t3.subareaid,t3.postalid,t3.rankid,t3.countrycode order by rankid desc) as rn from 
(select * from 
                   (select *,cityid+crestaid+areaid+subareaid+postalid as RankID from 
                   (select *,case when City='' then 0 else 1  end cityid,
                   case when Crestcode='' then 0 else 1  end crestaid,
                   case when Areacode='' then 0 else 1  end areaid,
                   case when Subareacode='' then 0 else 1  end subareaid,
                   case when Postalcode='' then 0 else 1  end postalid
                   from
                   (SELECT isnull(b.strCityName,'') City,
                   isnull(cast(CRESTACode as nvarchar),'') Crestcode,isnull(cast(AreaCode as nvarchar),'') AreaCode,isnull(cast(SubareaCode as nvarchar),'') SubareaCode,
                   isnull(cast(PostalCode as nvarchar),'') PostalCode,
                   isnull(countrycode,'') countrycode,isnull(cast(latitude as nvarchar),'') latitude,isnull(cast(longitude as nvarchar),'') longitude
                   
                   FROM [AIRGeography].[dbo].[tGeography] a 
                   full join [AIRGeography].[dbo].[TblAreaCity] b on a.GuidExternal=b.guidExternal and RemappedGeographySID is  NULL  and countrycode != 'US'
                   ) t ) t1) t2  )t3 ) t4 where  latitude not like ('0.%') and longitude not like ('0.%') and t4.rn=1   )
                   
                   union
                   
                   (
                   

                   select t4.City,t4.Crestcode as CRESTACode,AreaCode,SubareaCode,PostalCode,Countrycode,latitude,longitude from (select *, ROW_NUMBER() over (PARTITION by t3.cityid,t3.crestaid,t3.areaid,t3.subareaid,t3.postalid,t3.rankid,t3.countrycode order by rankid desc) as rn from 
                   (select * from 
                   (select *,cityid+crestaid+areaid+subareaid+postalid as RankID from 
                   (select *,case when City='' then 0 else 1  end cityid,
                   case when Crestcode='' then 0 else 1  end crestaid,
                   case when Areacode='' then 0 else 1  end areaid,
                   case when Subareacode='' then 0 else 1  end subareaid,
                   case when Postalcode='' then 0 else 1  end postalid
                   from
                   (SELECT isnull(b.CityName,'') City,
                   isnull(cast(CRESTACode as nvarchar),'') Crestcode,isnull(cast(a.AreaCode as nvarchar),'') AreaCode,isnull(cast(a.SubareaCode as nvarchar),'') SubareaCode,
                   isnull(cast(a.PostalCode as nvarchar),'') PostalCode,
                   isnull(a.countrycode,'') countrycode,isnull(cast(latitude as nvarchar),'') latitude,isnull(cast(longitude as nvarchar),'') longitude
                   
                   FROM [AIRGeography].[dbo].[tGeography] a 
                   full join [AIRGeography].[dbo].[tUSCity] b on a.GeographySID=b.GeographySID and 
				    RemappedGeographySID is  NULL
                   ) t ) t1) t2  )t3 ) t4 where  countrycode='US' and latitude not like ('0.%') and longitude not like ('0.%') and t4.rn=1  )) y
                   
                   --where y.countrycode='GB'





















-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Invalid NON US---------------------------------------------------------------------------------------------------------------------
(
select  City, case when city= ''  then '' else (SELECT TOP 1 isnull(p.strCityName,'')-- +'_'+o.CountryCode 
                   FROM [AIRGeography].[dbo].[tGeography] o
                   full join [AIRGeography].[dbo].[TblAreaCity] p on o.guidExternal=p.guidExternal and 
				    RemappedGeographySID is  NULL where strCityName is not NULL and strCityName!=t.City and o.AreaCode!=t.AreaCode and o.countrycode!=t.countrycode 
					and o.CountryCode!='US') end 
					Cityinvalid,
					
					
					Crestacode,case when Crestacode= ''  then '' else (SELECT TOP 1 isnull(q.CRESTACode,'')--+ '_'+ q.CountryCode
                   FROM [AIRGeography].[dbo].[tGeography] q 
                   full join [AIRGeography].[dbo].[TblAreaCity] r on q.guidExternal=r.guidExternal and 
				    RemappedGeographySID is  NULL where q.CRESTACode is not NULL and q.CRESTACode!=t.Crestacode and q.countrycode!=t.countrycode and q.CountryCode!='US') end 
					Crestainvalid ,
					
					AreaCode,case when AreaCode= ''  then '' else (SELECT TOP 1 isnull(s.AreaCode,'')--+ '_'+ s.CountryCode
                   FROM [AIRGeography].[dbo].[tGeography] s 
                   full join [AIRGeography].[dbo].[TblAreaCity] t9 on s.guidExternal=t9.guidExternal and 

				    RemappedGeographySID is  NULL where s.AreaCode is not NULL and s.AreaCode!=t.AreaCode and s.CountryCode!=t.countrycode and s.CountryCode!='US')
							 end 
					AreaCodeinvalid,


							SubareaCode,case when SubareaCode= ''  then '' else (SELECT TOP 1 isnull(u.SubareaCode,'')-- + '_'+ u.countrycode
                   FROM [AIRGeography].[dbo].[tGeography] u 
                   full join [AIRGeography].[dbo].[TblAreaCity] v on u.guidExternal=v.guidExternal and 
				    RemappedGeographySID is  NULL where u.SubareaCode is not NULL and u.SubareaCode!=t.SubareaCode and u.AreaCode!=t.AreaCode  and u.countrycode!=t.countrycode
							and u.CountryCode!='US'
					order by u.GeographySID asc) end 
				SubareaCodeinvalid,

							PostalCode,case when PostalCode= ''  then '' else (SELECT TOP 1 isnull(w.PostalCode,'')--+ '_'+ w.CountryCode
                   FROM [AIRGeography].[dbo].[tGeography] w
                   full join [AIRGeography].[dbo].[TblAreaCity] x on w.guidExternal=x.guidExternal and 
				    RemappedGeographySID is  NULL where w.PostalCode is not NULL and w.PostalCode!=t.PostalCode and w.AreaCode!=t.AreaCode and w.countrycode!=t.countrycode 
					and w.CountryCode!='US'
					order by w.GeographySID desc)  end 
				PostalCodeinvalid,countrycode,latitude,longitude from 





(select t4.City,t4.Crestcode as CRESTACode,AreaCode,SubareaCode,PostalCode,Countrycode,latitude,longitude from (select *, ROW_NUMBER() over (PARTITION by t3.cityid,t3.crestaid,t3.areaid,t3.subareaid,t3.postalid,t3.rankid,t3.countrycode order by rankid desc) as rn from 
(select * from 
                   (select *,cityid+crestaid+areaid+subareaid+postalid as RankID from 
                   (select *,case when City='' then 0 else 1  end cityid,
                   case when Crestcode='' then 0 else 1  end crestaid,
                   case when Areacode='' then 0 else 1  end areaid,
                   case when Subareacode='' then 0 else 1  end subareaid,
                   case when Postalcode='' then 0 else 1  end postalid
                   from
                   (SELECT isnull(b.strCityName,'') City,
                   isnull(cast(CRESTACode as nvarchar),'') Crestcode,isnull(cast(AreaCode as nvarchar),'') AreaCode,isnull(cast(SubareaCode as nvarchar),'') SubareaCode,
                   isnull(cast(PostalCode as nvarchar),'') PostalCode,
                   isnull(countrycode,'') countrycode,isnull(cast(latitude as nvarchar),'') latitude,isnull(cast(longitude as nvarchar),'') longitude
                   
                   FROM [AIRGeography].[dbo].[tGeography] a 
                   full join [AIRGeography].[dbo].[TblAreaCity] b on a.GuidExternal=b.guidExternal and RemappedGeographySID is  NULL  and countrycode != 'US'
                   ) t ) t1) t2  )t3 ) t4 where  latitude not like ('0.%') and longitude not like ('0.%') and t4.rn=1  ) t) union

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Invalid NON US---------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Invalid  US---------------------------------------------------------------------------------------------------------------------


(
select  City, case when city= ''  then '' else (SELECT TOP 1 isnull(p.strCityName,'') --+ '_'+o.CountryCode 
                   FROM [AIRGeography].[dbo].[tGeography] o
                   full join [AIRGeography].[dbo].[TblAreaCity] p on o.guidExternal=p.guidExternal and 
				    RemappedGeographySID is  NULL where strCityName is not NULL and strCityName!=t.City and o.AreaCode!=t.AreaCode and o.countrycode!=t.countrycode 
					and o.CountryCode!='US') end 
					Cityinvalid,
					
					
					Crestacode,case when Crestacode= ''  then '' else (SELECT TOP 1 isnull(q.CRESTACode,'')-- + '_'+ q.CountryCode
                   FROM [AIRGeography].[dbo].[tGeography] q 
                   full join [AIRGeography].[dbo].[TblAreaCity] r on q.guidExternal=r.guidExternal and 
				    RemappedGeographySID is  NULL where q.CRESTACode is not NULL and q.CRESTACode!=t.Crestacode and q.countrycode!=t.countrycode and q.CountryCode!='US') end 
					Crestainvalid ,
					
					AreaCode,case when AreaCode= ''  then '' else (SELECT TOP 1 isnull(s.AreaCode,'') --+ '_'+ s.CountryCode
                   FROM [AIRGeography].[dbo].[tGeography] s 
                   full join [AIRGeography].[dbo].[TblAreaCity] t9 on s.guidExternal=t9.guidExternal and 

				    RemappedGeographySID is  NULL where s.AreaCode is not NULL and s.AreaCode!=t.AreaCode and s.CountryCode!=t.countrycode and s.CountryCode!='US')
							 end 
					AreaCodeinvalid,


							SubareaCode,case when SubareaCode= ''  then '' else (SELECT TOP 1 isnull(u.SubareaCode,'')  --+ '_'+ u.countrycode
                   FROM [AIRGeography].[dbo].[tGeography] u 
                   full join [AIRGeography].[dbo].[TblAreaCity] v on u.guidExternal=v.guidExternal and 
				    RemappedGeographySID is  NULL where u.SubareaCode is not NULL and u.SubareaCode!=t.SubareaCode and u.AreaCode!=t.AreaCode  and u.countrycode!=t.countrycode
							and u.CountryCode!='US'
					order by u.GeographySID asc) end 
				SubareaCodeinvalid,

							PostalCode,case when PostalCode= ''  then '' else (SELECT TOP 1 isnull(w.PostalCode,'')-- + '_'+ w.CountryCode
                   FROM [AIRGeography].[dbo].[tGeography] w
                   full join [AIRGeography].[dbo].[TblAreaCity] x on w.guidExternal=x.guidExternal and 
				    RemappedGeographySID is  NULL where w.PostalCode is not NULL and w.PostalCode!=t.PostalCode and w.AreaCode!=t.AreaCode and w.countrycode!=t.countrycode 
					and w.CountryCode!='US'
					order by w.GeographySID desc)  end 
				PostalCodeinvalid,countrycode,latitude,longitude from 







  ( select t4.City,t4.Crestcode as CRESTACode,AreaCode,SubareaCode,PostalCode,Countrycode,latitude,longitude from (select *, ROW_NUMBER() over (PARTITION by t3.cityid,t3.crestaid,t3.areaid,t3.subareaid,t3.postalid,t3.rankid,t3.countrycode order by rankid desc) as rn from 
                   (select * from 
                   (select *,cityid+crestaid+areaid+subareaid+postalid as RankID from 
                   (select *,case when City='' then 0 else 1  end cityid,
                   case when Crestcode='' then 0 else 1  end crestaid,
                   case when Areacode='' then 0 else 1  end areaid,
                   case when Subareacode='' then 0 else 1  end subareaid,
                   case when Postalcode='' then 0 else 1  end postalid
                   from
                   (SELECT isnull(b.CityName,'') City,
                   isnull(cast(CRESTACode as nvarchar),'') Crestcode,isnull(cast(a.AreaCode as nvarchar),'') AreaCode,isnull(cast(a.SubareaCode as nvarchar),'') SubareaCode,
                   isnull(cast(a.PostalCode as nvarchar),'') PostalCode,
                   isnull(a.countrycode,'') countrycode,isnull(cast(latitude as nvarchar),'') latitude,isnull(cast(longitude as nvarchar),'') longitude
                   
                   FROM [AIRGeography].[dbo].[tGeography] a 
                   full join [AIRGeography].[dbo].[tUSCity] b on a.GeographySID=b.GeographySID and 
				    RemappedGeographySID is  NULL
                   ) t ) t1) t2  )t3 ) t4 where  countrycode='US' and latitude not like ('0.%') and longitude not like ('0.%') and t4.rn=1  )t) 
				   



















-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------invalid  US---------------------------------------------------------------------------------------------------------------------