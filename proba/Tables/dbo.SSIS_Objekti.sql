SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Objekti] (
		[Poistka_ID]          [bigint] NULL,
		[Po_Verzia_No]        [smallint] NULL,
		[Sadzba_No]           [smallint] NULL,
		[Zakl_Objekt_NoM]     [smallint] NULL,
		[Objekt_txt]          [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PTTBroj]             [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Grad]                [varchar](40) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Drzava]              [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Ulica]               [varchar](42) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Broj]                [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_SSISObjektiC]
	ON [dbo].[SSIS_Objekti] ([Poistka_ID])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_Objekti] SET (LOCK_ESCALATION = TABLE)
GO
