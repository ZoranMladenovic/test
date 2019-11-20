SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Napuni_factOsiguraniRiziciKUP]
as
insert factOsiguraniRizici(factPolisa, Sadzba_no, dimRizik, TipTarife, TarifID, Premija,OSuma)
select b.factPolisa, 0,c.dimRizik, 0, a.SifraTarife, ISNULL(a.Premija,0), ISNULL(a.OSuma,0)
from SSIS_OsiguraniRiziciKUP a INNER JOIN factPolise b ON a.BrojPonude=b.Ponuda and b.Poreklo=2
	INNER JOIN dimRizici c ON a.Rizik=c.Riziko_ID and c.poreklo=2
GO
