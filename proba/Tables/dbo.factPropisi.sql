SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[factPropisi] (
		[factPropis]     [int] IDENTITY(1, 1) NOT NULL,
		[factPolisa]     [int] NOT NULL,
		[DatOd]          [int] NOT NULL,
		[DatDo]          [int] NOT NULL,
		[DatDospeca]     [int] NOT NULL,
		[Rata]           [decimal](18, 2) NOT NULL,
		[Placeno]        [decimal](18, 2) NOT NULL,
		[Predpis_ID]     [bigint] NOT NULL,
		[Porez]          [smallint] NULL,
		[DatUplate]      [int] NULL,
		[VS]             [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [IX_factPropisiC]
	ON [dbo].[factPropisi]
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_factPropisi1]
	ON [dbo].[factPropisi] ([Predpis_ID])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'0 PREMIJA, -1 POREZ', 'SCHEMA', N'dbo', 'TABLE', N'factPropisi', 'COLUMN', N'Porez'
GO
ALTER TABLE [dbo].[factPropisi] SET (LOCK_ESCALATION = TABLE)
GO
