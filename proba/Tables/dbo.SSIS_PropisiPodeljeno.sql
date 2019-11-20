SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SSIS_PropisiPodeljeno] (
		[Poistka_ID]         [bigint] NULL,
		[Po_Verzia_No]       [smallint] NULL,
		[Sadzba_No]          [smallint] NULL,
		[Tarif_ID]           [smallint] NULL,
		[Tarif_No]           [smallint] NULL,
		[Riziko_ID]          [smallint] NULL,
		[I02_Predpis_ID]     [bigint] NULL,
		[Riziko_sum]         [decimal](18, 2) NULL
)
GO
ALTER TABLE [dbo].[SSIS_PropisiPodeljeno] SET (LOCK_ESCALATION = TABLE)
GO
