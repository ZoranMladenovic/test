SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_factPolisaOstalo]
as
truncate table factPoliseOstalo

INSERT factPoliseOstalo(factPolisa, OstaloJS)
select a.factPolisa,(
select VremePocetka, VremeZavrsetka, PrethodniMB, PrethodniOsiguravac, Pred_Poistka, PrethodniStepen, TekuciStepen, case when Je_Preneseny=0 then 0 else 1 end Preneta
       from SSIS_AOOstalo
       WHERE poistka_id=a.Polisa 
       FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) OstaloJS
from factPolise a
GO
