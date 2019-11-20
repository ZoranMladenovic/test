SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Osobe_VHI] (
		[Poistka_ID]          [bigint] NULL,
		[Po_verzia_No]        [smallint] NULL,
		[Sadzba_No]           [smallint] NULL,
		[ClenSkupVHI_ID]      [int] NULL,
		[naziv]               [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RC]                  [varchar](13) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Partner_ID]          [bigint] NULL,
		[Datum_Narodenia]     [date] NULL,
		[Pohlavie]            [smallint] NULL,
		[VstVek]              [smallint] NULL,
		[Ucin_od]             [date] NULL,
		[Ucin_do]             [date] NULL
)
GO
ALTER TABLE [dbo].[SSIS_Osobe_VHI] SET (LOCK_ESCALATION = TABLE)
GO
