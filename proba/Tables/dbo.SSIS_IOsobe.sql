SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_IOsobe] (
		[poistka_id]       [bigint] NULL,
		[Po_Verzia_No]     [smallint] NULL,
		[Sadzba_No]        [smallint] NULL,
		[Objekt_NoM]       [smallint] NULL,
		[naziv]            [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RC_ICO]           [varchar](13) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Stat_txt]         [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC]              [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC_txt]          [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[ulica]            [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Partner_ID]       [bigint] NULL,
		[Pohlavie]         [smallint] NULL,
		[Tel_No]           [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_IOsobe] SET (LOCK_ESCALATION = TABLE)
GO
