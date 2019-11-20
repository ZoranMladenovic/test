SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_RadnikKanal] (
		[Partner_ID]     [bigint] NULL,
		[Oj_ujed_ID]     [varchar](6) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Typ_zisk]       [varchar](4) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Od_dat]         [date] NULL,
		[Do_dat]         [date] NULL,
		[Aktivan]        [smallint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_RadnikKanal] SET (LOCK_ESCALATION = TABLE)
GO
