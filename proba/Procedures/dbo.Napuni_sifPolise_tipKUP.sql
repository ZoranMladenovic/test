SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_sifPolise_tipKUP]
as

INSERT sifPolise (TipSifarnika, Sifra, factPolisa)
select 2, 13, f.factPolisa
from factPolise f 
WHERE f.Poreklo=2
GO
