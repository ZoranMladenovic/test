SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SSIS_PropisiKUP] (
		[BrojPonude]       [int] NULL,
		[RBrRate]          [int] NULL,
		[DatumDospeca]     [date] NULL,
		[Iznos]            [decimal](18, 2) NULL,
		[DatumUplate]      [date] NULL,
		[Uplata]           [decimal](18, 2) NULL,
		[Tip]              [smallint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_PropisiKUP] SET (LOCK_ESCALATION = TABLE)
GO
