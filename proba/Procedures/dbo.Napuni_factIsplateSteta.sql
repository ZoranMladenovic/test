SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_factIsplateSteta]
as

truncate table factIsplateSteta

INSERT factIsplateSteta(factSteta, DatumOdobrenja, DatumPlacanja, dimPrimalacStete, dimValuta, PlaceniIznos, I10_Vratka_id, racun)
select b.factSteta, d1.DimDatum DatumOdobrenja, d2.DimDatum DatumPlacanja, dps.dimPrimalacStete, v.dimValuta, a.PlaceniIznos, a.I10_Vratka_id,a.Banka+'-'+substring(a.Racun,1, len(a.Racun)-2)+'-'+ RIGHT(a.Racun,2) racun
from SSIS_IsplateSteta a inner JOIN factStete b on a.Skoda_ID=b.SkodaID
	INNER join dimDatumi d1 on a.DatumOdobrenja=d1.Datum
	INNER join dimDatumi d2 on a.DatumPlacanja=d2.Datum
	INNER JOIN dimValute v on a.ValutaPlacanja=v.Valuta_ID
	left join dimPrimaociSteta dps on a.Partner_ID=dps.Partner_ID
GO
