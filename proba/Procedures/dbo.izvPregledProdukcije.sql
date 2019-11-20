SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPregledProdukcije] @UserID int, @DatumZakljucenjaOd date, @DatumZakljucenjaDo date, @StatusGrupa varchar(500), @tipZakljucenja varchar(500), @Produkt varchar(500), @TipUgovaraca varchar(100) 
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select OJ_ID, OjName, SifraZastupnika, dr.Naziv Zastupnik, dr.NazivRM, 
	c.Polisa, c.Ponuda, d.Produkt_ID, d.ProduktName, e.Status_ID, e.StatusNaziv, u.Naziv Ugovarac,p.PeriodaNaziv,
	d1.Datum VaziOd, d2.Datum VaziDo, d3.Datum DatumObnove, z.ZakljucenjeNaziv,
	c.Premija, c.PremijaPoRizicima, c.DospelaPremija, c.DospeloPorez, c.PlacenoPremija, c.PlacenoPorez, c.NerasknjizenaUplata, v.Valuta Valuta_ID, a.broj, c.factPolisa, dp1.ProduktName ProduktGrupa, 
	c.BrojPrijavljenihSteta, c.IsplaceniIznosSteta, c.RezervisaniIznosSteta
from dbo.fSviPodredjeni(@UserID) a
	INNER JOIN factPolise c ON a.val=c.dimRadnik
	INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
	inner JOIN dimProdukti dp1 on d.Nadredjena=dp1.dimProdukt
	INNER JOIN dimStatusi e ON c.dimStatus=e.dimStatus
	INNER JOIN dimDatumi d1 ON c.VaziOd=d1.DimDatum
	INNER JOIN dimDatumi d2 ON c.VaziDo=d2.DimDatum
	INNER JOIN dimDatumi d3 on c.DatumPoslednjeObnove=d3.DimDatum
	INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
	INNER JOIN dimPeriodike p on c.dimDinamika=p.dimPeriodka
	INNER JOIN dimValute v on c.dimValuta=v.dimValuta
	INNER JOIN dimZakljucenja z ON c.dimZakljucenje=z.dimZakljucenje
	INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
	INNER JOIN dimoj do on c.dimOJ=do.dimOj
	inner join STRING_SPLIT(@StatusGrupa,',') sg on e.StatusGrupa=sg.value
	inner join STRING_SPLIT(@tipZakljucenja,',') tz on c.dimZakljucenje=tz.value
	inner join STRING_SPLIT(@Produkt,',') pr on c.dimProdukt=pr.value
	inner join STRING_SPLIT(@TipUgovaraca,',') tu on u.FizickoLice=tu.value
WHERE d3.Datum BETWEEN @DatumZakljucenjaOd AND @DatumZakljucenjaDo
order by 1,3


GO
