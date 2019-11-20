SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 
Create procedure [dbo].[Napuni_DimProduktiKUP] 
as 
declare @i int 
select @i=MAX(dimProdukt) from SSIS_Produkti 
 
insert dimprodukti (dimProdukt, Nivo, Produkt_ID, Nadredjena, ProduktName, Poreklo) 
select @i+ROW_NUMBER() OVER( order by SifraVrsteOsiguranja) dimprodukt , 2 nivo, a.SifraVrsteOsiguranja, b.dimProdukt nadredjeni, a.VrstaOsiguranja,2 poreklo from SSIS_ProduktiKUP a INNER JOIN dimProdukti b on a.Nadredjeni=b.Produkt_ID 
 
GO
