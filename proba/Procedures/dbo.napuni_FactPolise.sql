SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[napuni_FactPolise] 
as 
 

 
delete SSIS_Polise WHERE Poistka_ID in (1930568,1963247,1907026) 
 
declare @datum date=getdate(), @dimUgovarac0 int 
 
-- Nepozbati ugovarač 
select @dimUgovarac0=dimUgovarac from dimUgovaraci where Partner_ID=0 
 
/* Prebačeno u doradi_SSISPolise
UPDATE SSIS_Polise  
SET DatumPoslednjeObnove= 
CASE  
	WHEN Plat_Perioda=0 THEN Zac_Dat 
	WHEN Stav_PZ like 'C%' THEN Zac_Dat 
	when Storno_dat < @datum then Zac_Dat 
	WHEN GodDat between zac_dat and Kon_Dat AND GodDat>=@datum and DATEADD(YEAR,-1,GodDat)>Zac_Dat THEN DATEADD(YEAR,-1,GodDat) 
	WHEN GodDat between zac_dat and Kon_Dat and GodDat>=@datum THEN Zac_Dat 
	WHEN GodDat between zac_dat and Kon_Dat THEN GodDat 
	WHEN GodDat > Kon_Dat AND DATEADD(YEAR,-1, Kon_Dat)>Zac_Dat THEN DATEADD(YEAR,-1, Kon_Dat) 
	WHEN GodDat > Kon_Dat THEN Zac_Dat 
	WHEN GodDat<Zac_Dat THEN Zac_Dat 
END 
*/

CREATE TABLE #factPolise(
	[Polisa] [bigint] NOT NULL,
	[Verzija] [smallint] NOT NULL,
	[Ponuda] [varchar](15) NULL,
	[VaziOd] [int] NOT NULL,
	[VaziDo] [int] NOT NULL,
	[StornoDat] [int] NOT NULL,
	[dimRadnik] [int] NOT NULL,
	[dimOJ] [int] NULL,
	[dimUgovarac] [int] NOT NULL,
	[dimProdukt] [int] NOT NULL,
	[dimPodProdukt] [int] NULL,
	[dimStatus] [smallint] NOT NULL,
	[dimDinamika] [smallint] NOT NULL,
	[dimValuta] [smallint] NOT NULL,
	[Premija] [decimal](18, 2) NOT NULL,
	[PremijaPoRizicima] [decimal](18, 2) NULL,
	[DospelaPremija] [decimal](18, 2) NULL,
	[DospeloPorez] [decimal](18, 2) NULL,
	[PlacenoPremija] [decimal](18, 2) NULL,
	[PlacenoPorez] [decimal](18, 2) NULL,
	[NerasknjizenaUplata] [decimal](18, 2) NULL,
	[dimZakljucenje] [smallint] NULL,
	[DatumPoslednjeObnove] [int] NULL,
	[DatumDoObnove] [int] NULL,
	[Poreklo] [smallint] NOT NULL,
	[BrojPrijavljenihSteta] [int] NULL,
	[IsplaceniIznosSteta] [decimal](18, 2) NULL,
	[RezervisaniIznosSteta] [decimal](18, 2) NULL,
	[DatumSklapanja] [int] NULL,
	[dimBOKod] [smallint] NULL,
	[dimEKorisnik] [int] NULL,
	[GodDatOd] [int] NULL,
	[GodDatDo] [int] NULL
) ON [PRIMARY]
 
create CLUSTERED index IX_FPt on #FactPolise(polisa)

INSERT #FactPolise(Polisa, Verzija, Ponuda, Premija, Poreklo, VaziOd, VaziDo, StornoDat, dimRadnik, dimOJ, dimUgovarac, dimDinamika, dimProdukt, dimPodProdukt, dimStatus, dimValuta,  DatumPoslednjeObnove, 
	PremijaPoRizicima, DospelaPremija, DospeloPorez, PlacenoPremija, PlacenoPorez, NerasknjizenaUplata, DatumSklapanja, dimBOKod) 
