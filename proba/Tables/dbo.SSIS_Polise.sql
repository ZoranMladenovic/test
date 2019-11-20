SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Polise] (
		[Poistka_ID]               [bigint] NULL,
		[Po_Verzia_No]             [smallint] NULL,
		[VA_POLNR]                 [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Zac_Dat]                  [date] NULL,
		[Kon_Dat]                  [date] NULL,
		[Storno_dat]               [date] NULL,
		[GodDat]                   [date] NULL,
		[Poistne]                  [decimal](18, 2) NULL,
		[Mena_ID]                  [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Obchodnik_ID]             [bigint] NULL,
		[OJ_ujed_ID]               [varchar](6) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Produkt_ID]               [smallint] NULL,
		[Stav_PZ]                  [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Plat_Perioda]             [tinyint] NULL,
		[Poreklo]                  [int] NULL,
		[Partner_ID]               [bigint] NULL,
		[i01_Pred_Poistka]         [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[VerzijaOd]                [date] NULL,
		[VerzijaDo]                [date] NULL,
		[DatumPoslednjeObnove]     [date] NULL,
		[Uza_Dat]                  [date] NULL,
		[PodProdukt]               [smallint] NULL,
		[BOKod]                    [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[NacinPlacanja]            [varchar](2) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[NacinPlacanjaTxt]         [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TypVHI_ID]                [smallint] NULL,
		[ObjCinnost_ID]            [smallint] NULL,
		[KrajDat]                  [date] NULL,
		[ZacDat_Korigovani]        [date] NULL,
		[GodDat_Korigovani]        [date] NULL,
		[SatZacDat]                [smallint] NULL,
		[SatKonDat]                [smallint] NULL
)
GO
CREATE NONCLUSTERED INDEX [IX1]
	ON [dbo].[SSIS_Polise] ([Poistka_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX2]
	ON [dbo].[SSIS_Polise] ([VA_POLNR])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_Polise] SET (LOCK_ESCALATION = TABLE)
GO
