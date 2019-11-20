SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Radnici] (
		[MATICNIBROJ]          [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SIFRA_ZASTUPNIKA]     [bigint] NULL,
		[AVIZOSIFRA]           [bigint] NULL,
		[oj_id]                [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[IME]                  [nvarchar](250) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PREZIME]              [nvarchar](250) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[NAZIV_RM]             [nvarchar](250) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Gleda]                [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_Radnici] SET (LOCK_ESCALATION = TABLE)
GO
