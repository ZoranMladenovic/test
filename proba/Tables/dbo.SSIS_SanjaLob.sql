SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_SanjaLob] (
		[Tarif_ID]     [smallint] NULL,
		[SifraNBS]     [char](2) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[LOB_5]        [char](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_SSIS_SanjaLobC]
	ON [dbo].[SSIS_SanjaLob] ([Tarif_ID])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_SanjaLob] SET (LOCK_ESCALATION = TABLE)
GO
