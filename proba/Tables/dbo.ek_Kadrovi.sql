SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ek_Kadrovi] (
		[AVIZOSIFRA]           [bigint] NULL,
		[SIFRA_ZASTUPNIKA]     [bigint] NULL,
		[PREZIME]              [nvarchar](250) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[IME]                  [nvarchar](250) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[EMAIL]                [nvarchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[OJ_KOOP]              [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[ek_Kadrovi] SET (LOCK_ESCALATION = TABLE)
GO
