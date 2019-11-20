SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_AOOstalo] (
		[Poistka_ID]              [bigint] NULL,
		[VremePocetka]            [varchar](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[VremeZavrsetka]          [varchar](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PrethodniMB]             [varchar](13) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PrethodniOsiguravac]     [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Pred_Poistka]            [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PrethodniStepen]         [varchar](40) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TekuciStepen]            [varchar](40) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Je_Preneseny]            [smallint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_AOOstalo] SET (LOCK_ESCALATION = TABLE)
GO
