SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_dimVinkulanti] 
as  
truncate table dimVinkulanti 
 
INSERT dimVinkulanti(factPolisa,RB,Partner_ID,Naziv,RC_ICO,Drzava,PTT,Grad,Ulica,Broj,FizickoLice,Leasing,Mobilni,EMail,SMSEmailDozvoljen,Telefon,Fax) 
select b.factPolisa,ROW_NUMBER() OVER(PARTITION BY Poistka_ID ORDER BY Partner_ID ASC), a.Partner_ID, a.naziv, a.RC_ICO, a.Stat_txt, a.PSC, a.PSC_txt, a.Ulica, a.Dom_No, a.Pa_druh, a.Je_Leasing, a.Mobil, a.Email, a.Is_Mobile_SMS_Enabled, a.Tel_No, a.Fax_No 
from SSIS_Vinkulanti a inner join factPolise b on a.Poistka_ID=b.Polisa 
	left JOIN dimPodProdukti dpp ON dpp.Specijal=1 and b.dimPodProdukt=dpp.dimPodProdukt 
where dpp.dimPodProdukt is NULL 
 
GO
