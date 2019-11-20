SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvRiziciPoPolisi] @factPolisa int
as

declare @broj smallint
select @broj=sum(broj) from (select 1 broj from dimObjekti WHERE factPolisa=@factPolisa GROUP by ObjekatJS) a

select a.factOsiguraniRizik, b.Riziko_ID, b.RizikoNaziv, a.Premija, a.OSuma, @Broj BrojObjekata,
	isnull('Reg.broj: ' + JSON_VALUE(c.ObjekatJS,'$.RegBroj'),'') +
	isnull(' Broj šasije: '+  JSON_VALUE(c.ObjekatJS,'$.BrojSasije'),'')+
	isnull(' Broj motora: '+ JSON_VALUE(c.ObjekatJS,'$.BrojMotora'),'')+
	isnull(' Marka: '+ JSON_VALUE(c.ObjekatJS,'$.Marka'),'')+
	isnull(' Model: '+ JSON_VALUE(c.ObjekatJS,'$.Model'),'') +
	isnull(' MB: '+ JSON_VALUE(c.ObjekatJS,'$.MB'),'') +
	isnull(' Naziv: '+ JSON_VALUE(c.ObjekatJS,'$.Naziv'),'') +
	isnull(JSON_VALUE(c.ObjekatJS,'$.Opis'),'') +
	isnull(' Adresa: '+ JSON_VALUE(c.ObjekatJS,'$.Ulica'),'') +
	isnull(' '+ JSON_VALUE(c.ObjekatJS,'$.Broj'),'') +
	isnull(', '+ JSON_VALUE(c.ObjekatJS,'$.Grad'),'') +
	isnull(', Pasoš: '+ JSON_VALUE(c.ObjekatJS,'$.Pasos'),'') 
	Objekat, c.TipObjekta, c.dimObjekat
from factOsiguraniRizici a INNER JOIN dimRizici b on a.dimRizik=b.dimRizik
	left JOIN dimObjekti c ON a.factOsiguraniRizik=c.factOsiguraniRizik
WHERE a.factPolisa=@factPolisa



GO
