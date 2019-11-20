SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[izvSkadencar]  @UserID int, @GrupaProdukta varchar(5000), @DatOd date, @DatDo date, @tip smallint
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select r.SifraZastupnika, r.Naziv Zastupnik, a.Polisa, a.Ponuda, a.dimUgovarac, u.Naziv Ugovarac, d3.Datum DatumObnove, d4.Datum DatumSklapanja, d1.Datum VaziOd, 
	case when d2.Datum='2199-12-31' then null else d2.Datum END VaziDo, 
	case WHEN a.DatumDoObnove=a.VaziDo then 'Istek' else 'Obnova' end TipObnove,
	p.Produkt_ID, p.ProduktName, dpp.PodProduktNaziv, pg.ProduktName GrupaProdukta,
	a.PremijaPoRizicima, a.DospelaPremija, a.PlacenoPremija, a.BrojPrijavljenihSteta, bok.Opis KodNaplate, a.factPolisa, v.Valuta
from dbo.fSviPodredjeni(@UserID) f INNER JOIN factPolise a ON f.val=a.dimRadnik
	inner JOIN dimDatumi d1 on a.VaziOd=d1.DimDatum
	inner JOIN dimDatumi d2 on a.VaziDo=d2.DimDatum
	inner JOIN dimDatumi d3 on a.DatumDoObnove=d3.DimDatum
	inner JOIN dimDatumi d4 on a.DatumSklapanja=d4.DimDatum
	inner JOIN dimRadnici r on a.dimRadnik=r.dimRadnik
	inner join dimUgovaraci u on a.dimUgovarac=u.dimUgovarac
	inner join dimProdukti p on a.dimProdukt=p.dimProdukt
	inner JOIN dimProdukti pg on pg.dimProdukt=p.Nadredjena
	INNER JOIN dimValute v on a.dimValuta=v.dimValuta
	LEFT JOIN dimPodProdukti dpp on a.dimPodProdukt=dpp.dimPodProdukt
	LEFT JOIN dimBOKodovi bok on a.dimBOKod=bok.dimBOKod
	INNER JOIN STRING_SPLIT(@GrupaProdukta,',') ss on pg.dimProdukt=ss.value
WHERE d3.Datum BETWEEN @DatOd and @DatDo and  ((a.DatumDoObnove=a.VaziDo and @tip=1) or (a.DatumDoObnove<>a.VaziDo and @tip=2) or @tip=3)
order BY 1


GO
