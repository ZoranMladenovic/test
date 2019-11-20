SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimStatusi] (
		[dimStatus]       [int] IDENTITY(1, 1) NOT NULL,
		[Status_ID]       [varchar](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[StatusNaziv]     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[StatusGrupa]     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimStatusiC]
	ON [dbo].[dimStatusi] ([dimStatus])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimStatusi1]
	ON [dbo].[dimStatusi] ([Status_ID])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimStatusi] SET (LOCK_ESCALATION = TABLE)
GO
