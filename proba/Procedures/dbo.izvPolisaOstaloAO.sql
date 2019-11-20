SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPolisaOstaloAO] @factPolisa int
as
select d1.Datum VaziOd,
	JSON_VALUE(OstaloJS,'$.VremePocetka') VremePocetka,
	d2.Datum VaziDo,
	JSON_VALUE(OstaloJS,'$.VremeZavrsetka') VremeZavrsetka,
	JSON_VALUE(OstaloJS,'$.PrethodniOsiguravac') PrethodniOsiguravac,
	JSON_VALUE(OstaloJS,'$.Pred_Poistka') Pred_Poistka,
	JSON_VALUE(OstaloJS,'$.PrethodniStepen') PrethodniStepen,
	JSON_VALUE(OstaloJS,'$.TekuciStepen') TekuciStepen,
	s.Opis Preneta
from factPoliseOstalo a inner JOIN factPolise b on a.factPolisa=b.factPolisa
	INNER join dimDatumi d1 on b.VaziOd=d1.DimDatum
	INNER join dimDatumi d2 on b.VaziDo=d2.DimDatum
	LEFT JOIN dimSifarnici s ON JSON_VALUE(OstaloJS,'$.Preneta') =s.Sifra and s.TipSifarnika=3
WHERE b.factPolisa=@factPolisa

GO
