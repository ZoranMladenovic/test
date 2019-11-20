SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--DECLARE @UserID int=500475, @DatumZakljucenjaOd date='2017-04-01', @DatumZakljucenjaDo date='2017-05-17',@Zastupnik varchar(1000)='3842,4211,301,5004,7002,4394,513,4649,4234,129,4397,3258,3942,3003,6100,4366,3671,4650'

CREATE procedure [dbo].[izvPregledNaplate] @UserID int, @DatumZakljucenjaOd date, @DatumZakljucenjaDo date
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select b.factPolisa, c.Polisa, c.Ponuda, dr.SifraZastupnika, dr.Naziv Zastupnik, sum(b.iznos) Iznos, 
	u.Naziv Ugovarac, v.Valuta, d.Produkt_ID, d.ProduktName Produkt, do.OJ_ID, do.OjName
from dbo.fSviPodredjeni(@UserID) a INNER JOIN factPolise c ON a.val=c.dimRadnik
       inner JOIN factUplate b on c.factPolisa=b.factPolisa
	   INNER JOIN factPropisi fp ON b.factPropis=fp.factPropis
       INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
       INNER JOIN dimUgovaraci u on c.dimUgovarac=u.dimUgovarac
       INNER JOIN dimValute v on c.dimValuta=v.dimValuta
       INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
       INNER JOIN dimoj do on c.dimOJ=do.dimOj
	   INNER JOIN dimDatumi d1 ON b.DatumUplate=d1.DimDatum
where d1.Datum BETWEEN @DatumZakljucenjaOd and @DatumZakljucenjaDo and fp.Porez=0
group BY b.factPolisa, c.Polisa, c.Ponuda, dr.SifraZastupnika, dr.Naziv, u.Naziv, v.Valuta, d.Produkt_ID, d.ProduktName, do.OJ_ID, do.OjName
GO
