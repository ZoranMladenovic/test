SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPretplatePoPolisi] @factPolisa int
as
select d1.Datum, a.Iznos, a.Opis
from factUplate a INNER JOIN dimDatumi d1 ON a.DatumUplate=d1.DimDatum
WHERE factPolisa=@factPolisa AND factPropis=0
ORDER BY d1.Datum





GO
