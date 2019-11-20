SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimVinkulanti] (
		[dimVinkulant]          [int] IDENTITY(1, 1) NOT NULL,
		[factPolisa]            [int] NULL,
		[RB]                    [smallint] NULL,
		[Partner_ID]            [bigint] NULL,
		[Naziv]                 [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RC_ICO]                [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Drzava]                [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PTT]                   [varchar](10) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Grad]                  [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Ulica]                 [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Broj]                  [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[FizickoLice]           [smallint] NULL,
		[Leasing]               [smallint] NULL,
		[Mobilni]               [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[EMail]                 [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SMSEmailDozvoljen]     [smallint] NULL,
		[Telefon]               [varchar](254) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Fax]                   [varchar](254) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimVinkulantiC]
	ON [dbo].[dimVinkulanti] ([factPolisa])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimVinkulanti] SET (LOCK_ESCALATION = TABLE)
GO
