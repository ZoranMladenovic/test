SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_factPoliseKUP]
as

declare @ug0 int=0
select @ug0=dimUgovarac from dimUgovaraci WHERE Partner_ID=0 and RC_ICO='' and PTT='' AND grad=''

UPDATE SSIS_PoliseKUP 
set DatumPoslednjeObnove=
	CASE WHEN DATEADD(YEAR, 1, DatumPocetak)> DatumKraj	THEN DatumPocetak
		WHEN DatumKraj < getdate() THEN DATEADD(YEAR,-1,DatumKraj)
		WHEN month(DatumPocetak)=2 and DAY(DatumPocetak)=29 AND DATEFROMPARTS(year(getdate()),month(DatumPocetak), 28) < GETDATE() THEN EOMONTH(DATEFROMPARTS(year(getdate()),month(DatumPocetak), 28))
		WHEN month(DatumPocetak)=2 and DAY(DatumPocetak)=29 AND DATEFROMPARTS(year(getdate()),month(DatumPocetak), 28) > GETDATE() THEN EOMONTH(DATEFROMPARTS(year(getdate()-1),month(DatumPocetak), 28))
		WHEN DATEFROMPARTS(year(getdate()),month(DatumPocetak), day(DatumPocetak)) < GETDATE() THEN DATEFROMPARTS(year(getdate()),month(DatumPocetak), DAY(DatumPocetak))
		else DATEFROMPARTS(year(getdate())-1,month(DatumPocetak), DAY(DatumPocetak))
	END

INSERT factPolise(Polisa, Verzija, Ponuda, VaziOd, VaziDo, StornoDat, dimRadnik, dimOJ, dimUgovarac, dimProdukt, dimStatus, dimDinamika, dimValuta, DatumPoslednjeObnove, 
	dimZakljucenje, Poreklo, DatumSklapanja, DatumDoObnove, Premija, PremijaPoRizicima, NerasknjizenaUplata)
SELECT isnull(BrojPolise,0), 0 verzija, a.BrojPonude, d1.DimDatum zakljucenje, ISNULL(d2.DimDatum,109573) istek, ISNULL(d3.DimDatum,109573) DatumRaskida, dr.dimRadnik, dr.dimOjPripada oj, 
	isnull(b.dimUgovarac,@ug0) ugovarac,
	dp.dimProdukt, ds.dimStatus, dpp.dimPeriodka, dv.dimValuta, 
	d5.DimDatum DatumPoslednjeObnove, CASE WHEN d5.DimDatum>d1.DimDatum then 3 else 1 END tipzakljucenja,
	2 poreklo,  ISNULL(d4.DimDatum, d1.DimDatum) DatumZakljucenja, d6.DimDatum, isnull(a.TotalPremija,0),isnull(a.TotalPremija,0),0
FROM SSIS_PoliseKUP a LEFT join SSIS_UgovaraciKUP b on a.BrojPonude=b.BrojPonude
    LEFT JOIN dimStatusi ds on a.StatusUgovora=ds.Status_ID
    left join dimValute dv ON case when a.Valuta='Evro' then 'EUR' when a.Valuta='Dolar' then 'USD' else 'Yum' end=dv.Valuta_ID
       INNER JOIN dimDatumi d1 ON a.DatumPocetak=d1.Datum
       LEFT JOIN dimDatumi d2 ON a.DatumKraj=d2.Datum
       LEFT JOIN dimDatumi d3 ON a.DatumRaskida=d3.Datum
       LEFT JOIN dimDatumi d4 ON a.DatumZakljucenja=d4.Datum
	   LEFT JOIN dimDatumi d5 ON a.DatumPoslednjeObnove=d5.Datum
	   LEFT JOIN dimDatumi d6 ON dateadd(year,1,a.DatumPoslednjeObnove)=d6.Datum and ds.StatusGrupa='živa' and DATEADD(YEAR, 1, DatumPocetak)<= DatumKraj	
       INNER JOIN dimRadnici dr ON a.SifPosrednika=dr.SifraZastupnika
	   inner join dimProdukti dp on a.SifVrsteOsiguranja=dp.Produkt_ID and dp.Poreklo=2
	   inner JOIN dimPeriodike dpp on dpp.Perioda_id=7
GO
