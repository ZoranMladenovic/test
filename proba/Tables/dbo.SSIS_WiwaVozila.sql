SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_WiwaVozila] (
		[RegistarskiBrojPolise]     [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MarkaVozila]               [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TipVozila]                 [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_SSIS_WiwaVozilaC]
	ON [dbo].[SSIS_WiwaVozila] ([RegistarskiBrojPolise])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_WiwaVozila] SET (LOCK_ESCALATION = TABLE)
GO
