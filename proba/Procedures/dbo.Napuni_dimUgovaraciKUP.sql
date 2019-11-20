SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[Napuni_dimUgovaraciKUP] 
as 
UPDATE SSIS_UgovaraciKUP set mb=id WHERE MB='' 
UPDATE SSIS_UgovaraciKUP set mb=id WHERE MB is NULL 
 
UPDATE a  
SET a.dimUgovarac=b.dimUgovarac 
FROM SSIS_UgovaraciKUP a INNER JOIN dimUgovaraci b on left(rtrim(ltrim(replace(replace(replace(replace(a.MB,'br. pg',''),'bpg',''),'br pg',''),'brpg',''))),20)=b.RC_ICO 
WHERE b.Partner_ID>0 
 
INSERT dimUgovaraci(Partner_ID, Naziv, RC_ICO, Drzava, PTT, Grad, Ulica, Broj, FizickoLice, Leasing, Mobilni, EMail, SMSEmailDozvoljen, Telefon, Fax) 
select 0 partnerid, Ugovarac,   
	left(rtrim(ltrim(replace(replace(replace(replace(MB,'br. pg',''),'bpg',''),'br pg',''),'brpg',''))),20) MB, 
	'Srbija', PTT, Mesto, Ulica, left(Broj,20),  
	case when PravnoFizicko=1 then 1 else 0 END,  
	0 Leasing, left(Mob,20), eMail, 0, TelKuca,Posao 
from SSIS_UgovaraciKUP a INNER JOIN 
(select min(id) partnerid from SSIS_UgovaraciKUP WHERE dimUgovarac = 0 GROUP BY left(rtrim(ltrim(replace(replace(replace(replace(MB,'br. pg',''),'bpg',''),'br pg',''),'brpg',''))),20) ) b 
on a.id=b.partnerid 
WHERE dimUgovarac = 0 
 
UPDATE a  
SET a.dimUgovarac=b.dimUgovarac 
FROM SSIS_UgovaraciKUP a INNER JOIN dimUgovaraci b on left(rtrim(ltrim(replace(replace(replace(replace(a.MB,'br. pg',''),'bpg',''),'br pg',''),'brpg',''))),20)=b.RC_ICO 
WHERE a.dimUgovarac=0
GO
