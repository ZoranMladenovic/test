SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[factOsiguraniRiziciDetalji] (
		[factOsiguraniRizikDetalj]     [int] IDENTITY(1, 1) NOT NULL,
		[factOsiguraniRizik]           [int] NOT NULL,
		[Naziv]                        [varchar](1000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Rizik]                        [varchar](1000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[OsiguranaSuma]                [decimal](18, 2) NULL,
		[Stopa]                        [decimal](18, 2) NULL,
		[JedinicaStope]                [varchar](2) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Premija]                      [decimal](18, 2) NULL
)
GO
ALTER TABLE [dbo].[factOsiguraniRiziciDetalji] SET (LOCK_ESCALATION = TABLE)
GO
