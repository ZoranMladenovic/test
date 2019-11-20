SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[napuni_factUplate]
as
truncate table factUplate

INSERT factUplate(factPolisa, DatumUplate, factPropis, Iznos, Uplata_ID, Opis)
select  b.factPolisa, isnull(c.DimDatum,109573), isnull(d.factPropis,0), isnull(a.I04_Platba_sum,0), a.I03_Platba_id, a.I03_Poznamka
from SSIS_Uplate a 
	LEFT JOIN dimDatumi c ON a.I03_Pl_dat=c.Datum
	INNER JOIN factPropisi d ON a.I02_Predpis_ID=d.Predpis_ID
	INNER JOIN factPolise b ON d.factPolisa=b.factPolisa

INSERT factUplate(factPolisa, DatumUplate, factPropis, Iznos, Uplata_ID, Opis)
select  b.factPolisa, isnull(c.DimDatum,109573), isnull(d.factPropis,0), isnull(a.I04_Platba_sum,0), a.I03_Platba_id, a.I03_Poznamka
from SSIS_Uplate a INNER JOIN factPolise b ON a.Poistka_ID=b.Polisa
	LEFT JOIN dimDatumi c ON a.I03_Pl_dat=c.Datum
	LEFT JOIN factPropisi d ON a.I02_Predpis_ID=d.Predpis_ID
WHERE d.Predpis_ID is NULL

GO
