SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimBOKodovi] (
		[dimBOKod]     [smallint] IDENTITY(1, 1) NOT NULL,
		[Kod]          [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NOT NULL,
		[Opis]         [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NOT NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimBOKodoviC]
	ON [dbo].[dimBOKodovi] ([dimBOKod])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_dimBOKodoviU]
	ON [dbo].[dimBOKodovi] ([Kod])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimBOKodovi] SET (LOCK_ESCALATION = TABLE)
GO
