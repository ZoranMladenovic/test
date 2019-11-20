SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SSIS_EKKorisnici] (
		[IDKorisnik]     [bigint] NULL,
		[AvizoSifra]     [bigint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_EKKorisnici] SET (LOCK_ESCALATION = TABLE)
GO
