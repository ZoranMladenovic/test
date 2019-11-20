SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_ONezgoda] (
		[Poistka_ID]          [bigint] NULL,
		[Po_Verzia_No]        [smallint] NULL,
		[Sadzba_No]           [smallint] NULL,
		[Zakl_Objekt_NoM]     [smallint] NULL,
		[Objekt_txt]          [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RC]                  [varchar](13) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Dat_nar]             [date] NULL,
		[naziv]               [varchar](291) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[BrojOsoba]           [int] NULL,
		[Poradie_No]          [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_ONezgoda] SET (LOCK_ESCALATION = TABLE)
GO
