SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvZastupnici] @SifraZastupnika bigint=null, @Naziv varchar(100)=null
as
declare @NazivN varchar(100)
select @NazivN='%'+isnull(@Naziv,'')+'%'

select  dimRadnik, SifraZastupnika, AvizoSifra, a.Naziv Zastipnik, NazivRM, b.OJ_ID, b.OjName 
from dimRadnici a LEFT JOIN dimOj b on a.dimOjPripada=b.dimOj
where SifraZastupnika=isnull(@SifraZastupnika,SifraZastupnika) and Naziv like @NazivN
GO
