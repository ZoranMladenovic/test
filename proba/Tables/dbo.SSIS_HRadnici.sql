SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SSIS_HRadnici] (
		[Putanja]              [hierarchyid] NULL,
		[AvizoSifra]           [bigint] NULL,
		[Nadredjeni]           [bigint] NULL,
		[nivo]                 [smallint] NULL,
		[Sifra_Zaposlenog]     [bigint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_HRadnici] SET (LOCK_ESCALATION = TABLE)
GO
