SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_Brodovi] (
		[Poistka_ID]       [bigint] NULL,
		[Po_Verzia_No]     [smallint] NULL,
		[Sadzba_No]        [smallint] NULL,
		[Naziv]            [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Drzava]           [varchar](2) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[DrzavaNaziv]      [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Reg_No]           [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Kapacitet]        [smallint] NULL
)
GO
ALTER TABLE [dbo].[SSIS_Brodovi] SET (LOCK_ESCALATION = TABLE)
GO
