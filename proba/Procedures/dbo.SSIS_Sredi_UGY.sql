SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SSIS_Sredi_UGY]
as
truncate table UGY

select Poistka_ID BrojPolise, Po_Verzia_No Verzija,  VerzijaOd,  cast(isnull(VerzijaDo, kon_dat) AS DATE) verzijaDo, convert(varchar(5), goddat,104) GodDat
into #t
from SSIS_Polise
where Poistka_ID>1

insert UGY(BrojPolise,godina,Verzija)
Select BrojPolise, Godina,  MAX(Verzija)
from #t t inner JOIN (select DISTINCT Godina from DIMDatumi) g 
	on t.VerzijaOd < case when GodDat='29.02' then  EOMONTH (DATEFROMPARTS(g.godina+1,right(GodDat,2),28)) else DATEFROMPARTS(g.godina+1,right(GodDat,2),left(GodDat,2)) END
		and t.verzijaDo > case when GodDat='29.02' then  EOMONTH (DATEFROMPARTS(g.godina,right(GodDat,2),28)) else DATEFROMPARTS(g.godina,right(GodDat,2),left(GodDat,2)) END
GROUP BY BrojPolise, godina
GO
