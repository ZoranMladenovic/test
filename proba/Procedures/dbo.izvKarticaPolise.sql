SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvKarticaPolise] @factPolisa int
as
select a.Predpis_ID, d1.Datum DatumDospeca, d2.Datum DatOd, d3.Datum DatDo, a.Rata, d4.Datum DatumUplate, b.Iznos Uplata, case when a.porez=-1 then 'Porez ' else '' end + isnull(b.Opis,'')  Opis, c.Polisa, c.Ponuda
from factPropisi a INNER JOIN factUplate b ON a.factPropis=b.factPropis 
	INNER JOIN dimDatumi d1 ON a.DatDospeca=d1.DimDatum
	INNER JOIN dimDatumi d2 ON a.DatOd=d2.DimDatum
	INNER JOIN dimDatumi d3 ON a.DatDo=d3.DimDatum
	INNER JOIN dimDatumi d4 ON b.DatumUplate=d4.DimDatum
	inner JOIN factPolise c ON a.factPolisa=c.factPolisa
WHERE a.factPolisa=@factPolisa
ORDER BY a.DatDospeca, a.Predpis_ID, b.DatumUplate, b.Uplata_ID
GO
