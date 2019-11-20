SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_dimObjekti] 
as 
 
 -- unisteni podaci o modelu se rekonstruisu na osnovu kiwe
UPDATE SSIS_Vozila
SET Model=b.Typ_txt
from SSIS_Vozila a inner join SSIS_KiwaVozila b on a.poistka_id=b.Policy_Num
WHERE Model='MTPL' 

UPDATE SSIS_Vozila
SET Model=wv.TipVozila, Marka=wv.MarkaVozila
from SSIS_Vozila a INNER JOIN factPolise b ON a.poistka_id=b.Polisa and a.Po_Verzia_No=b.Verzija 
		INNER JOIN SSIS_WiwaVozila wv ON b.Ponuda=wv.RegistarskiBrojPolise
WHERE Model='MTPL' 



CREATE TABLE #dimObjekti(
	[dimObjekat] [int] IDENTITY(1,1) NOT NULL,
	[factOsiguraniRizik] [int] NOT NULL,
	[factPolisa] [int] NOT NULL,
	[ID] [bigint] NULL,
	[TipObjekta] [smallint] NOT NULL,
	[ObjekatJS] [varchar](5000) NULL
) ON [PRIMARY]



INSERT #dimObjekti(factOsiguraniRizik, factPolisa, ID, TipObjekta, ObjekatJS) 
SELECT  c.factOsiguraniRizik, b.factPolisa, a.Spe_ID, 1,
	(select RegBroj, BrojSasije, motor_id as BrojMotora, Marka,  Model, Broj_Putnika as BrojPutnika, Broj_Sedista as BrojSedista, Broj_Mjesta as BrojMesta, Gorivo, Farba, Zapremina, Snaga, Kategorija, a.Nosivost, a.GodinProizvodnje, a.Namena 
	from SSIS_Vozila 
	WHERE Spe_ID=a.Spe_ID AND poistka_id=a.poistka_id 
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) 
FROM SSIS_Vozila a INNER JOIN factPolise b ON a.poistka_id=b.Polisa and a.Po_Verzia_No=b.Verzija 
	INNER JOIN factOsiguraniRizici c ON b.factPolisa=c.factPolisa and a.Sadzba_No=c.Sadzba_no 
	left JOIN dimPodProdukti dpp ON dpp.Specijal=1 and b.dimPodProdukt=dpp.dimPodProdukt 
where dpp.dimPodProdukt is NULL 
 
 
--INSERT dimObjekti(factOsiguraniRizik, factPolisa, id, TipObjekta, Int1, int2, int3, char1, char2, char3, char4, char5, ObjekatJS) 
INSERT #dimObjekti(factOsiguraniRizik, factPolisa, id, TipObjekta, ObjekatJS) 
SELECT c.factOsiguraniRizik, b.factPolisa, a.Partner_ID, 2,-- CASE WHEN isnumeric(a.PSC)=1 then a.PSC else 0 end, 0,0, isnull(a.RC_ICO,''), isnull(a.naziv,''), isnull(a.ulica,''), isnull(a.PSC_txt,''), isnull(a.Stat_txt,''), 
	(select  RC_ICO MB, Naziv, Ulica, PSC PTTBroj, PSC_txt Grad, Stat_txt Drzava, Partner_ID PartnerID, Telefon, Pasos, case when Pol=-1 then 'M' else 'Ž' end pol, DatumRodjenja 
	from SSIS_OOsobe  
	WHERE Partner_ID=a.Partner_ID AND poistka_id=a.poistka_id 
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) 
	--dbo.fn_OsobaJason(partner_id,a.poistka_id) 
from SSIS_OOsobe a INNER JOIN factPolise b ON a.poistka_id=b.Polisa and a.Po_Verzia_No=b.Verzija 
	INNER JOIN factOsiguraniRizici c ON b.factPolisa=c.factPolisa 
--WHERE c.TipTarife=1 
 
--INSERT dimObjekti(factOsiguraniRizik, factPolisa, id, TipObjekta, Int1, int2, int3, char1, char2, char3, char4, char5, ObjekatJS) 
INSERT #dimObjekti(factOsiguraniRizik, factPolisa, id, TipObjekta, ObjekatJS) 
SELECT c.factOsiguraniRizik, b.factPolisa, a.Zakl_Objekt_NoM, 3,-- 0,0,0, isnull(a.Objekt_txt,''), isnull(a.PTTBroj,''), isnull(a.Grad,''), isnull(a.Drzava,''), isnull(a.Ulica,'')+' '+isnull(a.Broj,''), 
	(select  Objekt_txt Opis, a.Ulica, a.Broj, a.PTTBroj, a.Grad, a.Drzava 
	from SSIS_Objekti  
	WHERE Poistka_ID=a.Poistka_ID AND Sadzba_No=a.Sadzba_No and Zakl_Objekt_NoM=a.Zakl_Objekt_NoM 
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) 
	--dbo.fn_ObjekatJason(a.Poistka_ID, a.Sadzba_No, a.Zakl_Objekt_NoM) 
from SSIS_Objekti a INNER JOIN factPolise b ON a.poistka_id=b.Polisa and a.Po_Verzia_No=b.Verzija 
	INNER JOIN factOsiguraniRizici c ON b.factPolisa=c.factPolisa and a.Sadzba_no=c.Sadzba_no 
