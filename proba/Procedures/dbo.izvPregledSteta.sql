SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPregledSteta] @UserID int, @DatumZakljucenjaOd date, @DatumZakljucenjaDo date, @DatumNastankaOd date, @DatumNastankaDo date,  @polisa bigint=null, @ponuda varchar(100)=null
as

select c.Polisa, c.Ponuda, dp.ProduktName, u.Naziv, d1.Datum VaziOd, d.SkodaID, d3.Datum DatumPrijave, d4.Datum DatumNastanka, d.StatusOpis, c.factPolisa, d.factSteta
from dbo.fSviPodredjeni(@UserID) a
	INNER JOIN factPolise c ON a.val=c.dimRadnik
	INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
	inner JOIN factStete d on c.factPolisa=d.factPolisa
	INNER JOIN dimDatumi d1 ON c.VaziOd=d1.DimDatum
	INNER JOIN dimDatumi d3 on d.DatumPrijave=d3.DimDatum
	INNER JOIN dimDatumi d4 on d.DatumNastanka=d4.DimDatum
	INNER JOIN dimProdukti dp on c.dimProdukt=dp.dimProdukt
WHERE d1.Datum BETWEEN @DatumZakljucenjaOd AND @DatumZakljucenjaDo and d3.Datum BETWEEN @DatumNastankaOd AND @DatumNastankaDo
	 and (c.Polisa=@polisa or @polisa is NULL) and (c.Ponuda=@ponuda or @ponuda is NULL)
ORDER BY d3.Datum
GO
