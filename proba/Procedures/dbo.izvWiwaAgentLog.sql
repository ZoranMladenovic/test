SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[izvWiwaAgentLog] @DatOd date, @DatDo date
as
select a.CreatedAt, a.ClassType, a.InfoQuoteNumber,COALESCE(b.KopSifra, c.SifraZastupnika, a.UserId) KoopSifra,
	ISNULL(b.KorisnikNaziv, c.Naziv) Korisnik, ISNULL(b.NazivZastupnika,'WSO') Firma
from SSIS_WAInfo a LEFT JOIN SSIS_EksterniKorisnici b on a.UserId=b.Korisnik
	LEFT join dimRadnici c ON a.UserId=c.AvizoSifra
WHERE a.CreatedAt BETWEEN @DatOd and @DatDo
order by 1

GO
