SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPropisiPoPolisi] @factPolisa int
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select a.factPropis, d1.Datum DatDospeca, d2.Datum DatOd, d3.Datum DatDo, a.Rata, a.Placeno, s.Opis Porez
from factPropisi a INNER JOIN dimDatumi d1 ON a.DatDospeca=d1.DimDatum
	INNER JOIN dimDatumi d2 ON a.DatOd=d2.DimDatum
	INNER JOIN dimDatumi d3 on a.DatDo=d3.DimDatum
	left JOIN dimSifarnici s ON a.Porez=s.Sifra and s.TipSifarnika=1
WHERE factPolisa=@factPolisa
ORDER BY d1.Datum
GO
