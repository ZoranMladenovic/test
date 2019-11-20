SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_UgovaraciKUP] (
		[Ugovarac]          [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MB]                [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Ulica]             [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Broj]              [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Mesto]             [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PTT]               [int] NULL,
		[TelKuca]           [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Mob]               [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Posao]             [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[eMail]             [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PravnoFizicko]     [int] NULL,
		[id]                [int] NULL,
		[BrojPonude]        [int] NULL,
		[dimUgovarac]       [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_UgovaraciKUP]
	ADD
	CONSTRAINT [DF_SSIS_UgovaraciKUP_dimUgovarac]
	DEFAULT ((0)) FOR [dimUgovarac]
GO
ALTER TABLE [dbo].[SSIS_UgovaraciKUP] SET (LOCK_ESCALATION = TABLE)
GO