select Poistka_ID, Po_Verzia_No, isnull(VA_POLNR,''), isnull(Poistne,0), a.Poreklo, z.DimDatum, isnull(k.DimDatum, 109573), isnull(s.DimDatum,109573), r.dimRadnik, r.dimOjPripada, isnull(u.dimUgovarac,@dimUgovarac0), 
	p.dimPeriodka, p1.dimProdukt, dpp.dimPodProdukt,  
	s1.dimStatus, v.dimValuta, o1.DimDatum, 0, 0, 0, 0, 0, 0, uz.DimDatum, bok.dimBOKod 
from SSIS_Polise a inner JOIN dimDatumi z on a.Zac_Dat=z.Datum 
	LEFT JOIN dimDatumi k on a.Kon_Dat=k.Datum 
	LEFT JOIN dimDatumi s on a.Storno_dat=s.Datum 
	inner join dimRadnici r on a.Obchodnik_ID=r.SifraZastupnika 
	LEFT JOIN dimUgovaraci u ON a.Partner_ID=u.Partner_ID 
	INNER JOIN dimPeriodike p on a.Plat_Perioda=p.Perioda_id 
	INNER JOIN dimProdukti p1 on a.Produkt_ID=p1.Produkt_ID and p1.Poreklo=1
	inner JOIN dimStatusi s1 ON a.Stav_PZ=s1.Status_ID 
	INNER join dimValute v on a.Mena_ID=v.Valuta_ID 
	INNER JOIN dimDatumi o1 ON a.DatumPoslednjeObnove=o1.Datum 
	LEFT JOIN dimDatumi uz on a.Uza_Dat=uz.Datum 
	LEFT JOIN dimBOKodovi bok on a.BOKod=bok.Kod 
	left JOIN dimPodProdukti dpp ON a.Produkt_ID=dpp.Produkt_Id and a.PodProdukt=dpp.PodProdukt_Id 
 
update a 
set DatumDoObnove=e.DimDatum 
from #factPolise a INNER JOIN dimDatumi b on a.VaziOd=b.DimDatum 
	INNER JOIN dimDatumi c ON a.VaziDo=c.DimDatum 
	INNER JOIN dimDatumi d ON a.DatumPoslednjeObnove=d.DimDatum 
	inner JOIN dimDatumi E on  dateadd(day,-1,DATEADD(YEAR,1,d.DimDatum))=e.Datum 
	inner JOIN dimStatusi s ON a.dimStatus=s.dimStatus 
where DATEDIFF(MONTH,b.Datum,c.Datum)>=12 and s.StatusGrupa='živa' 

 
update a 
set DatumDoObnove=c.DimDatum 
from #factPolise a INNER JOIN dimDatumi b on a.VaziOd=b.DimDatum 
	INNER JOIN dimDatumi c ON a.VaziDo=c.DimDatum 
	inner JOIN dimStatusi s ON a.dimStatus=s.dimStatus 
where DATEDIFF(MONTH,b.Datum,c.Datum)>=12 and s.StatusGrupa<>'živa' 
 
UPDATE #factPolise set GodDatDo=CASE WHEN DatumDoObnove is NOT NULL then DatumDoObnove WHEN StornoDat<VaziDo then StornoDat ELSE VaziDo end 
UPDATE a set GodDatOd= CASE WHEN a.VaziOd>c.DimDatum THEN a.VaziOd ELSE c.DimDatum END
from #factPolise a inner JOIN dimDatumi b on a.GodDatDo=b.DimDatum
	inner JOIN dimDatumi c ON dateadd(year,-1,b.Datum)=c.Datum
 
---- Pripadnost OJ sa radnika 
--UPDATE a  
--SET dimOJ=b.dimOjPripada 
--from factPolise a INNER JOIN dimRadnici b ON a.dimRadnik=b.dimRadnik 
 
