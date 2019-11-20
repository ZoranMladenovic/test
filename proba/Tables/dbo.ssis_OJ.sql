SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ssis_OJ] (
		[dimOJ]                [int] IDENTITY(1, 1) NOT NULL,
		[Oj_ID]                [varchar](6) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[OJ_Naziv]             [varchar](40) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Nadredjena_OJ_ID]     [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[NadredjenaOJ]         [int] NULL
)
GO
ALTER TABLE [dbo].[ssis_OJ] SET (LOCK_ESCALATION = TABLE)
GO
