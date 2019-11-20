SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[DugPoAOPosrednikuWIWA]
(@SifraPosrednika bigint)
as
SELECT r.SifraZastupnika as Obchodnik_ID,sum(isnull(dug.Saldo,0)) as Dug_po_posredniku
from factPolise p 
	join dimRadnici r  on p.dimRadnik=r.dimRadnik
	join dimProdukti pr on p.dimProdukt=pr.dimProdukt
	join dimDatumi dat on p.DatumSklapanja=dat.DimDatum
	left join (Select factPolisa,Saldo=sum(Rata)-sum(Placeno)
				FROM factPropisi i02
						join dimDatumi dat on i02.DatDospeca=dat.DimDatum
				where convert(date,dat.Datum)<=dateadd(day,-16,convert(date,getdate()))
				GROUP by factPolisa
				) dug 
	on p.factPolisa=dug.factPolisa
	join dimStatusi st on p.dimStatus=st.dimStatus
where r.SifraZastupnika=@SifraPosrednika AND 
pr.Produkt_ID=1010 and dat.Datum>='20160101' and st.Status_ID!='S22'
GROUP by r.SifraZastupnika




GO
GRANT EXECUTE
	ON [dbo].[DugPoAOPosrednikuWIWA]
	TO [WSO\Programeri Mladji]
GO
