SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimProdukti] (
		[dimProdukt]      [int] NOT NULL,
		[Nivo]            [int] NOT NULL,
		[Produkt_ID]      [int] NOT NULL,
		[Nadredjena]      [int] NOT NULL,
		[ProduktName]     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NOT NULL,
		[Poreklo]         [smallint] NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimProduktiC]
	ON [dbo].[dimProdukti] ([dimProdukt])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimProdukti1]
	ON [dbo].[dimProdukti] ([Produkt_ID])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimProdukti] SET (LOCK_ESCALATION = TABLE)
GO
