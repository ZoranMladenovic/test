SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_ObjektiDetalji] (
		[Poistka_ID]       [bigint] NULL,
		[Po_Verzia_No]     [smallint] NULL,
		[Sadzba_No]        [smallint] NULL,
		[Nazov]            [varchar](1000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSuma]            [decimal](18, 2) NULL,
		[Sadzba]           [decimal](18, 2) NULL,
		[MJ_Sadzba]        [varchar](2) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Poistne_vyp]      [decimal](18, 2) NULL,
		[Klasif_txt]       [varchar](1000) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_ObjektiDetalji] SET (LOCK_ESCALATION = TABLE)
GO
