SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvMaticniPodaci] @polise varchar(8000)
as

create table #t
(id int identity,
Polisa bigint)



insert #t
SELECT value from	 STRING_SPLIT(@polise,',')

select a.Polisa, a.Ponuda,c.Naziv, c.Ulica+' '+ c.Broj Adresa, c.Grad+', '+ c.PTT Grad, c.Drzava, c.Telefon, c.RC_ICO JMBG, d.SifraZastupnika, d.Naziv Posrednik
from factPolise a INNER JOIN #t b ON a.Polisa=b.Polisa
	inner JOIN dimUgovaraci c ON a.dimUgovarac=c.dimUgovarac
	INNER JOIN dimRadnici d ON a.dimRadnik=d.dimRadnik
WHERE a.Polisa>0
order BY b.id
GO
