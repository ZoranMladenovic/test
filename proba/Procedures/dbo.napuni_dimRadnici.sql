SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[napuni_dimRadnici]
as
TRUNCATE table dimRadnici
truncate table dimEKorisnici

/*
UPDATE a
set aktivan=1
from SSIS_RadnikKanal a inner JOIN
(select Partner_ID, max(Do_dat) do_dat from SSIS_RadnikKanal GROUP BY Partner_ID) b on a.Partner_ID=b.Partner_ID
*/

declare @NNOj int,  @limit decimal(18,2)
SELECT @NNOj=dimOj  FROM dimOj WHERE OJ_ID='NN'
-- Default AO Limit
select @limit=Limit from SSIS_WAOZastupnici where SifraZastupnika is NULL

INSERT dimRadnici(naziv, NazivRM, MB, SifraZastupnika, AvizoSifra, dimOjPripada, AOLimit)
SELECT ime + ' ' + a.PREZIME, a.NAZIV_RM, a.MATICNIBROJ, a.SIFRA_ZASTUPNIKA, a.AVIZOSIFRA, ISNULL(b.dimOj, @nnoj), @limit
FROM ssis_radnici a LEFT JOIN dimOj b on a.oj_id=b.OJ_ID


INSERT dimRadnici(SifraZastupnika,dimOjPripada,naziv,mb, AOLimit)
select a.Partner_ID,ISNULL(d.dimOj, @nnoj), a.naziv, a.MB, @limit
from SSIS_Radnici2 a LEFT JOIN SSIS_Radnici b on a.Partner_ID=b.SIFRA_ZASTUPNIKA 
	 LEFT JOIN dimOj d on a.Oj_ujed_ID=d.OJ_ID
WHERE b.SIFRA_ZASTUPNIKA is NULL

--  Update AO limita za izabrane usere
UPDATE a set AOLimit=b.limit FROM dimRadnici a inner join SSIS_WAOZastupnici b on a.SifraZastupnika=b.SifraZastupnika

UPDATE d 
SET dimOjGleda=e.dimOj
FROM SSIS_EKOJ a CROSS APPLY dbo.StringToTable(',',uvid) 
	INNER JOIN SSIS_EKKorisnici c ON val=c.IDKorisnik
	INNER JOIN dimRadnici d ON c.AvizoSifra=d.AvizoSifra
	INNER JOIN dimOj e ON a.IDOrgJed=e.OJ_ID
/*
UPDATE b 
SET putanja=a.Putanja, PutanjaGleda=a.Putanja, nivo=a.nivo
from SSIS_HRadnici a INNER JOIN dimRadnici b ON a.AvizoSifra=b.AvizoSifra
*/
UPDATE b 
SET putanja=a.Putanja, PutanjaGleda=a.Putanja, nivo=a.nivo
from SSIS_HRadnici a INNER JOIN dimRadnici b ON a.Sifra_Zaposlenog=b.SifraZastupnika

-------------------------------------------------------------------------------------------------
-- Nalazenje putanje za radnike koji ne rade odavno i za koje nemamo podatke u HR

DECLARE @dr int, @mOrgNode hierarchyid, @lc hierarchyid  

update a
SET a.AVIZO_SIFRA_NADREDJENOG_OJ=b.AVIZO_SIFRA_NADREDJENOG_OJ
from SSIS_OJNadredjeni a INNER JOIN SSIS_OJNadredjeni_Forsiraj b on a.OJ_KOOP=b.OJ_KOOP

INSERT SSIS_OJNadredjeni(OJ_KOOP, AVIZO_SIFRA_NADREDJENOG_OJ)
select a.OJ_KOOP, a.AVIZO_SIFRA_NADREDJENOG_OJ
from SSIS_OJNadredjeni_Forsiraj a LEFT JOIN SSIS_OJNadredjeni b on a.OJ_KOOP=b.OJ_KOOP
where b.OJ_KOOP is NULL

DECLARE dR_cursor CURSOR FOR  
select dimRadnik from dimRadnici WHERE Putanja is NULL


OPEN dR_cursor   
FETCH NEXT FROM dR_cursor INTO @dr   

WHILE @@FETCH_STATUS = 0   
BEGIN   

	select @lc=NULL, @mOrgNode=NULL

	select @mOrgNode=a1.Putanja
	from dimRadnici a  INNER JOIN dimOj o on a.dimOjPripada=o.dimOj
		inner JOIN SSIS_OJNadredjeni b on o.OJ_ID=b.OJ_KOOP
		LEFT JOIN dimRadnici a1 on b.AVIZO_SIFRA_NADREDJENOG_OJ=a1.AvizoSifra
	WHERE a.Putanja is NULL and a.dimRadnik=@dr

	SELECT @lc = max(Putanja)   
	FROM dimRadnici
	WHERE Putanja.GetAncestor(1) =@mOrgNode 
         
    UPDATE dimRadnici SET Putanja= @mOrgNode.GetDescendant(@lc, NULL) WHERE Putanja is NULL AND dimRadnik=@dr

    FETCH NEXT FROM dR_cursor INTO @dr   
END   

CLOSE dR_cursor   
DEALLOCATE dR_cursor

UPDATE dimRadnici SET PutanjaGleda=Putanja WHERE PutanjaGleda is NULL

-----------------------------------------------------------------------------

-- ovo prebaciti na neku pomoćnu tabelu preko koje će se mapirati jedan u drugog usera
update a
SET PutanjaGleda=b.Putanja,
	dimOjGleda=b.dimOjGleda
from dimRadnici a inner JOIN dimRadnici b on b.nivo=0
WHERE a.SifraZastupnika in (502219)

update a
SET PutanjaGleda=b.Putanja,
	dimOjGleda=b.dimOjGleda
from dimRadnici a inner JOIN dimRadnici b on b.SifraZastupnika=1099937
WHERE a.SifraZastupnika in (855814,1252888)


-- Jelena Mraković, Marko Stančić kao Zoran Blagojević
update a
SET PutanjaGleda=b.Putanja,
	dimOjGleda=b.dimOjGleda
from dimRadnici a inner JOIN dimRadnici b on b.SifraZastupnika=500091
WHERE a.SifraZastupnika in (1257936,100057, 1320888)



-- Eksterni korisnici

INSERT dimEKorisnici(Korisnik,KorisnikNaziv,KopSifra,NazivZastupnika,TipLogovanja,TipEksternogZastupnika,TipNaziv,SifraFilijaleBanke,NazivFilijaleBanke,Region,SifraBankara,dimRadnik,dimOj)
select   a.Korisnik, a.KorisnikNaziv, a.KopSifra, a.NazivZastupnika, a.TipLogovanja, a.TipEksternogZastupnika, a.TipNaziv, a.SifraFilijaleBanke, a.NazivFilijaleBanke, a.Region, a.SifraBankara, b.dimRadnik, c.dimOj
from SSIS_EksterniKorisnici a LEFT JOIN dimRadnici b on a.KopSifra=b.SifraZastupnika
	LEFT join dimOj c on a.oj=c.OJ_ID
WHERE a.KopSifra>0
GO
