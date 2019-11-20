SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_ProduktiKUP] (
		[SifraVrsteOsiguranja]     [int] NULL,
		[VrstaOsiguranja]          [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Nadredjeni]               [int] NULL,
		[dimProdukt]               [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_ProduktiKUP] SET (LOCK_ESCALATION = TABLE)
GO
