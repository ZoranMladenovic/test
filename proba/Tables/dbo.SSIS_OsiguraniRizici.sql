SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_OsiguraniRizici] (
		[Poistka_ID]           [bigint] NULL,
		[Po_Verzia_No]         [smallint] NULL,
		[Riziko_ID]            [smallint] NULL,
		[premija]              [decimal](18, 2) NULL,
		[OSuma]                [decimal](18, 2) NULL,
		[Sadzba_No]            [smallint] NULL,
		[TipTarife]            [smallint] NULL,
		[TarifID]              [smallint] NULL,
		[OsiguraniObjekat]     [varchar](400) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Delatnost]            [varchar](500) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_OsiguraniRizici] SET (LOCK_ESCALATION = TABLE)
GO
