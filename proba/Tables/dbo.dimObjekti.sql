SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimObjekti] (
		[dimObjekat]             [int] IDENTITY(1, 1) NOT NULL,
		[factOsiguraniRizik]     [int] NOT NULL,
		[factPolisa]             [int] NOT NULL,
		[ID]                     [bigint] NULL,
		[TipObjekta]             [smallint] NOT NULL,
		[ObjekatJS]              [varchar](5000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[vRegBroj]               AS (json_value([ObjekatJS],'$.RegBroj')),
		[vBrojSasije]            AS (json_value([ObjekatJS],'$.BrojSasije')),
		[vMarka]                 AS (json_value([ObjekatJS],'$.Marka'))
)
GO
CREATE UNIQUE CLUSTERED INDEX [IX_dimObjektiC]
	ON [dbo].[dimObjekti] ([dimObjekat])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimObjekti1]
	ON [dbo].[dimObjekti] ([factOsiguraniRizik])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimObjekti2]
	ON [dbo].[dimObjekti] ([factPolisa])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idxDO_Polisa]
	ON [dbo].[dimObjekti] ([factPolisa])
	INCLUDE ([vBrojSasije], [vMarka], [vRegBroj])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idxDO_vBrojSasije]
	ON [dbo].[dimObjekti] ([vBrojSasije])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idxDO_vMarka]
	ON [dbo].[dimObjekti] ([vMarka])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idxDO_vRegBroj]
	ON [dbo].[dimObjekti] ([vRegBroj])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'1 Vozilo, 2 osoba', 'SCHEMA', N'dbo', 'TABLE', N'dimObjekti', 'COLUMN', N'TipObjekta'
GO
ALTER TABLE [dbo].[dimObjekti] SET (LOCK_ESCALATION = TABLE)
GO
