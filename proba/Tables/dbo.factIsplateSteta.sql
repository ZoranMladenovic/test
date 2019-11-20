SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[factIsplateSteta] (
		[factIsplataStete]     [int] IDENTITY(1, 1) NOT NULL,
		[factSteta]            [int] NOT NULL,
		[DatumOdobrenja]       [int] NOT NULL,
		[DatumPlacanja]        [int] NOT NULL,
		[dimPrimalacStete]     [int] NULL,
		[dimValuta]            [int] NOT NULL,
		[PlaceniIznos]         [decimal](18, 2) NULL,
		[I10_Vratka_id]        [bigint] NULL,
		[racun]                [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_factIsplateStetaC]
	ON [dbo].[factIsplateSteta] ([factIsplataStete])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[factIsplateSteta] SET (LOCK_ESCALATION = TABLE)
GO
