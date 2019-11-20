SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOOP_Useri] (
		[User_name]         [varchar](40) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Partner_ID]        [numeric](10, 0) NULL,
		[Je_Blok]           [bit] NULL,
		[RC_ICO]            [varchar](13) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Meno_Nazov2]       [varchar](30) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Priezv_Nazov1]     [varchar](40) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Email]             [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[KOOP_Useri] SET (LOCK_ESCALATION = TABLE)
GO