-- prave obnove 
select Poistka_ID, cast (case when len(i01_Pred_Poistka)>=10 and LEFT(i01_Pred_Poistka,2)='19' THEN RIGHT(i01_Pred_Poistka,len(i01_Pred_Poistka)-2) ELSE i01_Pred_Poistka end as NUMERIC) i01_Pred_Poistka 	 
into #t 
from SSIS_Polise WHERE ISNUMERIC(i01_Pred_Poistka)=1 
 
update a 
SET dimZakljucenje=2 
FROM #factPolise a INNER JOIN #t b on a.Polisa=b.Poistka_ID 
	INNER JOIN #factPolise c ON b.i01_Pred_Poistka=c.Polisa 
WHERE a.VaziOd=a.DatumPoslednjeObnove and c.Polisa>1 
 
 
-- obracunske obnove 
UPDATE #factPolise  
SET dimZakljucenje=3 
WHERE dimZakljucenje is NULL and DatumPoslednjeObnove>VaziOd 
 
-- nove 
UPDATE #factPolise  
SET dimZakljucenje=1 
WHERE dimZakljucenje is NULL and DatumPoslednjeObnove=VaziOd 
 
 /*
-- ZK 
select  case when ISNUMERIC(left(I02_VS, len(I02_VS)-1))=1 then left(I02_VS, len(I02_VS)-1) else 0 end vs, a.Poistka_ID, a.I02_VS,a.I02_Od_dat, rata 
into #t1 
from SSIS_Propisane a  
where zk=-1 and ISNUMERIC(left(I02_VS, len(I02_VS)-1))=1 
 
DECLARE  @zk int 
select @zk=dimPodProdukt from dimPodProdukti where Produkt_Id=1010 and PodProdukt_Id=99 
 
INSERT FactPolise(Polisa, Verzija, Ponuda, Premija, Poreklo, VaziOd, VaziDo, StornoDat, dimRadnik, dimOJ, dimUgovarac, dimDinamika, dimProdukt, dimPodProdukt, dimStatus, dimValuta,  DatumPoslednjeObnove, 
	PremijaPoRizicima, DospelaPremija, DospeloPorez, PlacenoPremija, PlacenoPorez, NerasknjizenaUplata, DatumSklapanja, dimBOKod, dimZakljucenje) 
select a.VS,1, b.Polisa, 0, 1 Poreklo, d1.DimDatum, b.VaziDo, b.StornoDat, isnull(r.dimRadnik, b.dimRadnik), isnull(r.dimOjPripada, b.dimOJ), b.dimUgovarac, b.dimDinamika, b.dimProdukt, @zk, b.dimStatus, b.dimValuta, d1.DimDatum, 
	0,0,0,0,0,0, d1.DimDatum, b.dimBOKod, 1 
from #t1 a inner join factPolise b on a.Poistka_ID=b.Polisa 
	inner JOIN dimDatumi d1 on a.I02_Od_dat = d1.Datum 
	LEFT JOIN SSIS_StrogaZK s on a.vs=s.BrojObrasca 
	LEFT join dimRadnici r on s.SifraPosrednika=r.SifraZastupnika 
*/

truncate table factPolise 
INSERT factPolise(Polisa,Verzija,Ponuda,VaziOd,VaziDo,StornoDat,dimRadnik,dimOJ,dimUgovarac,dimProdukt,dimPodProdukt,dimStatus,dimDinamika,dimValuta,Premija,PremijaPoRizicima,DospelaPremija,DospeloPorez,PlacenoPremija,PlacenoPorez,NerasknjizenaUplata,dimZakljucenje,DatumPoslednjeObnove,DatumDoObnove,Poreklo,BrojPrijavljenihSteta,IsplaceniIznosSteta,RezervisaniIznosSteta,DatumSklapanja,dimBOKod,dimEKorisnik,GodDatOd,GodDatDo)
select * from #factPolise

drop table #factPolise
GO
