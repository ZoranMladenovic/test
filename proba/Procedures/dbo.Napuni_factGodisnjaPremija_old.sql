SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_factGodisnjaPremija_old]
as

TRUNCATE table factGodisnjaPremija

DECLARE @Jedn int
select @Jedn=dimPeriodka from dimPeriodike where Perioda_id=0


update SSIS_Polise SET KrajDat=case when Kon_Dat<isnull(Storno_dat,Kon_Dat) THEN Kon_Dat else isnull(Storno_dat,Kon_Dat) end, GodDat=DATEADD(YEAR,20,GodDat)

select d.factPolisa,  CASE WHEN  dateadd(YEAR,-b.broj, a.GodDat) <a.Zac_Dat THEN a.Zac_Dat ELSE dateadd(YEAR,-b.broj, a.GodDat) end pocetak,  
	dateadd(day,-1,case when dateadd(YEAR,-b.broj+1, a.GodDat) > a.KrajDat THEN a.KrajDat else dateadd(YEAR,-b.broj+1, a.GodDat) END) kraj,
	0 as pocetakI, 0 as KrajI--, d.dimDinamika, d.VaziOd, case WHEN d.StornoDat<d.VaziDo THEN d.StornoDat else d.VaziDo end VaziDo
INTO #t
from SSIS_Polise a inner JOIN (select top 100 
		ROW_NUMBER() OVER(ORDER BY object_id) broj
		from sys.columns) b on dateadd(YEAR,-b.broj, a.GodDat) BETWEEN a.Zac_Dat and dateadd(day,-1,a.KrajDat)
	inner JOIN SSIS_Produkti c on a.Produkt_ID=c.Produkt_Id and c.Nadredjena <>5
	INNER JOIN factPolise d ON a.Poistka_ID=d.Polisa
WHERE d.dimDinamika<>@Jedn

INSERT #t
select d.factPolisa,  a.Zac_Dat pocetak,  a.KrajDat kraj,	0 as pocetakI, 0 as KrajI
from SSIS_Polise a 
	inner JOIN SSIS_Produkti c on a.Produkt_ID=c.Produkt_Id and c.Nadredjena <>5
	INNER JOIN factPolise d ON a.Poistka_ID=d.Polisa
WHERE d.dimDinamika=@Jedn



UPDATE a
SET pocetaki=d1.DimDatum, kraji=d2.DimDatum
from #t a INNER JOIN dimDatumi d1 ON a.pocetak=d1.Datum
	INNER JOIN dimDatumi d2 on a.kraj=d2.Datum

INSERT factGodisnjaPremija(factPolisa,pocetaki,kraji,dimRizik,dimTarifa,iznos, VaziOd, VaziDo, IznosKorigovan)
select c.factPolisa, a.pocetaki, a.kraji, c.dimRizik, c.dimTarifa, sum(c.Riziko_sum) iznos,0,0,0
from #t a INNER JOIN factPropisi b on a.factpolisa=b.factPolisa and b.DatOd BETWEEN a.pocetaki and kraji
	INNER JOIN factPropisiPodeljeno c ON b.factPropis=c.factPropis 
WHERE b.Porez=0
GROUP BY c.factPolisa, a.pocetaki, a.kraji, c.dimRizik, c.dimTarifa


UPDATE a 
SET VaziOd=b.VaziOd, VaziDo=b.VaziDo,  IznosKorigovan=case WHEN Perioda_id=0 then b.IznosKorigovan ELSE a.iznos END
from factGodisnjaPremija a inner JOIN
	(select b.factPolisa, c.dimRizik, c.dimTarifa, b.VaziOd, b.VaziDo, p.Perioda_id, sum(c.Riziko_sum) IznosKorigovan 
	FROM  factPolise b 	inner JOIN factPropisiPodeljeno c ON b.factPolisa=c.factPolisa
		INNER JOIN dimPeriodike p on b.dimDinamika=p.dimPeriodka
		inner JOIN factPropisi p1 ON c.factPropis=p1.factPropis
	WHERE p1.Porez=0
	GROUP BY b.factPolisa, c.dimRizik, c.dimTarifa, b.VaziOd, b.VaziDo, p.Perioda_id ) b on a.factPolisa=b.factPolisa and a.dimRizik=b.dimRizik and a.dimTarifa=b.dimTarifa

