SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_OstaleAdrese] (
		[Partner_ID]     [bigint] NULL,
		[TipAdrese]      [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Stat_txt]       [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC]            [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC_txt]        [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Ulica]          [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Dom_No]         [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Tel_No]         [varchar](254) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Fax_No]         [varchar](254) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_OstaleAdrese] SET (LOCK_ESCALATION = TABLE)
GO
