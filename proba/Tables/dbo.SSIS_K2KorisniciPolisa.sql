SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_K2KorisniciPolisa] (
		[BrojPolise]             [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SifraKorisnika]         [bigint] NULL,
		[SifraFilijaleBanke]     [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[NazivFilijaleBanke]     [varchar](2000) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_K2KorisniciPolisa] SET (LOCK_ESCALATION = TABLE)
GO
