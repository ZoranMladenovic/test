SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_NOsobeSve] (
		[Poistka_ID]                [bigint] NULL,
		[Po_Verzia_No]              [smallint] NULL,
		[Produkt_ID]                [smallint] NULL,
		[Tarif_ID]                  [smallint] NULL,
		[Riziko_ID]                 [smallint] NULL,
		[Tech_Verzia_uc_dat]        [datetime] NULL,
		[Tech_Verzia_uc_dat_do]     [datetime] NULL,
		[Sadzba_No]                 [smallint] NULL,
		[Zakl_Objekt_NoM]           [smallint] NULL,
		[naziv]                     [varchar](500) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[BrojOsoba]                 [int] NULL,
		[Poradie_No]                [smallint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_NOsobeSve] SET (LOCK_ESCALATION = TABLE)
GO
