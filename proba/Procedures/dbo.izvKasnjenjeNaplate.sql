SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[izvKasnjenjeNaplate]  @UserID int, @dug int, @dana int
as
select do.OJ_ID, dr.Naziv Zastupnik, 
	c.factPolisa, c.Polisa,d1.Datum, fp.Rata, fp.Placeno, DATEDIFF(DAY, d1.Datum, getdate())  kasnjenje,
	u.Naziv Ugovarac, v.Valuta, d.Produkt_ID, d.ProduktName Produkt, dss.Opis, dbo.Kod+' '+dbo.Opis dboKod, ISNULL(fp.VS, c.Ponuda) Ponuda, c.dimUgovarac
from dbo.fSviPodredjeni(@UserID) a INNER JOIN factPolise c ON a.val=c.dimRadnik
	   INNER JOIN factPropisi fp ON c.factPolisa=fp.factPolisa
	   inner join dimStatusi ds on c.dimStatus=ds.dimStatus
       INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
       INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
       INNER JOIN dimValute v on c.dimValuta=v.dimValuta
       INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
       INNER JOIN dimoj do on c.dimOJ=do.dimOj
	   INNER JOIN dimDatumi d1 ON fp.DatDospeca=d1.DimDatum
	   inner JOIN dimSifarnici dss on fp.Porez=dss.Sifra and dss.TipSifarnika=1
	   left JOIN dimPodProdukti dpp ON c.dimPodProdukt=dpp.dimPodProdukt
	   LEFT JOIN dimBOKodovi dbo on c.dimBOKod=dbo.dimBOKod
where d1.Datum <getdate() and fp.Rata-fp.Placeno>=@Dug AND DATEDIFF(DAY, d1.Datum, getdate())>=@dana
order by 1,2,4,5
GO
