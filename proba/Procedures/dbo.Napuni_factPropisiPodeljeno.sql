SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Napuni_factPropisiPodeljeno]
as
truncate table factPropisiPodeljeno

insert factPropisiPodeljeno(factPolisa, dimTarifa,dimRizik,factPropis,Riziko_sum)
select b.factPolisa, c.dimTarifa, d.dimRizik, e.factPropis, a.Riziko_sum
from SSIS_PropisiPodeljeno a inner JOIN factPolise b on a.Poistka_ID=b.Polisa
	INNER JOIN dimTarife c on a.Tarif_ID=c.Tarif_ID
	inner JOIN dimRizici d on a.Riziko_ID=d.Riziko_ID
	INNER JOIN factPropisi e ON a.I02_Predpis_ID=e.Predpis_ID

GO
