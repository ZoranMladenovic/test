SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_sifPolise_tip]
as
TRUNCATE table sifPolise

 -- kasko (sve ostalo)
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 1, f.factPolisa
from dimProdukti b 
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
	INNER JOIN dimUgovaraci u on f.dimUgovarac=u.dimUgovarac
 WHERE b.Produkt_ID = -2 AND u.Leasing<>1 and c.Produkt_ID not in (1010, 1011,1012, 1070)

-- MTPL
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 2, f.factPolisa
from dimProdukti b 
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
	INNER JOIN dimUgovaraci u on f.dimUgovarac=u.dimUgovarac
 WHERE b.Produkt_ID = -2 AND u.Leasing<>1 and c.Produkt_ID=1010

 -- Imovina
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 3, f.factPolisa
from dimProdukti b 
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
	LEFT JOIN dimPodProdukti c1 ON f.dimPodProdukt=c1.dimPodProdukt
	INNER JOIN dimUgovaraci u on f.dimUgovarac=u.dimUgovarac
 WHERE b.Produkt_ID = -1 AND u.Leasing<>1 and isnull(c1.PodProdukt_Id,0)<>13

 -- usevi
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 4, f.factPolisa
from dimProdukti b 
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
	inner JOIN dimPodProdukti c1 ON f.dimPodProdukt=c1.dimPodProdukt
	INNER JOIN dimUgovaraci u on f.dimUgovarac=u.dimUgovarac
 WHERE b.Produkt_ID = -1 AND u.Leasing<>1 and isnull(c1.PodProdukt_Id,0)=13 
  
-- auto nezgoda
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 6, f.factPolisa
from dimProdukti b 
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
	INNER JOIN dimUgovaraci u on f.dimUgovarac=u.dimUgovarac
 WHERE b.Produkt_ID = -2 AND u.Leasing<>1 and c.Produkt_ID=1012
 
-- Lizing za imovinu i kasko
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 7, f.factPolisa
from dimProdukti b 
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
	INNER JOIN dimUgovaraci u on f.dimUgovarac=u.dimUgovarac
 WHERE b.Produkt_ID in (-1, -2) AND u.Leasing=1

  -- Zivot, nezgoda, DZO, Putno (5,8,9,10)
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select a.TipSifarnika, a.Sifra, f.factPolisa
from dimSifarnici a inner JOIN dimProdukti b ON a.SifraChar=b.Produkt_ID
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
 WHERE a.TipSifarnika=2 and b.Produkt_ID  in (-5, -9,-10, -6)
 
 -- delimicnoi kasko
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 11, f.factPolisa
from dimProdukti b 
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
	INNER JOIN dimUgovaraci u on f.dimUgovarac=u.dimUgovarac
 WHERE b.Produkt_ID = -2 AND u.Leasing<>1 and c.Produkt_ID=1011

 -- pomoc na putu
INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 12, f.factPolisa
from dimProdukti b 
	inner JOIN dimProdukti c ON b.dimProdukt=c.Nadredjena
	INNER JOIN factPolise f ON c.dimProdukt=f.dimProdukt
	INNER JOIN dimUgovaraci u on f.dimUgovarac=u.dimUgovarac
 WHERE b.Produkt_ID = -2 AND u.Leasing<>1 and c.Produkt_ID=1070


 
GO
