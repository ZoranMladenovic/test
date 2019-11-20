SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimZakljucenja] (
		[dimZakljucenje]       [int] IDENTITY(1, 1) NOT NULL,
		[ZakljucenjeNaziv]     [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimZakljucenjaC]
	ON [dbo].[dimZakljucenja] ([dimZakljucenje])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimZakljucenja] SET (LOCK_ESCALATION = TABLE)
GO
