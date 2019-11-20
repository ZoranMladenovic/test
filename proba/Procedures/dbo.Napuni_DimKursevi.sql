SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create procedure Napuni_DimKursevi
as
TRUNCATE table dimkursevi

INSERT dimKursevi(dimValuta, KursOd, KursDo, Kurs)
select b.dimValuta, d1.DimDatum KursOd, d2.DimDatum KursDo, a.Kurz Kurs
from SSIS_NOKurzy a INNER JOIN dimValute b on a.Mena_do_ID=b.Valuta_ID
	INNER JOIN dimDatumi d1 ON a.UcinOd_dat=d1.Datum
	INNER JOIN dimDatumi d2 ON a.datDo=d2.Datum
WHERE a.Mena_do_ID <>'YUM'


declare @val int
SELECT @val=dimValuta from dimValute WHERE Valuta_ID ='YUM'

INSERT dimKursevi(dimValuta, KursOd, KursDo, Kurs)
select @val,min(DimDatum), MAX(DimDatum),1 from dimDatumi



GO
