SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_RiziciKUP] (
		[SifraOsnRizika]     [int] NULL,
		[OsnovniRizik]       [nvarchar](150) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_RiziciKUP] SET (LOCK_ESCALATION = TABLE)
GO
