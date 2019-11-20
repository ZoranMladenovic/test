SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Napuni_dimTarife]
as

truncate table dimTarife

insert dimTarife(Tarif_ID, dimProdukt, dimRizik, NazivTarife)
select  a.Tarif_ID, p.dimProdukt, r.dimRizik, a.Objekt_txt TarifNaziv
from SSIS_Tarif a inner JOIN dimProdukti p on a.Produkt_ID=p.Produkt_ID AND p.Poreklo=1
	inner JOIN dimRizici r on a.Riziko_ID=r.Riziko_ID and r.Poreklo=1

	
GO
