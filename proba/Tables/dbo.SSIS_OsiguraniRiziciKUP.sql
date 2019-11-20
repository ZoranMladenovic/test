SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SSIS_OsiguraniRiziciKUP] (
		[BrojPonude]      [int] NULL,
		[Premija]         [decimal](18, 2) NULL,
		[SifraTarife]     [int] NULL,
		[Rizik]           [int] NULL,
		[OSuma]           [decimal](18, 2) NULL,
		[porez]           [decimal](18, 2) NULL
)
GO
ALTER TABLE [dbo].[SSIS_OsiguraniRiziciKUP] SET (LOCK_ESCALATION = TABLE)
GO
