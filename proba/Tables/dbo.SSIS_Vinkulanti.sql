SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Vinkulanti] (
		[Partner_ID]                [bigint] NULL,
		[Poistka_ID]                [bigint] NULL,
		[naziv]                     [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RC_ICO]                    [varchar](13) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Stat_txt]                  [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC]                       [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC_txt]                   [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Ulica]                     [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Dom_No]                    [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Pa_druh]                   [smallint] NULL,
		[Je_Leasing]                [smallint] NULL,
		[Mobil]                     [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Email]                     [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Is_Mobile_SMS_Enabled]     [smallint] NULL,
		[Tel_No]                    [varchar](254) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Fax_No]                    [varchar](254) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_Vinkulanti] SET (LOCK_ESCALATION = TABLE)
GO
