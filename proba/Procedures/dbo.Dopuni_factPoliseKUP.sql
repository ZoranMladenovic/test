SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Dopuni_factPoliseKUP]
as
DECLARE @datum int
select @datum=DimDatum from dimDatumi WHERE Datum=CAST(getdate() as date)

UPDATE f 
SET DospelaPremija=a.dospeloPremijaN,
	DospeloPorez=a.dospeloPorezN,
	PlacenoPremija=a.PlacenaPremijaN,
	PlacenoPorez=a.PlacenPorezN,
	NerasknjizenaUplata=a.NerasknjizenoN
from factPolise f inner JOIN
	(select a.factPolisa,
		SUM(case when porez=0 AND b.DatDospeca<=@datum then b.Rata else 0 end) dospeloPremijaN,
		SUM(case when porez=0 AND b.DatDospeca<=@datum then b.Placeno else 0 end) PlacenaPremijaN,
		SUM(case when porez<0 AND b.DatDospeca<=@datum then b.Rata else 0 end) dospeloPorezN,
		SUM(case when porez<0 AND b.DatDospeca<=@datum then b.Placeno else 0 end) PlacenPorezN,
		SUM(case when b.DatDospeca>@datum then b.Placeno else 0 end) NerasknjizenoN
	from factPolise a inner JOIN factPropisi b on a.factPolisa=b.factPolisa
	WHERE a.Poreklo=2
	GROUP by a.factPolisa) a on f.factPolisa=a.factPolisa
WHERE f.Poreklo=2
GO