--where c.TipTarife <>3 
 
-- brisanje duplih (imovina i vozilo kod osiguranja transporta) 
DELETE #dimObjekti WHERE dimObjekat in (select b.dimObjekat from #dimObjekti a INNER JOIN #dimObjekti b on a.dimObjekat<>b.dimObjekat and a.factOsiguraniRizik=b.factOsiguraniRizik and a.TipObjekta=1 and b.TipObjekta=3) 
 
INSERT #dimObjekti(factOsiguraniRizik, factPolisa, id, TipObjekta, ObjekatJS) 
select c.factOsiguraniRizik, b.factPolisa, a.ClenSkupVHI_ID, 4, 
(select  RC MB, Naziv, Partner_ID PartnerID, case when a.Pohlavie=-1 then 'M' else 'Ž' end pol, Datum_Narodenia DatumRodjenja, VstVek Starost, Ucin_od VaziOd, Ucin_do VaziDo 
	from SSIS_Osobe_VHI  
	WHERE ClenSkupVHI_ID=a.ClenSkupVHI_ID AND poistka_id=a.poistka_id and Sadzba_No=a.Sadzba_No 
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) 
from SSIS_Osobe_VHI a INNER JOIN factPolise b ON a.poistka_id=b.Polisa and a.Po_Verzia_No=b.Verzija 
	INNER JOIN factOsiguraniRizici c ON b.factPolisa=c.factPolisa and a.Sadzba_no=c.Sadzba_no 
	LEFT JOIN (select a.dimprodukt from dimprodukti a  INNER JOIN dimProdukti b on a.Nadredjena=b.dimProdukt where b.Produkt_ID=-5) dp on b.dimProdukt=dp.dimProdukt
WHERE dp.dimProdukt is NULL

 
INSERT #dimObjekti(factOsiguraniRizik, factPolisa, id, TipObjekta, ObjekatJS) 
select c.factOsiguraniRizik, b.factPolisa, a.Poradie_No, 5, 
(select  RC MB, Naziv, a.Dat_nar DatumRodjenja, a.BrojOsoba 
	from SSIS_ONezgoda  
	WHERE Poistka_ID=a.Poistka_ID AND Sadzba_No=a.Sadzba_No and Zakl_Objekt_NoM=a.Zakl_Objekt_NoM and Poradie_No=a.Poradie_No 
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) 
from SSIS_ONezgoda a INNER JOIN factPolise b ON a.poistka_id=b.Polisa and a.Po_Verzia_No=b.Verzija 
	INNER JOIN factOsiguraniRizici c ON b.factPolisa=c.factPolisa and a.Sadzba_no=c.Sadzba_no 
	LEFT JOIN (select a.dimprodukt from dimprodukti a  INNER JOIN dimProdukti b on a.Nadredjena=b.dimProdukt where b.Produkt_ID=-5) dp on b.dimProdukt=dp.dimProdukt
WHERE dp.dimProdukt is NULL

 
INSERT #dimObjekti(factOsiguraniRizik, factPolisa, id, TipObjekta, ObjekatJS) 
select c.factOsiguraniRizik, b.factPolisa, a.Objekt_NoM, 6, 
(select  a.RC_ICO MB, Naziv,  Ulica, PSC PTTBroj, PSC_txt Grad, Stat_txt Drzava, Partner_ID PartnerID, tel_no Telefon,  case when a.Pohlavie=-1 then 'M' else 'Ž' end pol 
	from SSIS_IOsobe  
	WHERE Poistka_ID=a.Poistka_ID  and Po_Verzia_No=a.Po_Verzia_No AND Sadzba_No=a.Sadzba_No and Objekt_NoM=a.Objekt_NoM  
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) 
from SSIS_IOsobe a INNER JOIN factPolise b ON a.poistka_id=b.Polisa and a.Po_Verzia_No=b.Verzija 
	INNER JOIN factOsiguraniRizici c ON b.factPolisa=c.factPolisa and a.Sadzba_no=c.Sadzba_no


 -- Brodovi
INSERT #dimObjekti(factOsiguraniRizik, factPolisa, id, TipObjekta, ObjekatJS) 
select c.factOsiguraniRizik, b.factPolisa, 1, 7, 
(select  Naziv,Drzava,DrzavaNaziv,Reg_No,Kapacitet
	from SSIS_Brodovi	
	WHERE Poistka_ID=a.Poistka_ID  and Po_Verzia_No=a.Po_Verzia_No AND Sadzba_No=a.Sadzba_No 
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) 
from SSIS_Brodovi a INNER JOIN factPolise b ON a.poistka_id=b.Polisa and a.Po_Verzia_No=b.Verzija 
	INNER JOIN factOsiguraniRizici c ON b.factPolisa=c.factPolisa and a.Sadzba_no=c.Sadzba_no

truncate table dimObjekti 

INSERT dimObjekti(factOsiguraniRizik,factPolisa,ID,TipObjekta,ObjekatJS)
select factOsiguraniRizik,factPolisa,ID,TipObjekta,ObjekatJS from #dimObjekti


DROP TABLE #dimObjekti
GO
