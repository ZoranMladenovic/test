SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_WT_GeneralnePolise] (
		[Ponuda]     [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[IDTA]       [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_WT_GeneralnePolise] SET (LOCK_ESCALATION = TABLE)
GO