-- insert za jednokratno placanje u godinama kad nije bilo placanja (druga godina)
INSERT factGodisnjaPremija(factPolisa, pocetaki, kraji, dimRizik, dimTarifa, iznos, VaziOd, VaziDo, IznosKorigovan)
select a.factPolisa, a.pocetaki, a.kraji, c.dimRizik, c.dimTarifa, 0,  a.VaziOd, a.VaziDo, c.IznosKorigovan FROM 
(select a.*, b.VaziOd, b.VaziDo 
from #t a INNER JOIN factPolise b 	on a.factpolisa=b.factPolisa
	INNER JOIN dimPeriodike p on b.dimDinamika=p.dimPeriodka
WHERE p.Perioda_id=0) a left JOIN factGodisnjaPremija b on a.factpolisa=b.factPolisa AND a.pocetaki=b.pocetaki and a.kraji=b.kraji
	INNER JOIN ( select factPolisa, dimRizik, dimTarifa,max(IznosKorigovan) IznosKorigovan from factGodisnjaPremija GROUP BY factPolisa, dimRizik, dimTarifa) c ON a.factPolisa=c.factPolisa
WHERE b.factPolisa is NULL



-- korekcija za rizike koji su jednokratni, a polisa nije
Update a 
SET IznosKorigovan=c.IznosKorigovan
from factGodisnjaPremija a inner join dimRizici b on a.dimRizik=b.dimRizik
INNER JOIN
(select b.factPolisa, c.dimRizik, c.dimTarifa, b.VaziOd, b.VaziDo, p.Perioda_id, sum(c.Riziko_sum) IznosKorigovan 
	FROM  factPolise b 	inner JOIN factPropisiPodeljeno c ON b.factPolisa=c.factPolisa
		INNER JOIN dimPeriodike p on b.dimDinamika=p.dimPeriodka
		inner JOIN factPropisi p1 ON c.factPropis=p1.factPropis
	WHERE p1.Porez=0
	GROUP BY b.factPolisa, c.dimRizik, c.dimTarifa, b.VaziOd, b.VaziDo, p.Perioda_id ) c on a.factPolisa=c.factPolisa and a.dimRizik=c.dimRizik and a.dimTarifa=c.dimTarifa
WHERE b.Riziko_ID in ('4112','4262' ) and a.IznosKorigovan <>c.IznosKorigovan

INSERT factGodisnjaPremija(factPolisa, pocetaki, kraji, dimRizik, dimTarifa, iznos, VaziOd, VaziDo, IznosKorigovan)
select a.factPolisa, a.pocetaki, a.kraji, c.dimRizik, c.dimTarifa, 0,  a.VaziOd, a.VaziDo, c.IznosKorigovan FROM 
(select a.*, b.VaziOd, b.VaziDo 
from #t a INNER JOIN factPolise b 	on a.factpolisa=b.factPolisa
	inner join factOsiguraniRizici c on b.factPolisa=c.factPolisa
	inner join dimRizici r ON c.dimRizik=r.dimRizik
WHERE r.Riziko_ID in ('4112','4262' ) 
) a left JOIN factGodisnjaPremija b on a.factpolisa=b.factPolisa AND a.pocetaki=b.pocetaki and a.kraji=b.kraji
	INNER JOIN ( select factPolisa, dimRizik, dimTarifa,max(IznosKorigovan) IznosKorigovan from factGodisnjaPremija GROUP BY factPolisa, dimRizik, dimTarifa) c ON a.factPolisa=c.factPolisa
WHERE b.factPolisa is NULL
order by 1,2


-- korekcija za tarife koje su jednokratne, a polisa nije
Update a 
SET IznosKorigovan=c.IznosKorigovan
from factGodisnjaPremija a inner join dimTarife b on a.dimTarifa=b.dimTarifa
INNER JOIN
(select b.factPolisa, c.dimRizik, c.dimTarifa, b.VaziOd, b.VaziDo, p.Perioda_id, sum(c.Riziko_sum) IznosKorigovan 
	FROM  factPolise b 	inner JOIN factPropisiPodeljeno c ON b.factPolisa=c.factPolisa
		INNER JOIN dimPeriodike p on b.dimDinamika=p.dimPeriodka
		inner JOIN factPropisi p1 ON c.factPropis=p1.factPropis
	WHERE p1.Porez=0
	GROUP BY b.factPolisa, c.dimRizik, c.dimTarifa, b.VaziOd, b.VaziDo, p.Perioda_id ) c on a.factPolisa=c.factPolisa and a.dimRizik=c.dimRizik and a.dimTarifa=c.dimTarifa
