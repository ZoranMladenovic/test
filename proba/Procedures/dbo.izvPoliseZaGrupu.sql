SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvPoliseZaGrupu] @Sifre varchar(8000), @DatOd date, @DatDo date
as
select  a.Polisa, a.Ponuda,c.RC_ICO MBUgovaraca, c.Naziv Ugovarac, d.Produkt_ID, d.ProduktName, e.PodProdukt_Id, e.PodProduktNaziv, b.SifraZastupnika, b.Naziv Zastupnik, d1.Datum DatumPocetka, 
	case when d2.Datum ='2199-12-13' then null else d2.Datum end DatumZavrsetka, CASE WHEN d3.Datum='2199-12-31' then null ELSE d3.Datum END DatumStorna, d4.Datum DatumSklapanja, 
	f.Status_ID, f.StatusNaziv, g.Valuta_ID, a.PremijaPoRizicima Premija, aa.Propisano Propisano, a.DospelaPremija+a.DospeloPorez Dospelo, a.PlacenoPremija+a.PlacenoPorez+a.NerasknjizenaUplata Placeno, a.BrojPrijavljenihSteta, a.IsplaceniIznosSteta, a.RezervisaniIznosSteta,
	case a.Poreklo when 1 then 'KOOP' when 2 then 'KUP' else '' end poreklo
from factPolise a INNER JOIN dimRadnici b on a.dimRadnik=b.dimRadnik
	INNER JOIN dimUgovaraci c on a.dimUgovarac=c.dimUgovarac
	inner JOIN dimProdukti d on a.dimProdukt=d.dimProdukt
	LEFT JOIN dimPodProdukti e on a.dimPodProdukt=e.dimPodProdukt
	inner JOIN dimDatumi d1 on a.VaziOd=d1.DimDatum
	inner JOIN dimDatumi d2 on a.VaziDo=d2.DimDatum
	LEFT JOIN dimDatumi d3 on a.StornoDat=d3.DimDatum
	inner JOIN dimDatumi d4 on a.DatumSklapanja=d4.DimDatum
	INNER JOIN dimStatusi f on a.dimStatus=f.dimStatus
	INNER JOIN dimValute g on a.dimValuta=g.dimValuta
	inner JOIN (select factPolisa, sum(Rata) Propisano from factPropisi WHERE Porez=0 GROUP by factPolisa) aa on aa.factPolisa=a.factPolisa 
	inner JOIN STRING_SPLIT(@Sifre,',') z on b.SifraZastupnika=z.value
WHERE d4.Datum BETWEEN @DatOd and @DatDo
order by a.poreklo, 1,2
GO
