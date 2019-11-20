SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvNeplaceneZK]
as
select a.Polisa ZK, a.Ponuda AOPolisa, o.OJ_ID, o.OjName,r.SifraZastupnika, r.Naziv,  d1.Datum DatumDospeca,  a.DospeloPorez Dospelo, a.PlacenoPorez Placeno, bo.Kod + ' ' + bo.Opis Naplata, u.RC_ICO MB, u.Naziv Ugovarac, u.PTT, u.Grad, u.Ulica, u.Broj, u.Drzava, u.Telefon, u.Mobilni, u.EMail, u.SMSEmailDozvoljen
from factPolise a inner join dimPodProdukti b on a.dimPodProdukt=b.dimPodProdukt
	inner join dimRadnici r on a.dimRadnik=r.dimRadnik
	inner join dimOj o on a.dimoj=o.dimOj
	inner JOIN dimDatumi d1 on a.VaziOd=d1.DimDatum
	inner join dimUgovaraci u on a.dimUgovarac=u.dimUgovarac
	left join dimBOKodovi bo on a.dimBOKod=bo.dimBOKod
where a.DospeloPorez-a.PlacenoPorez>0 and b.Produkt_Id=1010 and b.PodProdukt_Id=99
order by 1

GO
