SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPregledStetaCC]  @DatumNastankaOd date, @DatumNastankaDo date,  @polisa bigint=null, @ponuda varchar(100)=null
as

select c.Polisa, c.Ponuda, dp.ProduktName, u.Naziv, d1.Datum VaziOd, d.SkodaID, d3.Datum DatumPrijave, d4.Datum DatumNastanka, d.StatusOpis, c.factPolisa, d.factSteta
from factPolise c 
	INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
	inner JOIN factStete d on c.factPolisa=d.factPolisa
	INNER JOIN dimDatumi d1 ON c.VaziOd=d1.DimDatum
	INNER JOIN dimDatumi d3 on d.DatumPrijave=d3.DimDatum
	INNER JOIN dimDatumi d4 on d.DatumNastanka=d4.DimDatum
	INNER JOIN dimProdukti dp on c.dimProdukt=dp.dimProdukt
WHERE d3.Datum BETWEEN @DatumNastankaOd AND @DatumNastankaDo
	and (c.Polisa=@polisa or @polisa is NULL) and (c.Ponuda=@ponuda or @ponuda is NULL)
ORDER BY d3.Datum
GO
