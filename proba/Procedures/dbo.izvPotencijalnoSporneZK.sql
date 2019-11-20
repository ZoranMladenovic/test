SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[izvPotencijalnoSporneZK] @Datum date
as
select d.Datum DatumIzdavanja, polisa ZK, Ponuda AOPolisa 
from  factPolise a LEFT JOIN SSIS_StrogaZK b on a.Polisa=b.BrojObrasca
INNER JOIN dimDatumi d on a.VaziOd=d.DimDatum
inner join dimPodProdukti p on a.dimPodProdukt=p.dimPodProdukt
where p.Produkt_Id=1010 and p.PodProdukt_Id=99 AND b.BrojObrasca is NULL and d.Datum >=@Datum
ORDER BY 1 DESC
GO
