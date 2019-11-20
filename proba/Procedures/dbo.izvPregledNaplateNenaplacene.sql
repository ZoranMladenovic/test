SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

--declare @userid int=501234,  @DatumOd date='2017-09-01', @DatumDo date='2017-09-17'

CREATE procedure [dbo].[izvPregledNaplateNenaplacene] @UserID int,  @DatumOd date, @DatumDo date
as

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT	o.OJ_ID, o.OjName, r.dimRadnik, r.SifraZastupnika, r.Naziv Zastupnik, c.Sifra, c.opis Produkt, ISNULL(a.Naplaceno, 0) Naplaceno, ISNULL(b.nenaplaceno, 0) Nenaplaceno,v.dimValuta, v.Valuta Val
FROM (SELECT a.dimRadnik, sp.Sifra, SUM(b.iznos) Naplaceno, a.dimValuta
	FROM dbo.fSviPodredjeni(@UserID) a0
		INNER JOIN factPolise a ON a0.val = a.dimRadnik
		INNER JOIN factUplate b ON a.factPolisa = b.factPolisa
		INNER JOIN dimDatumi d1 ON b.DatumUplate = d1.DimDatum
		INNER JOIN factPropisi fp ON b.factPropis = fp.factPropis
		INNER JOIN sifPolise sp ON a.factPolisa = sp.factPolisa
	WHERE sp.TipSifarnika = 2 AND d1.Datum BETWEEN @DatumOd AND @DatumDo AND fp.Porez = 0
	GROUP BY a.dimRadnik, sp.Sifra, a.dimValuta) a
	FULL JOIN (SELECT a.dimRadnik, sp.Sifra, SUM(a.DospelaPremija - a.PlacenoPremija) nenaplaceno, a.dimValuta
		FROM dbo.fSviPodredjeni(@UserID) a0
			INNER JOIN factPolise a ON a0.val = a.dimRadnik
			INNER JOIN sifPolise sp ON a.factPolisa = sp.factPolisa
		WHERE sp.TipSifarnika = 2
		GROUP BY a.dimRadnik, sp.Sifra, a.dimValuta) b ON a.dimRadnik = b.dimRadnik AND a.Sifra = b.Sifra AND a.dimValuta = b.dimValuta
	INNER JOIN dimSifarnici c ON c.Sifra = ISNULL(a.Sifra, b.Sifra) AND c.TipSifarnika = 2
	INNER JOIN dimRadnici r ON r.dimRadnik = ISNULL(a.dimRadnik, b.dimRadnik)
	INNER JOIN dimOj o ON r.dimOjPripada = o.dimOj
	INNER JOIN dimValute v ON v.dimValuta = ISNULL(a.dimValuta, b.dimValuta)
WHERE ISNULL(a.Naplaceno, 0) <> 0 OR ISNULL(b.nenaplaceno, 0) <> 0
ORDER BY o.Nivo, o.OJ_ID, r.SifraZastupnika, Produkt, Val
GO
