SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_WT_Polisa] (
		[BrojPolise]            [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Pocetak]               [date] NULL,
		[kraj]                  [date] NULL,
		[OsiguranaSuma]         [decimal](18, 2) NULL,
		[premija]               [decimal](18, 2) NULL,
		[UkupnaPremija]         [decimal](18, 2) NULL,
		[ZaUplatu]              [decimal](18, 2) NULL,
		[PolPrefix]             [int] NULL,
		[TA]                    [smallint] NULL,
		[IdTarife]              [int] NULL,
		[IDRizik]               [int] NULL,
		[IDGeneralnaPolisa]     [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_WT_Polisa] SET (LOCK_ESCALATION = TABLE)
GO
