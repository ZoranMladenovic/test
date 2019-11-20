SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Radnici2] (
		[Partner_ID]     [bigint] NULL,
		[Oj_ujed_ID]     [varchar](6) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[naziv]          [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MB]             [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_Radnici2] SET (LOCK_ESCALATION = TABLE)
GO
