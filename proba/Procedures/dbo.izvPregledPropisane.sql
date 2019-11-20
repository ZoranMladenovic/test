SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPregledPropisane] @UserID int, @DatumZakljucenjaOd date, @DatumZakljucenjaDo date
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
	b.factPolisa
   ,c.Polisa
	,dr.SifraZastupnika
   ,dr.Naziv Zastupnik
   ,sum(b.Rata) Rata
   ,sum(b.Placeno) Placeno
   ,u.Naziv Ugovarac
   ,v.Valuta
   ,d.Produkt_ID
   ,d.ProduktName Produkt
   ,do.OJ_ID
   ,do.OjName
FROM dbo.fSviPodredjeni(@UserID) a
	INNER JOIN factPolise c ON a.val = c.dimRadnik
	INNER JOIN factPropisi b ON c.factPolisa = b.factPolisa
	INNER JOIN dimRadnici dr ON c.dimRadnik = dr.dimRadnik
	INNER JOIN dimUgovaraci u ON c.dimUgovarac = u.dimUgovarac
	INNER JOIN dimValute v ON c.dimValuta = v.dimValuta
	INNER JOIN dimProdukti d ON c.dimProdukt = d.dimProdukt
	INNER JOIN dimoj do ON c.dimOJ = do.dimOj
	INNER JOIN dimDatumi d1 ON b.DatDospeca = d1.DimDatum
WHERE d1.Datum BETWEEN @DatumZakljucenjaOd AND @DatumZakljucenjaDo
GROUP BY b.factPolisa
   ,c.Polisa
	,dr.SifraZastupnika
   ,dr.Naziv
   ,u.Naziv
   ,v.Valuta
   ,d.Produkt_ID
   ,d.ProduktName
   ,do.OJ_ID
   ,do.OjName
GO
