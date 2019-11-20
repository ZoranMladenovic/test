SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimPrimaociSteta] (
		[dimPrimalacStete]     [int] IDENTITY(1, 1) NOT NULL,
		[Partner_ID]           [bigint] NULL,
		[naziv]                [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RC_ICO]               [varchar](13) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Stat_txt]             [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC]                  [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PSC_txt]              [varchar](40) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Ulica]                [varchar](42) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Dom_No]               [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Pa_druh]              [bit] NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimPrimaociStetaC]
	ON [dbo].[dimPrimaociSteta] ([dimPrimalacStete])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimPrimaociSteta] SET (LOCK_ESCALATION = TABLE)
GO
