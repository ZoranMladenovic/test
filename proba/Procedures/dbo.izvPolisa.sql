SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPolisa] @factPolisa int
as
select OJ_ID, OjName, SifraZastupnika, dr.Naziv Zastupnik, dr.NazivRM, 
	c.Polisa, c.Ponuda, d.Produkt_ID, d.ProduktName, e.Status_ID, e.StatusNaziv, 
	u.Naziv Ugovarac, u.RC_ICO, u.Drzava, u.PTT, u.Grad, u.Ulica, u.Broj,
	p.PeriodaNaziv,	d1.Datum VaziOd, d2.Datum VaziDo, d3.Datum DatumObnove, 
	c.PremijaPoRizicima, c.DospelaPremija, c.DospeloPorez, c.PlacenoPremija, c.PlacenoPorez, c.NerasknjizenaUplata, v.Valuta Valuta_ID, dbo.Kod+' '+dbo.Opis dboKod, 
	c.BrojPrijavljenihSteta, c.IsplaceniIznosSteta, c.RezervisaniIznosSteta, c.dimUgovarac, dpp.PodProduktNaziv
from factPolise c
	INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
	INNER JOIN dimStatusi e ON c.dimStatus=e.dimStatus
	INNER JOIN dimDatumi d1 ON c.VaziOd=d1.DimDatum
	INNER JOIN dimDatumi d2 ON c.VaziDo=d2.DimDatum
	INNER JOIN dimDatumi d3 on c.DatumPoslednjeObnove=d3.DimDatum
	INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
	INNER JOIN dimPeriodike p on c.dimDinamika=p.dimPeriodka
	INNER JOIN dimValute v on c.dimValuta=v.dimValuta
	INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
	INNER JOIN dimoj do on c.dimOJ=do.dimOj
	LEFT JOIN dimBOKodovi dbo on c.dimBOKod=dbo.dimBOKod
	LEFT JOIN dimPodProdukti dpp ON c.dimPodProdukt=dpp.dimPodProdukt
WHERE c.factPolisa=@factPolisa




GO
