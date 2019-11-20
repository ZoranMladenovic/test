SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPregledPolisaUgovarac] @UserID int, @mb varchar(20)=null, @polisa bigint=null, @ponuda varchar(100)=null, @naziv varchar(20)=null,  @StatusGrupa varchar(500)
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @naziv1 varchar(20), @mb1 varchar(20)
select @naziv1='%'+isnull(@naziv,'')+'%', @mb1=isnull(@mb,'')+'%'

IF @polisa is not NULL
	select top 10000 OJ_ID, OjName, SifraZastupnika, dr.Naziv Zastupnik, dr.NazivRM, 
		c.Polisa, c.Ponuda, d.Produkt_ID, d.ProduktName, e.Status_ID, e.StatusNaziv, u.Naziv Ugovarac,p.PeriodaNaziv,
		d1.Datum VaziOd, d2.Datum VaziDo, d3.Datum DatumObnove, z.ZakljucenjeNaziv,
		c.Premija, c.PremijaPoRizicima, c.DospelaPremija, c.DospeloPorez, c.PlacenoPremija, c.PlacenoPorez, c.NerasknjizenaUplata, v.Valuta Valuta_ID, c.factPolisa,
		c.BrojPrijavljenihSteta, c.IsplaceniIznosSteta, c.RezervisaniIznosSteta, c.dimUgovarac
	from dbo.fSviPodredjeni(@UserID) a INNER JOIN factPolise c ON a.val=c.dimRadnik
		INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
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
	WHERE u.RC_ICO like @mb1 and c.Polisa=@polisa 
			and c.Ponuda=isnull(@ponuda, c.Ponuda) and u.Naziv LIKE @naziv1
	order by 1,3, 8, 6
else IF @ponuda is not NULL
	select top 10000 OJ_ID, OjName, SifraZastupnika, dr.Naziv Zastupnik, dr.NazivRM, 
		c.Polisa, c.Ponuda, d.Produkt_ID, d.ProduktName, e.Status_ID, e.StatusNaziv, u.Naziv Ugovarac,p.PeriodaNaziv,
		d1.Datum VaziOd, d2.Datum VaziDo, d3.Datum DatumObnove, z.ZakljucenjeNaziv,
		c.Premija, c.PremijaPoRizicima, c.DospelaPremija, c.DospeloPorez, c.PlacenoPremija, c.PlacenoPorez, c.NerasknjizenaUplata, v.Valuta Valuta_ID, c.factPolisa,
		c.BrojPrijavljenihSteta, c.IsplaceniIznosSteta, c.RezervisaniIznosSteta, c.dimUgovarac
	from dbo.fSviPodredjeni(@UserID) a INNER JOIN factPolise c ON a.val=c.dimRadnik
		INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
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
	WHERE u.RC_ICO like @mb1 and c.Ponuda=@ponuda and u.Naziv LIKE @naziv1
	order by 1,3, 8, 6
ELSE 
BEGIN
	SELECT dimUgovarac, u.Naziv Ugovarac 
	INTO #u
	from dimUgovaraci u 	
	WHERE u.RC_ICO like @mb1 and u.Naziv LIKE @naziv1

	select top 10000 OJ_ID, OjName, SifraZastupnika, dr.Naziv Zastupnik, dr.NazivRM, 
		c.Polisa, c.Ponuda, d.Produkt_ID, d.ProduktName, e.Status_ID, e.StatusNaziv, u.Ugovarac,p.PeriodaNaziv,
		d1.Datum VaziOd, d2.Datum VaziDo, d3.Datum DatumObnove, z.ZakljucenjeNaziv,
		c.Premija, c.PremijaPoRizicima, c.DospelaPremija, c.DospeloPorez, c.PlacenoPremija, c.PlacenoPorez, c.NerasknjizenaUplata, v.Valuta Valuta_ID, c.factPolisa,
		c.BrojPrijavljenihSteta, c.IsplaceniIznosSteta, c.RezervisaniIznosSteta, c.dimUgovarac
	from dbo.fSviPodredjeni(@UserID) a INNER JOIN factPolise c ON a.val=c.dimRadnik
		INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
		INNER JOIN dimStatusi e ON c.dimStatus=e.dimStatus
		INNER JOIN dimDatumi d1 ON c.VaziOd=d1.DimDatum
		INNER JOIN dimDatumi d2 ON c.VaziDo=d2.DimDatum
		INNER JOIN dimDatumi d3 on c.DatumPoslednjeObnove=d3.DimDatum
		INNER JOIN #u u on c.dimUgovarac=u.dimUgovarac
		INNER JOIN dimPeriodike p on c.dimDinamika=p.dimPeriodka
		INNER JOIN dimValute v on c.dimValuta=v.dimValuta
		INNER JOIN dimZakljucenja z ON c.dimZakljucenje=z.dimZakljucenje
		INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
		INNER JOIN dimoj do on c.dimOJ=do.dimOj
		inner join STRING_SPLIT(@StatusGrupa,',') sg on e.StatusGrupa=sg.value
	order by 1,3, 8, 6
END
GO
