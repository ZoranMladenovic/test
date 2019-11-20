SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvStetaDetalji] @factSteta int
as
SELECT 	a.factSteta, c.Polisa, a.SkodaID, a.BrojZahtevaArhiva,
	d1.Datum DatumNastanka, d2.Datum DatumPrijave, 
	r.Riziko_ID, r.RizikoNaziv,  cast(r1.Riziko_ID as VARCHAR(10)) + ' '+ r1.RizikoNaziv DelimicniRizik,
	a.StatusOpis, a.IsplaceniIznos, a.RezervisaniIznos, v1.Valuta ValutaRezervacije, a.Regres, a.OstvareniRegres,
	isnull('Reg.broj: ' + JSON_VALUE(do.ObjekatJS,'$.RegBroj'),'') +
	isnull(' Broj šasije: '+  JSON_VALUE(do.ObjekatJS,'$.BrojSasije'),'')+
	isnull(' Broj motora: '+ JSON_VALUE(do.ObjekatJS,'$.BrojMotora'),'')+
	isnull(' Marka: '+ JSON_VALUE(do.ObjekatJS,'$.Marka'),'')+
	isnull(' Model: '+ JSON_VALUE(do.ObjekatJS,'$.Model'),'') +
	isnull(' MB: '+ JSON_VALUE(do.ObjekatJS,'$.MB'),'') +
	isnull(' Naziv: '+ JSON_VALUE(do.ObjekatJS,'$.Naziv'),'') +
	isnull(JSON_VALUE(do.ObjekatJS,'$.Opis'),'') +
	isnull(' Adresa: '+ JSON_VALUE(do.ObjekatJS,'$.Ulica'),'') +
	isnull(' '+ JSON_VALUE(do.ObjekatJS,'$.Broj'),'') +
	isnull(', '+ JSON_VALUE(do.ObjekatJS,'$.Grad'),'') +
	isnull(', Pasoš: '+ JSON_VALUE(do.ObjekatJS,'$.Pasos'),'') 
	Objekat,
	--do.Int1, do.int2, do.int3, do.char1, do.char2, do.char3, do.char4, do.char5, 
	case do.TipObjekta
		WHEN 1 THEN 'Vozilo'
		when 2 then 'Osoba'
		when 3 then 'Objekat'
	else '' end TipObjekta,
	c.PremijaPoRizicima, c.DospelaPremija, c.DospeloPorez, c.PlacenoPremija, c.PlacenoPorez, c.NerasknjizenaUplata,
	a.Osteceni, a.UzrokID, a.UzrokOpis, a.OcekivaniRegres, a.StatusRegresaID, a.StatusRegresa,
	d3.Datum PolisaVaziOd, d4.Datum PolisaVaziDo, 
	case 
		when d5.DimDatum=109573 then NULL 
		when c.StornoDat=c.VaziDo then null 
	else  d5.Datum end DatumStorna, dp.ProduktName, a.factPolisa
FROM factStete a INNER JOIN factPolise c ON a.factPolisa = c.factPolisa
	INNER JOIN dimDatumi d1 ON a.DatumNastanka = d1.DimDatum
	INNER JOIN dimDatumi d2 ON a.DatumPrijave = d2.DimDatum
	INNER JOIN dimDatumi d3 ON c.VaziOd = d3.DimDatum
	INNER JOIN dimDatumi d4 ON c.VaziDo = d4.DimDatum
	INNER JOIN dimDatumi d5 ON c.StornoDat = d5.DimDatum
	INNER JOIN dimRizici r ON a.dimRizik = r.dimRizik
	LEFT JOIN dimRizici r1 ON a.dimDelimicniRizik = r1.dimRizik
	INNER JOIN dimValute v1 ON a.dimValuta = v1.dimValuta
	inner join dimProdukti dp on c.dimProdukt=dp.dimProdukt
	LEFT JOIN dimObjekti do on a.dimObjekat=do.dimObjekat
WHERE a.factSteta=@factSteta
GO
