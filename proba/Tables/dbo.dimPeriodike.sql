SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimPeriodike] (
		[dimPeriodka]         [int] IDENTITY(1, 1) NOT NULL,
		[Perioda_id]          [int] NULL,
		[PeriodaNaziv]        [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[BrojRataUGodini]     [int] NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimPeriodikeC]
	ON [dbo].[dimPeriodike] ([dimPeriodka])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimPeriodike1]
	ON [dbo].[dimPeriodike] ([Perioda_id])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimPeriodike] SET (LOCK_ESCALATION = TABLE)
GO
