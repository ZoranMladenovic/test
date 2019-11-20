SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Propisane] (
		[Poistka_ID]         [bigint] NULL,
		[I02_Predpis_ID]     [bigint] NULL,
		[I02_Od_dat]         [date] NULL,
		[I02_Do_dat]         [date] NULL,
		[DatumDospeca]       [date] NULL,
		[rata]               [decimal](18, 2) NULL,
		[Kod_ID]             [varchar](4) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Placeno]            [decimal](18, 2) NULL,
		[Porez]              [smallint] NULL,
		[I02_Platba_Dat]     [date] NULL,
		[I02_VS]             [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Premija]            [smallint] NULL,
		[ZK]                 [smallint] NULL,
		[Kamata]             [smallint] NULL
)
GO
CREATE CLUSTERED INDEX [IX_SSIS_PropisaneC]
	ON [dbo].[SSIS_Propisane] ([Poistka_ID])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_Propisane] SET (LOCK_ESCALATION = TABLE)
GO
