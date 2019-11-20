SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimOj] (
		[OjNode]     [hierarchyid] NOT NULL,
		[dimOj]      [int] NULL,
		[Nivo]       [int] NULL,
		[OJ_ID]      [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NOT NULL,
		[OjName]     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NOT NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimOjC]
	ON [dbo].[dimOj] ([dimOj])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimOj1]
	ON [dbo].[dimOj] ([OJ_ID])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimOj] SET (LOCK_ESCALATION = TABLE)
GO
