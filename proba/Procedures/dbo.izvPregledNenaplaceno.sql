SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPregledNenaplaceno] @dimRadnik int,  @DatumOd date, @DatumDo date, @Sifra int, @dimValuta int
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select b.factPolisa, c.Polisa, c.Ponuda, dr.SifraZastupnika, dr.Naziv Zastupnik, d1.Datum, b.Iznos,
	u.Naziv Ugovarac, v.Valuta, d.Produkt_ID, d.ProduktName Produkt, sp1.Opis GrupaProdukta, d2.Datum DatDospeca, b.Opis
from factPolise c inner JOIN factUplate b on c.factPolisa=b.factPolisa
	INNER JOIN factPropisi fp ON b.factPropis=fp.factPropis
	INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
	INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
	INNER JOIN dimValute v on c.dimValuta=v.dimValuta
	INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
	INNER JOIN dimDatumi d1 ON b.DatumUplate=d1.DimDatum
	INNER JOIN sifPolise sp ON c.factPolisa = sp.factPolisa and sp.TipSifarnika=2
	INNER JOIN dimSifarnici sp1 ON sp.Sifra = sp1.Sifra AND sp.TipSifarnika = sp1.TipSifarnika
	inner join dimDatumi d2 on fp.DatDospeca=d2.DimDatum
where d1.Datum BETWEEN @DatumOd and @DatumDo and fp.Porez=0 and c.dimRadnik=@dimRadnik and c.dimValuta=@dimValuta and sp1.Sifra=@Sifra and b.Iznos <>0
order by d.Produkt_ID, c.Polisa, d1.Datum, d2.Datum
GO