WHERE b.Tarif_ID in (15980,15981,15982,15983,15984,15995,15996,15997,15998,15999,15907,15958,15959,16000,16001,16002,16003,16004,16005,16006,16007) and a.IznosKorigovan <>c.IznosKorigovan

INSERT factGodisnjaPremija(factPolisa, pocetaki, kraji, dimRizik, dimTarifa, iznos, VaziOd, VaziDo, IznosKorigovan)
select a.factPolisa, a.pocetaki, a.kraji, c.dimRizik, c.dimTarifa, 0,  a.VaziOd, a.VaziDo, c.IznosKorigovan FROM 
(select a.*, b.VaziOd, b.VaziDo 
from #t a INNER JOIN factPolise b 	on a.factpolisa=b.factPolisa
	inner join factOsiguraniRizici c on b.factPolisa=c.factPolisa
WHERE c.TarifID in (15980,15981,15982,15983,15984,15995,15996,15997,15998,15999,15907,15958,15959,16000,16001,16002,16003,16004,16005,16006,16007)
) a left JOIN factGodisnjaPremija b on a.factpolisa=b.factPolisa AND a.pocetaki=b.pocetaki and a.kraji=b.kraji
	INNER JOIN ( select factPolisa, dimRizik, dimTarifa,max(IznosKorigovan) IznosKorigovan from factGodisnjaPremija GROUP BY factPolisa, dimRizik, dimTarifa) c ON a.factPolisa=c.factPolisa
WHERE b.factPolisa is NULL
order by 1,2


-- Turističke agencije
-- Generalna na 0

update c SET IznosKorigovan=0
from SSIS_WT_GeneralnePolise a inner join factPolise b on a.Ponuda=b.Ponuda
	inner join factGodisnjaPremija c ON b.factPolisa=c.factPolisa

-- Osnovni rizik+doplaci
UPDATE a
SET IznosKorigovan=b.Premija
FROM factGodisnjaPremija a INNER JOIN
(select c.factPolisa, c.dimRizik, sum(a.premija) Premija
	from SSIS_WT_Polisa a inner JOIN factPolise b on a.BrojPolise=b.Ponuda
		INNER JOIN factGodisnjaPremija c on b.factPolisa=c.factPolisa
		LEFT JOIN SSIS_WT_DodatniRizici d ON a.IDRizik=d.Id
	WHERE TA=-1 and d.Id is NULL
	GROUP BY c.factPolisa, c.dimRizik) b on a.factPolisa=b.factPolisa and a.dimRizik=b.dimRizik

-- Dopunski rizici SKI i VIP
UPDATE a
SET IznosKorigovan=b.Premija
FROM factGodisnjaPremija a INNER JOIN
(select c.factPolisa, c.dimRizik, sum(a.premija) Premija
	from SSIS_WT_Polisa a inner JOIN factPolise b on a.BrojPolise=b.Ponuda
		INNER JOIN factGodisnjaPremija c on b.factPolisa=c.factPolisa
		INNER JOIN SSIS_WT_DodatniRizici d ON a.IDRizik=d.Id
	WHERE TA=-1
	GROUP BY c.factPolisa, c.dimRizik) b on a.factPolisa=b.factPolisa and a.dimRizik=b.dimRizik

UPDATE b SET IznosKorigovan=0 
from factPolise a inner join factGodisnjaPremija b ON a.factPolisa=b.factPolisa 
WHERE left(Ponuda,8) in  ('10880268','10880658', '10880510') and len(a.Ponuda)>8

UPDATE a
SET pocetaki=b.DatumSklapanja
from factGodisnjaPremija a INNER JOIN factPolise b on a.factPolisa=b.factPolisa
WHERE b.DatumSklapanja>a.pocetaki


UPDATE a
SET kraji=b.DatumSklapanja
from factGodisnjaPremija a INNER JOIN factPolise b on a.factPolisa=b.factPolisa
WHERE b.DatumSklapanja>a.kraji


GO
