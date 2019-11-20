SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimValute] (
		[dimValuta]     [int] IDENTITY(1, 1) NOT NULL,
		[Valuta_ID]     [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Kurs]          [decimal](18, 10) NULL,
		[Valuta]        [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimValuteC]
	ON [dbo].[dimValute] ([dimValuta])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimValute] SET (LOCK_ESCALATION = TABLE)
GO
