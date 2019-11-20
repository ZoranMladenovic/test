SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimTarife] (
		[dimTarifa]       [int] IDENTITY(1, 1) NOT NULL,
		[dimProdukt]      [int] NULL,
		[dimRizik]        [int] NULL,
		[Tarif_ID]        [int] NULL,
		[NazivTarife]     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[dimTarife] SET (LOCK_ESCALATION = TABLE)
GO
