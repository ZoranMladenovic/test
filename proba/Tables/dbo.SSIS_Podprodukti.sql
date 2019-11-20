SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Podprodukti] (
		[Produkt_ID]       [smallint] NOT NULL,
		[Text_tlac_nr]     [tinyint] NOT NULL,
		[Text_tlac]        [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_Podprodukti] SET (LOCK_ESCALATION = TABLE)
GO
