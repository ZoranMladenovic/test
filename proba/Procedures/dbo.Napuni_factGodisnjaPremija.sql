SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Napuni_factGodisnjaPremija]
as


CREATE TABLE #factGodisnjaPremija(
	[factPolisa] [int] NOT NULL,
	[pocetaki] [int] NOT NULL,
	[kraji] [int] NOT NULL,
	[dimRizik] [int] NOT NULL,
	[dimTarifa] [int] NOT NULL,
	[iznos] [decimal](18, 2) NOT NULL,
	[VaziOd] [int] NULL,
	[VaziDo] [int] NULL,
	[IznosKorigovan] [decimal](18, 2) NULL
) ON [PRIMARY]


create clustered index IX_TfactGodisnjaPremija on #factGodisnjaPremija(factPolisa)

DECLARE @Jedn int
select @Jedn=dimPeriodka from dimPeriodike where Perioda_id=0


update SSIS_Polise SET GodDat_Korigovani=DATEADD(YEAR,20,GodDat_Korigovani), GodDat=DATEADD(YEAR,20,GodDat)

-- Insert za polise koje nisu jednokratne (svaka godina po jedan slog)
select d.factPolisa,  CASE WHEN  dateadd(YEAR,-b.broj, a.GodDat) <a.Zac_Dat THEN a.Zac_Dat ELSE dateadd(YEAR,-b.broj, a.GodDat) end pocetak0,  
	CASE WHEN  dateadd(YEAR,-b.broj, a.GodDat_Korigovani) <a.ZacDat_Korigovani THEN a.ZacDat_Korigovani ELSE dateadd(YEAR,-b.broj, a.GodDat_Korigovani) end pocetak,  
	case when dateadd(YEAR,-b.broj+1, a.GodDat) > a.KrajDat THEN a.KrajDat else dateadd(day,-1,dateadd(YEAR,-b.broj+1, a.GodDat)) END kraj0,
	case when dateadd(YEAR,-b.broj+1, a.GodDat_Korigovani) > a.KrajDat THEN a.KrajDat else dateadd(day,-1,dateadd(YEAR,-b.broj+1, a.GodDat_Korigovani)) END kraj,
	0 as pocetakI, 0 as KrajI,	0 as pocetakI0, 0 as KrajI0 --, d.dimDinamika, d.VaziOd, case WHEN d.StornoDat<d.VaziDo THEN d.StornoDat else d.VaziDo end VaziDo
INTO #t
from SSIS_Polise a inner JOIN (select top 100 
		ROW_NUMBER() OVER(ORDER BY object_id) broj
		from sys.columns) b on dateadd(YEAR,-b.broj, a.GodDat_Korigovani) BETWEEN a.ZacDat_Korigovani and a.KrajDat --dateadd(day,-1,a.KrajDat)
	inner JOIN SSIS_Produkti c on a.Produkt_ID=c.Produkt_Id and c.Nadredjena <>5
	INNER JOIN factPolise d ON a.Poistka_ID=d.Polisa
	LEFT JOIN dimSifarnici s on	a.Produkt_ID=s.Sifra and s.TipSifarnika=8
WHERE d.dimDinamika<>@Jedn AND s.Sifra is NULL

-- Insert za jednokratne polise (jedan slog za ceo period)
INSERT #t
select d.factPolisa, a.Zac_Dat pocetak0, a.ZacDat_Korigovani pocetak, a.KrajDat kraj0, a.KrajDat kraj,	0 as pocetakI, 0 as KrajI,	0 as pocetakI0, 0 as KrajI0
from SSIS_Polise a 
	inner JOIN SSIS_Produkti c on a.Produkt_ID=c.Produkt_Id and c.Nadredjena <>5
	INNER JOIN factPolise d ON a.Poistka_ID=d.Polisa
	LEFT JOIN dimSifarnici s on	a.Produkt_ID=s.Sifra and s.TipSifarnika=8
WHERE d.dimDinamika=@Jedn  AND s.Sifra is NULL

UPDATE a
SET pocetaki=d1.DimDatum, kraji=d2.DimDatum, pocetaki0=d3.DimDatum, kraji0=d4.DimDatum
from #t a INNER JOIN dimDatumi d1 ON a.pocetak=d1.Datum
	INNER JOIN dimDatumi d2 on a.kraj=d2.Datum
	INNER JOIN dimDatumi d3 ON a.pocetak0=d3.Datum
	INNER JOIN dimDatumi d4 on a.kraj0=d4.Datum

UPDATE #t set kraji=kraji0 WHERE kraji0-kraji=1

INSERT #factGodisnjaPremija(factPolisa,pocetaki,kraji,dimRizik,dimTarifa,iznos, VaziOd, VaziDo, IznosKorigovan)
select c.factPolisa, a.pocetaki, a.kraji, c.dimRizik, c.dimTarifa, sum(c.Riziko_sum) iznos,0,0,0
from #t a INNER JOIN factPropisi b on a.factpolisa=b.factPolisa and b.DatOd BETWEEN a.pocetaki0 and kraji0
	INNER JOIN factPropisiPodeljeno c ON b.factPropis=c.factPropis 
