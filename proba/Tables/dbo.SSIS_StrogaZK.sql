SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SSIS_StrogaZK] (
		[BrojObrasca]         [int] NULL,
		[SifraPosrednika]     [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_StrogaZK] SET (LOCK_ESCALATION = TABLE)
GO
