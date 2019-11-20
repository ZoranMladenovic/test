SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_SifNezgodaLOB] (
		[ObjCinnost_ID]      [smallint] NOT NULL,
		[ObjCinnost_txt]     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[LOB]                [char](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_SSIS_SifNezgodaLOBC]
	ON [dbo].[SSIS_SifNezgodaLOB] ([ObjCinnost_ID])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_SifNezgodaLOB] SET (LOCK_ESCALATION = TABLE)
GO
