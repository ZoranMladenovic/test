SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Vozila] (
		[poistka_id]           [bigint] NULL,
		[Po_Verzia_No]         [smallint] NULL,
		[Sadzba_No]            [smallint] NULL,
		[Broj_Putnika]         [smallint] NULL,
		[Broj_Sedista]         [smallint] NULL,
		[Broj_Mjesta]          [smallint] NULL,
		[BrojSasije]           [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RegBroj]              [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[motor_id]             [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Marka]                [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Model]                [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Spe_ID]               [bigint] NULL,
		[Gorivo]               [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Farba]                [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Zapremina]            [int] NULL,
		[Snaga]                [decimal](18, 2) NULL,
		[Kategorija]           [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Nosivost]             [int] NULL,
		[GodinProizvodnje]     [int] NULL,
		[Namena]               [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_ssisVozilaC]
	ON [dbo].[SSIS_Vozila] ([poistka_id])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_Vozila] SET (LOCK_ESCALATION = TABLE)
GO
