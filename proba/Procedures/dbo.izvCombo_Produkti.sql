SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvCombo_Produkti] @GrupaProdukta varchar(1000)
as
-- komentar 2
select dimProdukt, case a.poreklo when 1 then 'KOOP - ' when 2 then 'KUP - ' else '' end + ProduktName  ProduktName 
from dimProdukti a inner JOIN STRING_SPLIT(@GrupaProdukta,',') b on a.Nadredjena=b.value
WHERE Nivo=2
GO
