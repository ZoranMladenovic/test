SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmppartner] (
		[partner]     [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Kanal]       [varchar](150) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[tmppartner] SET (LOCK_ESCALATION = TABLE)
GO
