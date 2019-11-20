SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimRadnici] (
		[dimRadnik]           [int] IDENTITY(1, 1) NOT NULL,
		[Naziv]               [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[NazivRM]             [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MB]                  [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SifraZastupnika]     [bigint] NULL,
		[AvizoSifra]          [bigint] NULL,
		[dimOjPripada]        [int] NULL,
		[dimOjGleda]          [int] NULL,
		[Putanja]             [hierarchyid] NULL,
		[nivo]                [smallint] NULL,
		[PutanjaGleda]        [hierarchyid] NULL,
		[AOLimit]             [decimal](18, 2) NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimRadniciC]
	ON [dbo].[dimRadnici] ([dimRadnik])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimRadnici2]
	ON [dbo].[dimRadnici] ([dimOjPripada])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimRadnici1]
	ON [dbo].[dimRadnici] ([SifraZastupnika])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimRadnici] SET (LOCK_ESCALATION = TABLE)
GO
