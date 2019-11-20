SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvStete] @factPolisa int
as
SELECT 	a.factSteta, c.Polisa, a.SkodaID, a.BrojZahtevaArhiva,
	d1.Datum DatumNastanka, d2.Datum DatumPrijave, d3.Datum DatumPoslednjeIsplate, r.Riziko_ID, r.RizikoNaziv,
	a.StatusOpis, a.IsplaceniIznos, a.RezervisaniIznos, v1.Valuta ValutaRezervacije, a.Regres, a.OstvareniRegres
FROM factStete a 
	INNER JOIN factPolise c ON a.factPolisa = c.factPolisa
	INNER JOIN dimDatumi d1 ON a.DatumNastanka = d1.DimDatum
	INNER JOIN dimDatumi d2 ON a.DatumPrijave = d2.DimDatum
	INNER JOIN dimDatumi d3 ON a.DatumPoslednjeIsplate = d3.DimDatum
	INNER JOIN dimRizici r ON a.dimRizik = r.dimRizik
	INNER JOIN dimValute v1 ON a.dimValuta = v1.dimValuta
WHERE a.factPolisa = @factPolisa


GO
