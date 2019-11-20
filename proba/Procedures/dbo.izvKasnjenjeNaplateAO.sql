SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[izvKasnjenjeNaplateAO]  @dimRadnik int, @BrojDana int
as
declare @d1 int
select @d1=DimDatum from dimdatumi WHERE Datum=cast(dateadd(day,-@BrojDana,getdate()) as DATE)

select do.OJ_ID, dr.Naziv Zastupnik, 
	c.factPolisa, c.Polisa,d1.Datum, fp.Rata, fp.Placeno, DATEDIFF(DAY, d1.Datum, getdate())  kasnjenje,
	u.Naziv Ugovarac, v.Valuta, d.Produkt_ID, d.ProduktName Produkt, dss.Opis, dbo.Kod+' '+dbo.Opis dboKod, ISNULL(fp.VS, c.Ponuda) Ponuda, c.dimUgovarac
from factPolise c 
	   INNER JOIN factPropisi fp ON c.factPolisa=fp.factPolisa
	   inner join dimStatusi ds on c.dimStatus=ds.dimStatus
       INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
       INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
       INNER JOIN dimValute v on c.dimValuta=v.dimValuta
       INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
       INNER JOIN dimoj do on c.dimOJ=do.dimOj
	   INNER JOIN dimDatumi d1 ON fp.DatDospeca=d1.DimDatum
	   INNER JOIN dimDatumi d2 ON c.DatumSklapanja=d2.DimDatum
	   inner JOIN dimSifarnici dss on fp.Porez=dss.Sifra and dss.TipSifarnika=1
	   left JOIN dimPodProdukti dpp ON c.dimPodProdukt=dpp.dimPodProdukt
	   LEFT JOIN dimBOKodovi dbo on c.dimBOKod=dbo.dimBOKod
where c.dimRadnik=@dimRadnik and d.Produkt_ID=1010 and fp.DatDospeca <=@d1
	and d2.Datum>='20160101' and d1.Datum <getdate()  and ds.Status_ID!='S22'
	and  fp.Rata-fp.Placeno>0
order by d1.Datum, c.Polisa
GO
