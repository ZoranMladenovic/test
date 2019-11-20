SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--USE [WiWaDW] 
--GO 
--/****** Object:  StoredProcedure [dbo].[Napuni_factStete]    Script Date: 23.05.2017 12:18:22 ******/ 
--SET ANSI_NULLS ON 
--GO 
--SET QUOTED_IDENTIFIER ON 
--GO 
CREATE procedure [dbo].[Napuni_factStete] 
as 
truncate table factStete 
 
Insert factStete( dimObjekti.factPolisa, dimRizik, dimDelimicniRizik, DatumNastanka, DatumPrijave, DatumPoslednjeIsplate, BrojZahtevaArhiva, StatusStete, StatusOpis, dimValuta, RezervisaniIznos, IsplaceniIznos,  
	dimObjekat, SkodaID, Osteceni, UzrokID, UzrokOpis, Regres, OstvareniRegres, OcekivaniRegres, StatusRegresaID, StatusRegresa) 
select b.factPolisa, c.dimRizik, c1.dimRizik, d1.DimDatum DatumNastanka, d2.dimDatum DatumPrijave, isnull(d3.dimDatum,1) DatumPoslednjeIsplate, a.BrojZahtevaArhiva, a.StatusStete, a.StatusOpis, v.dimValuta, a.Rezerva_sum, a.IsplaceniIznos,  
	COALESCE(do.dimObjekat,do1.dimObjekat, 0) dimObjekat,  
	--COALESCE(do.dimObjekat, 0) dimObjekat,  
	a.Skoda_ID, a.Osteceni, a.UzrokID, a.UzrokOpis, a.Regres, a.OstvareniRegres, a.OcekivaniRegres, a.StatusRegresaID, a.StatusRegresa 
from SSIS_Stete a inner join factPolise b on a.Poistka_ID=b.Polisa 
	INNER JOIN dimRizici c on a.Riziko_ID=c.Riziko_ID 
	INNER JOIN dimRizici c1 on a.DelimicniRizik=c1.Riziko_ID 
	INNER join dimDatumi d1 on a.DatumNastanka=d1.Datum 
	INNER join dimDatumi d2 on a.DatumPrijave=d2.Datum 
	LEFT join dimDatumi d3 on a.DatumPoslednjeIsplate=d3.Datum 
	INNER JOIN dimValute v on a.Mena_ID=v.Valuta_ID 
	left join dimObjekti do on b.factPolisa=do.factPolisa and a.IDObjekta=do.ID and do.TipObjekta in (1,2) 
	LEFT JOIN factOsiguraniRizici fo ON b.factPolisa=fo.factPolisa and a.Sadzba_No=fo.Sadzba_no 
	left join dimObjekti do1 on fo.factPolisa=do1.factPolisa and do1.factOsiguraniRizik=fo.factOsiguraniRizik and do1.TipObjekta=3 
	left JOIN dimPodProdukti dpp ON dpp.Specijal=1 and b.dimPodProdukt=dpp.dimPodProdukt 
where dpp.dimPodProdukt is NULL 
	 
GO
