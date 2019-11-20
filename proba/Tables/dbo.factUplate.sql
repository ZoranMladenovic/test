SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[factUplate] (
		[factUplata]      [int] IDENTITY(1, 1) NOT NULL,
		[factPolisa]      [int] NOT NULL,
		[factPropis]      [int] NOT NULL,
		[DatumUplate]     [int] NOT NULL,
		[Iznos]           [decimal](18, 2) NOT NULL,
		[Uplata_ID]       [bigint] NOT NULL,
		[Opis]            [varchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [IX_factUplateC]
	ON [dbo].[factUplate]
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[factUplate] SET (LOCK_ESCALATION = TABLE)
GO
