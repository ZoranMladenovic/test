SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimSifarnici] (
		[TipSifarnika]     [int] NULL,
		[Sifra]            [int] NULL,
		[SifraChar]        [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Opis]             [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimSifarniciC]
	ON [dbo].[dimSifarnici] ([Sifra])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimSifarnici] SET (LOCK_ESCALATION = TABLE)
GO
