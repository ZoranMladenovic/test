SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPregledPolisaVozilaCC] @mb varchar(20)=null, @polisa bigint=null, @ponuda varchar(100)=null, @naziv varchar(20)=null, @brojsasije varchar(20)=null, @regbroj varchar(20)=null, @marka varchar(20)=null,  @StatusGrupa varchar(500)
WITH RECOMPILE  
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @marka1 varchar(20), @naziv1 varchar(20), @Nadredjena int, @mb1 varchar(20)
select @naziv1='%'+isnull(@naziv,'')+'%', @marka1='%'+isnull(@marka,'')+'%', @mb1=isnull(@mb,'')+'%'

select @Nadredjena=dimProdukt from dimProdukti where Produkt_ID=-2

create table #t(factPolisa BIGINT)
if @mb is NOT NULL or @polisa is NOT NULL or @ponuda is NOT NULL OR @naziv is NOT NULL
BEGIN

	select distinct c.factPolisa
	INTO #t1
	from factPolise c 
		inner join dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
		INNER JOIN dimProdukti dp on c.dimProdukt=dp.dimProdukt
		INNER JOIN dimStatusi e ON c.dimStatus=e.dimStatus
		inner join STRING_SPLIT(@StatusGrupa,',') sg on e.StatusGrupa=sg.value
	WHERE dp.Nadredjena=@Nadredjena
		and	u.RC_ICO like @mb1 and c.Polisa=isnull(@polisa, c.Polisa) 
		and c.Ponuda=isnull(@ponuda, c.Ponuda) and u.Naziv LIKE @naziv1

	insert #t
	select distinct c.factPolisa
	from #t1 c inner join dimObjekti b ON b.factPolisa=c.factPolisa
	WHERE (b.vRegBroj= @regbroj or @regbroj is null)
		AND (b.vBrojSasije= @brojsasije or @brojsasije is null)
		AND b.vMarka like @marka1
END
ELSE
BEGIN

	insert #t
	select distinct c.factPolisa
	from factPolise c 
		INNER JOIN dimProdukti dp on c.dimProdukt=dp.dimProdukt
		INNER JOIN dimStatusi e ON c.dimStatus=e.dimStatus
		inner JOIN dimObjekti do on c.factPolisa=do.factPolisa
		inner join STRING_SPLIT(@StatusGrupa,',') sg on e.StatusGrupa=sg.value
	WHERE dp.Nadredjena=@Nadredjena and 
		(do.vRegBroj= @regbroj or @regbroj is null)
		AND (do.vBrojSasije= @brojsasije or @brojsasije is null)
		AND do.vMarka like @marka1
END

select OJ_ID, OjName, SifraZastupnika, dr.Naziv Zastupnik, dr.NazivRM, 
	c.Polisa, c.Ponuda, d.Produkt_ID, d.ProduktName, e.Status_ID, e.StatusNaziv, u.Naziv Ugovarac,p.PeriodaNaziv,
	d1.Datum VaziOd, d2.Datum VaziDo, d3.Datum DatumObnove, z.ZakljucenjeNaziv,
	c.Premija, c.PremijaPoRizicima, c.DospelaPremija, c.DospeloPorez, c.PlacenoPremija, c.PlacenoPorez, c.NerasknjizenaUplata, v.Valuta Valuta_ID, c.factPolisa,
	c.BrojPrijavljenihSteta, c.IsplaceniIznosSteta, c.RezervisaniIznosSteta
from  factPolise c INNER JOIN #t t on c.factPolisa=t.factPolisa
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
order by 1,3


GO
