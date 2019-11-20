SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Stete] (
		[Skoda_ID]                  [bigint] NULL,
		[Poistka_ID]                [bigint] NULL,
		[Sadzba_No]                 [smallint] NULL,
		[Riziko_ID]                 [smallint] NULL,
		[DelimicniRizik]            [smallint] NULL,
		[DatumNastanka]             [date] NULL,
		[DatumPrijave]              [date] NULL,
		[BrojZahtevaArhiva]         [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[StatusStete]               [int] NULL,
		[StatusOpis]                [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Mena_ID]                   [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Rezerva_sum]               [decimal](18, 2) NULL,
		[IsplaceniIznos]            [decimal](18, 2) NULL,
		[DatumPoslednjeIsplate]     [date] NULL,
		[IDObjekta]                 [bigint] NULL,
		[Osteceni]                  [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[UzrokID]                   [int] NULL,
		[UzrokOpis]                 [varchar](150) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Regres]                    [smallint] NULL,
		[OstvareniRegres]           [decimal](18, 2) NULL,
		[OcekivaniRegres]           [decimal](18, 2) NULL,
		[StatusRegresaID]           [smallint] NULL,
		[StatusRegresa]             [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Zakl_Objekt_NoM]           [smallint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_Stete] SET (LOCK_ESCALATION = TABLE)
GO
