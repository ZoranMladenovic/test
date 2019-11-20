SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[izvControlingBrojKlijenataPeriodNBS] @DatOd date, @DatDo date
as
select LOB5, SUM(brojosoba) BrojOsoba
from (
select a.LOB5, a.Polisa, isnull(COALESCE( json_value([ObjekatJS],'$.BrojOsoba'),json_value([ObjekatJS],'$.BrojPutnika'), cast(json_value([ObjekatJS],'$.BrojSedista') as int)+1,json_value([ObjekatJS],'$.Kapacitet'), a.BrojOsoba,1 ), 1) BrojOsoba, a.ObjekatJS
FROM
(SELECT distinct ro.LOB5, a.Polisa, o.ObjekatJS, 1 BrojOsoba
from factPolise a
       inner join dimDatumi d1 on a.VaziOd = d1.DimDatum
       inner join dimDatumi d2 on a.VaziDo = d2.DimDatum
	   LEFT join dimDatumi d3 on a.StornoDat = d3.DimDatum
	   inner JOIN dimProdukti dp on a.dimProdukt=dp.dimProdukt
       INNER join factOsiguraniRizici ro on a.factPolisa=ro.factPolisa
	   INNER JOIN dimRizici dr on dr.dimRizik=ro.dimRizik
       inner join dimObjekti o on o.factPolisa=a.factPolisa
	   inner JOIN dimStatusi ds on a.dimStatus=ds.dimStatus
WHERE  d1.Datum<=@DatDo and isnull(d3.Datum, d2.Datum)>=@DatOd and ds.StatusGrupa <>'Netaksirana'
	and o.TipObjekta in (1,7) AND left(ro.LOB5,2) in ('01', '02','20','21','22') 
	AND dp.Produkt_ID<>711
UNION
SELECT distinct ro.LOB5, a.Polisa, o.ObjekatJS,1
from factPolise a
       inner join dimDatumi d1 on a.VaziOd = d1.DimDatum
       inner join dimDatumi d2 on a.VaziDo = d2.DimDatum
       LEFT join dimDatumi d3 on a.StornoDat = d3.DimDatum
	   inner JOIN dimProdukti dp on a.dimProdukt=dp.dimProdukt
       INNER join factOsiguraniRizici ro on a.factPolisa=ro.factPolisa
	   INNER JOIN dimRizici dr on dr.dimRizik=ro.dimRizik
       inner join dimObjekti o on o.factOsiguraniRizik=ro.factOsiguraniRizik
	   inner JOIN dimStatusi ds on a.dimStatus=ds.dimStatus
WHERE  d1.Datum<=@DatDo and isnull(d3.Datum, d2.Datum)>=@DatOd and ds.StatusGrupa <>'Netaksirana'
	and o.TipObjekta not in (1,3,7) AND left(ro.LOB5,2) in ('01', '02','20','21','22') 
	AND dp.Produkt_ID<>711
UNION ALL
SELECT distinct c.LOB, a.Poistka_ID, '{}', a.BrojOsoba
FROM [WiWaDW].[dbo].[SSIS_NOsobeSve] a inner JOIN SSIS_Polise b on a.Poistka_ID=b.Poistka_ID
       inner JOIN SSIS_SifNezgodaLOB c on b.ObjCinnost_ID=c.ObjCinnost_ID
WHERE a.Produkt_ID=711  and isnull(Tech_Verzia_uc_dat_do, '2099-12-31')>@DatOd and Tech_Verzia_uc_dat<=@DatDo and b.Stav_PZ not like 'C%'
) a
)aa 
group BY aa.LOB5
order by 1,2


GO
