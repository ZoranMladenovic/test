SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimPodProdukti] (
		[dimPodProdukt]       [int] IDENTITY(1, 1) NOT NULL,
		[Produkt_Id]          [int] NULL,
		[PodProdukt_Id]       [smallint] NULL,
		[PodProduktNaziv]     [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Specijal]            [smallint] NULL
)
GO
ALTER TABLE [dbo].[dimPodProdukti]
	ADD
	CONSTRAINT [DF_dimPodProdukti_Specijal]
	DEFAULT ((0)) FOR [Specijal]
GO
CREATE CLUSTERED INDEX [IX_dimPodProduktiC]
	ON [dbo].[dimPodProdukti] ([dimPodProdukt])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimPodProdukti] SET (LOCK_ESCALATION = TABLE)
GO
