SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 
CREATE procedure [dbo].[napuni_dimProdukti] 
as 
 
truncate table dimProdukti 
truncate table dimPodProdukti 
 
update a 
set Nadredjena=b.dimProdukt 
from ssis_produkti a inner JOIN SSIS_Produkti b on a.NadredjenaID=b.Produkt_Id	 
 
INSERT dimProdukti(dimProdukt, Produkt_ID, ProduktName, Nadredjena, Nivo) 
select dimprodukt, Produkt_Id, Produkt_Naziv, isnull(Nadredjena,0), case WHEN Nadredjena is NULL then 0 when NadredjenaID=-999 then 1 else 2 END from SSIS_Produkti --WHERE Nadredjena IS NOT NULL 
 
 
UPDATE dimProdukti SET Poreklo=0 where Nivo<=1 
UPDATE dimProdukti SET Poreklo=1 where Nivo>1 
 
insert	 dimPodProdukti(Produkt_Id, PodProdukt_Id, PodProduktNaziv, Specijal) 
select b.Produkt_Id, b.Text_tlac_nr, b.Text_tlac,0 
from  SSIS_Podprodukti b  
 
-- ZK ovaj podprodukt ima duple polise 
insert	 dimPodProdukti(Produkt_Id, PodProdukt_Id, PodProduktNaziv, Specijal) 
VALUES (1010,99,'ZK',1) 
GO
