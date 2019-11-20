SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Uplate] (
		[I03_Pl_dat]         [date] NULL,
		[I03_Poznamka]       [varchar](254) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[I04_Platba_sum]     [decimal](18, 2) NULL,
		[Poistka_ID]         [bigint] NULL,
		[I03_Platba_id]      [bigint] NULL,
		[I02_Predpis_ID]     [bigint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_Uplate] SET (LOCK_ESCALATION = TABLE)
GO
