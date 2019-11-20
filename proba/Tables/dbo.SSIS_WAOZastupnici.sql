SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SSIS_WAOZastupnici] (
		[SifraZastupnika]     [int] NULL,
		[Limit]               [decimal](18, 2) NULL
)
GO
ALTER TABLE [dbo].[SSIS_WAOZastupnici] SET (LOCK_ESCALATION = TABLE)
GO
