SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvCombo_GrupaProdukta] 
as

select dimProdukt, ProduktName from dimProdukti WHERE Nivo=1
GO
