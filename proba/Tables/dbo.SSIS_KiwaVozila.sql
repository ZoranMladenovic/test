SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_KiwaVozila] (
		[Policy_Num]      [bigint] NOT NULL,
		[GC_Car_Make]     [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Typ_txt]         [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE NONCLUSTERED INDEX [IX_SSIS_KiwaVozilaC]
	ON [dbo].[SSIS_KiwaVozila] ([Policy_Num])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_KiwaVozila] SET (LOCK_ESCALATION = TABLE)
GO
