SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvStetaPlacanja] @factSteta int
as
select a.I10_Vratka_id, d1.Datum DatumOdobrenja, d2.Datum DatumPlacanja, v1.Valuta, a.PlaceniIznos, a.racun, dps.naziv
from factIsplateSteta a inner JOIN dimPrimaociSteta dps on a.dimPrimalacStete=dps.dimPrimalacStete
	INNER JOIN dimDatumi d1 ON a.DatumOdobrenja = d1.DimDatum
	INNER JOIN dimDatumi d2 ON a.DatumPlacanja = d2.DimDatum
	INNER JOIN dimValute v1 ON a.dimValuta = v1.dimValuta
where factSteta=@factSteta
GO
