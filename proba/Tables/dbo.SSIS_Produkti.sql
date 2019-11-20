SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Produkti] (
		[dimProdukt]        [int] IDENTITY(1, 1) NOT NULL,
		[Produkt_Id]        [int] NULL,
		[Produkt_Naziv]     [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[NadredjenaID]      [int] NULL,
		[Nadredjena]        [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_Produkti] SET (LOCK_ESCALATION = TABLE)
GO
