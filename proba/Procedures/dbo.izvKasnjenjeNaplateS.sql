SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[izvKasnjenjeNaplateS]   @dimRadnik int,  @Sifra int, @dimValuta int
as
select  dr.Naziv Zastupnik, 
	c.factPolisa, c.Polisa,d1.Datum, fp.Rata, fp.Placeno, DATEDIFF(DAY, d1.Datum, getdate())  kasnjenje,
	u.Naziv Ugovarac, v.Valuta, d.Produkt_ID, d.ProduktName Produkt, dbo.Kod+' '+dbo.Opis dboKod, ISNULL(fp.VS, c.Ponuda) Ponuda, c.dimUgovarac,
	case WHEN c.dimBOKod is not NULL THEN 3 WHEN fp.Rata-fp.Placeno <1 then 1 else 2 end RB
from factPolise c 
		INNER JOIN sifPolise sp ON c.factPolisa = sp.factPolisa and sp.TipSifarnika=2
	   INNER JOIN factPropisi fp ON c.factPolisa=fp.factPolisa
	   inner join dimStatusi ds on c.dimStatus=ds.dimStatus
       INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
       INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
       INNER JOIN dimValute v on c.dimValuta=v.dimValuta
       INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
	   INNER JOIN dimDatumi d1 ON fp.DatDospeca=d1.DimDatum
	   left JOIN dimPodProdukti dpp ON c.dimPodProdukt=dpp.dimPodProdukt
	   LEFT JOIN dimBOKodovi dbo on c.dimBOKod=dbo.dimBOKod
where d1.Datum <getdate() and fp.Rata-fp.Placeno>0  and c.dimRadnik=@dimRadnik AND sp.Sifra=@Sifra and c.dimValuta=@dimValuta and fp.Porez=0 
order by 1,3,4 
GO
