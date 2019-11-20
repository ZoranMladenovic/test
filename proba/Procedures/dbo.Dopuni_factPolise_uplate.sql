SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Dopuni_factPolise_uplate]
as
declare @datum int
select @datum=DimDatum from dimDatumi WHERE Datum=cast(getdate() as DATE)

/*
update a
SET DospelaPremija=b.rata, PlacenoPremija=b.placeno
from factPolise a INNER JOIN
(
select a.factPolisa, sum(b.Rata) rata, sum(b.Placeno) placeno
from factPolise a INNER JOIN factPropisi b on a.factPolisa=b.factPolisa
WHERE b.Porez=0 and b.DatDospeca<=@datum
group BY a.factPolisa
) b on a.factPolisa=b.factPolisa


update a
SET DospeloPorez=b.rata, PlacenoPorez=b.placeno
from factPolise a INNER JOIN
(
select a.factPolisa, sum(b.Rata) rata, sum(b.Placeno) placeno
from factPolise a INNER JOIN factPropisi b on a.factPolisa=b.factPolisa
WHERE b.Porez=-1 and b.DatDospeca<=@datum
group BY a.factPolisa
) b on a.factPolisa=b.factPolisa
*/

UPDATE f 
SET DospelaPremija=a.dospeloPremijaN,
	DospeloPorez=a.dospeloPorezN,
	PlacenoPremija=a.PlacenaPremijaN,
	PlacenoPorez=a.PlacenPorezN
from factPolise f inner JOIN
	(select a.factPolisa,
		SUM(case when porez=0 then b.Rata else 0 end) dospeloPremijaN,
		SUM(case when porez=0 then b.Placeno else 0 end) PlacenaPremijaN,
		SUM(case when porez<0 then b.Rata else 0 end) dospeloPorezN,
		SUM(case when porez<0 then b.Placeno else 0 end) PlacenPorezN
	from factPolise a inner JOIN factPropisi b on a.factPolisa=b.factPolisa
	WHERE b.DatDospeca<=@datum AND a.Poreklo=1 
	GROUP by a.factPolisa) a on f.factPolisa=a.factPolisa


update a
SET NerasknjizenaUplata=b.placeno
from factPolise a INNER JOIN
(
select a.factPolisa, sum(a.Placeno) placeno 
FROM (
select a.factPolisa,  placeno
from factPolise a INNER JOIN factPropisi b on a.factPolisa=b.factPolisa
WHERE b.DatDospeca>@datum and b.Placeno <> 0
UNION
select a.factPolisa, b.Iznos 
FROM factPolise a inner JOIN factUplate b on a.factPolisa=b.factPolisa
WHERE b.factPropis=0) a
group BY a.factPolisa
) b on a.factPolisa=b.factPolisa


--Stete
update factPolise
SET BrojPrijavljenihSteta=b.broj, IsplaceniIznosSteta=b.IsplaceniIznos, RezervisaniIznosSteta=b.RezervisaniIznos
from factPolise a inner JOIN (select factPolisa, count(*) broj, sum(IsplaceniIznos) IsplaceniIznos, sum(RezervisaniIznos) RezervisaniIznos from factStete GROUP by factPolisa) b on a.factPolisa=b.factPolisa
GO
