SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[factPolise] (
		[factPolisa]                [int] IDENTITY(1, 1) NOT NULL,
		[Polisa]                    [bigint] NOT NULL,
		[Verzija]                   [smallint] NOT NULL,
		[Ponuda]                    [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[VaziOd]                    [int] NOT NULL,
		[VaziDo]                    [int] NOT NULL,
		[StornoDat]                 [int] NOT NULL,
		[dimRadnik]                 [int] NOT NULL,
		[dimOJ]                     [int] NULL,
		[dimUgovarac]               [int] NOT NULL,
		[dimProdukt]                [int] NOT NULL,
		[dimPodProdukt]             [int] NULL,
		[dimStatus]                 [smallint] NOT NULL,
		[dimDinamika]               [smallint] NOT NULL,
		[dimValuta]                 [smallint] NOT NULL,
		[Premija]                   [decimal](18, 2) NOT NULL,
		[PremijaPoRizicima]         [decimal](18, 2) NULL,
		[DospelaPremija]            [decimal](18, 2) NULL,
		[DospeloPorez]              [decimal](18, 2) NULL,
		[PlacenoPremija]            [decimal](18, 2) NULL,
		[PlacenoPorez]              [decimal](18, 2) NULL,
		[NerasknjizenaUplata]       [decimal](18, 2) NULL,
		[dimZakljucenje]            [smallint] NULL,
		[DatumPoslednjeObnove]      [int] NULL,
		[DatumDoObnove]             [int] NULL,
		[Poreklo]                   [smallint] NOT NULL,
		[BrojPrijavljenihSteta]     [int] NULL,
		[IsplaceniIznosSteta]       [decimal](18, 2) NULL,
		[RezervisaniIznosSteta]     [decimal](18, 2) NULL,
		[DatumSklapanja]            [int] NULL,
		[dimBOKod]                  [smallint] NULL,
		[dimEKorisnik]              [int] NULL,
		[GodDatOd]                  [int] NULL,
		[GodDatDo]                  [int] NULL
)
GO
ALTER TABLE [dbo].[factPolise]
	ADD
	CONSTRAINT [DF_factPolise_BrojPrijavljenihSteta]
	DEFAULT ((0)) FOR [BrojPrijavljenihSteta]
GO
ALTER TABLE [dbo].[factPolise]
	ADD
	CONSTRAINT [DF_factPolise_IsplaceniIznosSteta]
	DEFAULT ((0)) FOR [IsplaceniIznosSteta]
GO
ALTER TABLE [dbo].[factPolise]
	ADD
	CONSTRAINT [DF_factPolise_RezervisaniIznosSteta]
	DEFAULT ((0)) FOR [RezervisaniIznosSteta]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [IX_factPoliseC]
	ON [dbo].[factPolise]
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_factPolise]
	ON [dbo].[factPolise] ([dimRadnik])
	INCLUDE ([DatumSklapanja], [dimProdukt], [dimStatus], [factPolisa])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_factPolise1]
	ON [dbo].[factPolise] ([factPolisa])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_factPolise2]
	ON [dbo].[factPolise] ([Polisa])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_factPolise3]
	ON [dbo].[factPolise] ([Ponuda])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'1 koop, 2 kup, 3 axa', 'SCHEMA', N'dbo', 'TABLE', N'factPolise', 'COLUMN', N'Poreklo'
GO
ALTER TABLE [dbo].[factPolise] SET (LOCK_ESCALATION = TABLE)
GO
