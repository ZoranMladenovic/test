SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_dimRiziciKUP]
as
insert dimRizici(Riziko_ID, RizikoNaziv, Poreklo)
SELECT SifraOsnRizika,OsnovniRizik,2 FROM SSIS_RiziciKUP
GO