WHERE b.Porez=0
GROUP BY c.factPolisa, a.pocetaki, a.kraji, c.dimRizik, c.dimTarifa


UPDATE a 
SET VaziOd=b.VaziOd, VaziDo=b.VaziDo, IznosKorigovan=case WHEN Perioda_id=0 then b.IznosKorigovan ELSE a.iznos END
from #factGodisnjaPremija a inner JOIN
	(select b.factPolisa, c.dimRizik, c.dimTarifa, b.VaziOd, b.VaziDo, p.Perioda_id, sum(c.Riziko_sum) IznosKorigovan 
	FROM  factPolise b 	inner JOIN factPropisiPodeljeno c ON b.factPolisa=c.factPolisa
		INNER JOIN dimPeriodike p on b.dimDinamika=p.dimPeriodka
		inner JOIN factPropisi p1 ON c.factPropis=p1.factPropis
	WHERE p1.Porez=0
	GROUP BY b.factPolisa, c.dimRizik, c.dimTarifa, b.VaziOd, b.VaziDo, p.Perioda_id ) b on a.factPolisa=b.factPolisa and a.dimRizik=b.dimRizik and a.dimTarifa=b.dimTarifa

-- Turističke agencije
-- Generalna na 0

update c SET IznosKorigovan=0
from SSIS_WT_GeneralnePolise a inner join factPolise b on a.Ponuda=b.Ponuda
	inner join #factGodisnjaPremija c ON b.factPolisa=c.factPolisa

-- Osnovni rizik+doplaci
UPDATE a
SET IznosKorigovan=b.Premija
FROM #factGodisnjaPremija a INNER JOIN
(select c.factPolisa, c.dimRizik, sum(a.UkupnaPremija) Premija
	from SSIS_WT_Polisa a inner JOIN factPolise b on a.BrojPolise=b.Ponuda
		INNER JOIN #factGodisnjaPremija c on b.factPolisa=c.factPolisa
		LEFT JOIN SSIS_WT_DodatniRizici d ON a.IDRizik=d.Id
	WHERE TA=-1 and d.Id is NULL
	GROUP BY c.factPolisa, c.dimRizik) b on a.factPolisa=b.factPolisa and a.dimRizik=b.dimRizik

-- Dopunski rizici SKI i VIP
UPDATE a
SET IznosKorigovan=b.Premija
FROM #factGodisnjaPremija a INNER JOIN
(select c.factPolisa, c.dimRizik, sum(a.UkupnaPremija) Premija
	from SSIS_WT_Polisa a inner JOIN factPolise b on a.BrojPolise=b.Ponuda
		INNER JOIN #factGodisnjaPremija c on b.factPolisa=c.factPolisa
		INNER JOIN SSIS_WT_DodatniRizici d ON a.IDRizik=d.Id
	WHERE TA=-1
	GROUP BY c.factPolisa, c.dimRizik) b on a.factPolisa=b.factPolisa and a.dimRizik=b.dimRizik

UPDATE b SET IznosKorigovan=0 
from factPolise a inner join #factGodisnjaPremija b ON a.factPolisa=b.factPolisa 
WHERE left(Ponuda,8) in  ('10880268','10880658', '10880510') and len(a.Ponuda)>8



-- insert za produkte kojima je premija na nivou propisa (nezgoda), TipSifarnika=8
INSERT #factGodisnjaPremija(factPolisa,pocetaki,kraji,dimRizik,dimTarifa,iznos, VaziOd, VaziDo, IznosKorigovan)
select a.factPolisa, case when c.DatOd<c.DatDo THEN c.DatOd+1 ELSE c.DatDo END, c.DatDo, d.dimRizik, d.dimTarifa, sum(d.Riziko_sum), CASE WHEN a.VaziOd<a.VaziDo THEN a.VaziOd+1 ELSE a.VaziDo END, a.VaziDo, sum(d.Riziko_sum)
from factPolise a 	inner JOIN dimProdukti b on a.dimProdukt=b.dimProdukt
	inner join factPropisi c ON a.factPolisa=c.factPolisa
	INNER JOIN factPropisiPodeljeno d ON c.factPropis=d.factPropis
	INNER JOIN dimSifarnici s on b.Produkt_ID=s.Sifra and s.TipSifarnika=8
WHERE c.Porez=0
GROUP BY a.factPolisa, c.DatOd, c.DatDo, d.dimRizik, d.dimTarifa,a.VaziOd, a.VaziDo


TRUNCATE table factGodisnjaPremija

INSERT factGodisnjaPremija(factPolisa,pocetaki,kraji,dimRizik,dimTarifa,iznos,VaziOd,VaziDo,IznosKorigovan)
select * FROM #factGodisnjaPremija

DROP TABLE #factGodisnjaPremija

update SSIS_Polise SET GodDat_Korigovani=DATEADD(YEAR,-20,GodDat_Korigovani), GodDat=DATEADD(YEAR,-20,GodDat)
GO
