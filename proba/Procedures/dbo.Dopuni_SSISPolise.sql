SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Dopuni_SSISPolise]
as

 
delete SSIS_Polise WHERE Poistka_ID in (1930568,1963247,1907026) 

UPDATE SSIS_Polise 
SET ZacDat_Korigovani =DATEADD(day,1,Zac_Dat), GodDat_Korigovani=DATEADD(DAY,1,GodDat) 
WHERE SatZacDat>=23 OR SatZacDat=0 OR SatZacDat=SatKonDat

UPDATE SSIS_Polise 
SET ZacDat_Korigovani =Zac_Dat, GodDat_Korigovani=GodDat
WHERE ZacDat_Korigovani is NULL

declare @datum date=getdate()

update SSIS_Polise SET KrajDat=case when Kon_Dat<isnull(Storno_dat,Kon_Dat) THEN Kon_Dat else isnull(Storno_dat,Kon_Dat) end,
	DatumPoslednjeObnove= 
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

/*
update SSIS_Polise 
SET ZacDat_Korigovani = DATEADD(DAY, 1, Zac_Dat), GodDat_Korigovani=DATEADD(DAY,1,GodDat)
WHERE ZacDat_Korigovani is NULL
	and day(Zac_Dat)=DAY(Kon_Dat) and MONTH(Zac_Dat)=MONTH(Kon_Dat) and YEAR(Zac_Dat)<YEAR(Kon_Dat) and  day(Kon_Dat)=DAY(GodDat) and MONTH(Kon_Dat)=MONTH(GodDat) 

update SSIS_Polise 
SET ZacDat_Korigovani = DATEADD(DAY, 1, Zac_Dat), GodDat_Korigovani=GodDat
WHERE ZacDat_Korigovani is NULL
	and day(Zac_Dat)=DAY(Kon_Dat) and MONTH(Zac_Dat)=MONTH(Kon_Dat) and YEAR(Zac_Dat)<YEAR(Kon_Dat) 

update SSIS_Polise 
SET ZacDat_Korigovani = Zac_Dat, GodDat_Korigovani=GodDat
WHERE ZacDat_Korigovani is NULL

*/

UPDATE a
SET Plat_Perioda=0
from SSIS_Polise a inner join SSIS_OsiguraniRizici b on a.Poistka_ID=b.Poistka_ID
	INNER JOIN dimSifarnici c ON b.Riziko_ID=c.Sifra and c.TipSifarnika=5
--WHERE Riziko_ID in (4112,4262 )


UPDATE a
SET Plat_Perioda=0
from SSIS_Polise a inner join SSIS_OsiguraniRizici b on a.Poistka_ID=b.Poistka_ID
	INNER JOIN dimSifarnici c ON b.TarifID=c.Sifra and c.TipSifarnika=4
--where TarifID in (15980,15981,15982,15983,15984,15995,15996,15997,15998,15999,15907,15958,15959,16000,16001,16002,16003,16004,16005,16006,16007)
GO
