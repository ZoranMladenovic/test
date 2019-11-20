SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimEKorisnici] (
		[dimEKorisnik]               [int] IDENTITY(1, 1) NOT NULL,
		[Korisnik]                   [int] NULL,
		[KorisnikNaziv]              [varchar](500) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[KopSifra]                   [int] NULL,
		[NazivZastupnika]            [varchar](500) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TipLogovanja]               [smallint] NULL,
		[TipEksternogZastupnika]     [int] NULL,
		[TipNaziv]                   [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SifraFilijaleBanke]         [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[NazivFilijaleBanke]         [varchar](500) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Region]                     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SifraBankara]               [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[dimRadnik]                  [int] NULL,
		[dimOj]                      [int] NULL
)
GO
ALTER TABLE [dbo].[dimEKorisnici] SET (LOCK_ESCALATION = TABLE)
GO
