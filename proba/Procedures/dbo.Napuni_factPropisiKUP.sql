SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Napuni_factPropisiKUP]
as
declare @produktZK smallint

SELECT @produktZK=dimProdukt from dimProdukti WHERE Poreklo=2 AND Produkt_ID=22

insert factPropisi( factPolisa, DatOd,DatDo, DatDospeca, Rata, Placeno, Predpis_ID, DatUplate, Porez)
select  b.factPolisa, b.VaziOd, b.VaziDo, isnull(d.DimDatum, b.VaziOd) DatumDospeca, isnull(a.Iznos,0), isnull(a.Uplata,0), isnull(a.RBrRate,0), d1.DimDatum, 
	case WHEN b.dimProdukt=@produktZK then -2 else a.Tip END
from SSIS_PropisiKUP a INNER JOIN factPolise b on a.BrojPonude=b.Ponuda and b.Poreklo=2
	LEFT JOIN dimDatumi d ON a.DatumDospeca=d.Datum
	LEFT JOIN dimDatumi d1 ON a.DatumUplate=d1.Datum
WHERE iznos <>0 or a.Uplata <>0

INSERT factUplate(factPolisa, factPropis, DatumUplate, Iznos, Uplata_ID)
select  a.factPolisa, factPropis, DatUplate, Placeno,0 
FROM  factPropisi  a INNER JOIN factPolise b ON a.factPolisa=b.factPolisa
WHERE b.Poreklo=2 AND a.DatUplate >0 AND a.Rata-a.Placeno<1

GO
