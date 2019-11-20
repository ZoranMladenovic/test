SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_NOKurzy] (
		[UcinOd_dat]     [date] NULL,
		[datDo]          [date] NULL,
		[Mena_do_ID]     [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Kurz]           [decimal](12, 6) NULL
)
GO
ALTER TABLE [dbo].[SSIS_NOKurzy] SET (LOCK_ESCALATION = TABLE)
GO
