SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_OOsobe] (
		[poistka_id]        [bigint] NULL,
		[Po_Verzia_No]      [smallint] NULL,
		[naziv]             [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RC_ICO]            [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Stat_txt]          [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC]               [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC_txt]           [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[ulica]             [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Partner_ID]        [bigint] NULL,
		[Pol]               [smallint] NULL,
		[Telefon]           [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Pasos]             [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[DatumRodjenja]     [date] NULL
)
GO
CREATE CLUSTERED INDEX [IX_ssisOsobeC]
	ON [dbo].[SSIS_OOsobe] ([poistka_id])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_OOsobe] SET (LOCK_ESCALATION = TABLE)
GO
