SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[napuni_factOsiguraniRizici] 
as 
truncate table factOsiguraniRizici 
truncate table factOsiguraniRiziciDetalji
 
INSERT factOsiguraniRizici(factPolisa, dimRizik, Sadzba_no, TipTarife, TarifID, Premija, OSuma, OsiguraniObjekat) 
SELECT c.factPolisa, b.dimRizik, a.Sadzba_No, a.TipTarife, a.TarifID, isnull(a.premija,0), isnull(a.OSuma,0), a.OsiguraniObjekat 
from SSIS_OsiguraniRizici a inner JOIN dimRizici b on a.Riziko_ID=b.Riziko_ID 
	INNER JOIN factPolise c ON a.Poistka_ID=c.Polisa and a.Po_Verzia_No=c.Verzija 
	left JOIN dimPodProdukti dpp ON dpp.Specijal=1 and c.dimPodProdukt=dpp.dimPodProdukt 
where dpp.dimPodProdukt is NULL

-- LOB
UPDATE factOsiguraniRizici
SET LOB5=b.LOB_5
FROM factOsiguraniRizici a inner JOIN SSIS_SanjaLob b ON a.TarifID=b.Tarif_ID WHERE b.LOB_5>'0'

-- LOB za VHI
UPDATE factOsiguraniRizici
set LOB5=CASE WHEN c.TypVHI_ID=1 then '02010'
				WHEN c.TypVHI_ID=2 THEN '02020'
				WHEN c.TypVHI_ID=3 THEN '02030'
				WHEN c.TypVHI_ID IN (4,5) THEN '02040'
			END
from factOsiguraniRizici a inner JOIN factPolise b on a.factPolisa=b.factPolisa
	inner join SSIS_Polise c on b.Polisa=c.Poistka_ID and b.Verzija=c.Po_Verzia_No
WHERE LOB5 is NULL and c.TypVHI_ID is not NULL

-- LOB za nezgodu
UPDATE factOsiguraniRizici
set LOB5=d.LOB
from factOsiguraniRizici a inner JOIN factPolise b on a.factPolisa=b.factPolisa
	inner join SSIS_Polise c on b.Polisa=c.Poistka_ID and b.Verzija=c.Po_Verzia_No
	INNER JOIN SSIS_SifNezgodaLOB d ON c.ObjCinnost_ID=d.ObjCinnost_ID
WHERE LOB5 is NULL 

-- Detalji
INSERT factOsiguraniRiziciDetalji(factOsiguraniRizik, Naziv, Rizik, OsiguranaSuma, Stopa, JedinicaStope, Premija)
select a.factOsiguraniRizik, c.Nazov, c.Klasif_txt, c.PSuma, c.Sadzba, c.MJ_Sadzba, c.Poistne_vyp
from factOsiguraniRizici a inner JOIN factPolise b on a.factPolisa=b.factPolisa
	INNER JOIN SSIS_ObjektiDetalji c on b.Polisa=c.Poistka_ID and b.Verzija=c.Po_Verzia_No and a.Sadzba_no=c.Sadzba_No
GO
