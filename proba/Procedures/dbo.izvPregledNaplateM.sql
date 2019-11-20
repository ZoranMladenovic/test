SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--DECLARE @UserID int=500475, @DatumZakljucenjaOd date='2017-04-01', @DatumZakljucenjaDo date='2017-05-17',@Zastupnik varchar(1000)='3842,4211,301,5004,7002,4394,513,4649,4234,129,4397,3258,3942,3003,6100,4366,3671,4650'

CREATE procedure [dbo].[izvPregledNaplateM] @UserID int, @DatumZakljucenjaOd date, @DatumZakljucenjaDo date
as
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
select dr.Naziv Zastupnik, b.Iznos, v.Valuta, 
       dp1.ProduktName GrupaProdukta, d.Produkt_ID, d.ProduktName Produkt, do.OJ_ID, dr.dimRadnik, v.dimValuta, dp1.dimProdukt dimGrupe, d.dimProdukt,do.dimOj
from dbo.fSviPodredjeni(@UserID) a INNER JOIN factPolise c ON a.val=c.dimRadnik
       INNER JOIN dimRadnici dr on c.dimRadnik=dr.dimRadnik
	   inner JOIN factUplate b on c.factPolisa=b.factPolisa
       INNER JOIN dimValute v on c.dimValuta=v.dimValuta
       INNER JOIN dimProdukti d on c.dimProdukt=d.dimProdukt
       inner JOIN dimProdukti dp1 on d.Nadredjena=dp1.dimProdukt
	   INNER JOIN dimoj do on c.dimOJ=do.dimOj
	   INNER JOIN dimDatumi d1 ON b.DatumUplate=d1.DimDatum
where d1.Datum BETWEEN @DatumZakljucenjaOd and @DatumZakljucenjaDo




GO
