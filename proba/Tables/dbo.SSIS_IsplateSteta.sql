SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_IsplateSteta] (
		[I10_Vratka_id]      [bigint] NULL,
		[DatumOdobrenja]     [date] NULL,
		[DatumPlacanja]      [date] NULL,
		[Opis]               [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Skoda_ID]           [bigint] NULL,
		[Partner_ID]         [bigint] NULL,
		[ValutaPlacanja]     [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PlaceniIznos]       [decimal](18, 2) NULL,
		[PoslataValuta]      [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PoslatiIznos]       [decimal](18, 2) NULL,
		[Banka]              [varchar](9) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Racun]              [varchar](24) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_IsplateSteta] SET (LOCK_ESCALATION = TABLE)
GO
