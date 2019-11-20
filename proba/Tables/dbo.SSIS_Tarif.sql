SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Tarif] (
		[Tarif_ID]       [smallint] NULL,
		[Produkt_ID]     [smallint] NULL,
		[Riziko_ID]      [smallint] NULL,
		[Objekt_txt]     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_Tarif] SET (LOCK_ESCALATION = TABLE)
GO
