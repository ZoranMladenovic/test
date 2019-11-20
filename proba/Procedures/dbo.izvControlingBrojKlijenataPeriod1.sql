SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvControlingBrojKlijenataPeriod1] @DatOd date, @DatDo date
as
SELECT Case when a.FizickoLice=1 then 'Fizičko' else 'Pravno' end VrstaOsiguranika, COUNT(*) broj FROM
(select DISTINCT b.RC_ICO, b.FizickoLice
from factPolise a inner join dimUgovaraci b on a.dimUgovarac=b.dimUgovarac
	inner join dimDatumi d1 on a.VaziOd = d1.DimDatum
	inner join dimDatumi d2 on a.VaziDo = d2.DimDatum
	LEFT join dimDatumi d3 on a.StornoDat = d3.DimDatum
	INNER JOIN dimProdukti p on a.dimProdukt=p.dimProdukt
	inner JOIN dimStatusi ds on a.dimStatus=ds.dimStatus
--WHERE @Datum BETWEEN d1.Datum and isnull(d3.Datum, d2.Datum)
WHERE  d1.Datum<=@DatDo and isnull(d3.Datum, d2.Datum)>=@DatOd and ds.StatusGrupa <>'Netaksirana'
) a
GROUP BY a.FizickoLice
order by 1
GO
