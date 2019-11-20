SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImportKontrola_20180430] (
		[BrojPolise]            [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Verzija]               [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[BrojPonude]            [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[DatumZakljucenja]      [datetime] NULL,
		[DatumPocetak]          [datetime] NULL,
		[DatumKraj]             [datetime] NULL,
		[Storno_Dat]            [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Verzia_uc_dat]         [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Verzia_uc_dat_do]      [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Produkt_ID]            [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PRODUKT_TXT]           [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MarketinskiNaziv]      [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Riziko_ID]             [float] NULL,
		[Rizik_txt]             [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Tarif_id]              [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Objekt]                [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Ugovarac]              [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MBUgovarac]            [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Osiguranik]            [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MBOsiguranik]          [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[OsiguranikFizicko]     [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Periodicnost]          [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Valuta]                [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Posrednik]             [float] NULL,
		[Filijala]              [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TotalPremija]          [float] NULL,
		[InkasnaPremija]        [float] NULL,
		[PremijaPoRiziku]       [float] NULL,
		[SvedeniPocetak]        [datetime] NULL,
		[SvedeniKraj]           [datetime] NULL,
		[SvedenoTrajanje]       [float] NULL,
		[PP_Dani]               [float] NULL,
		[PP_Premija]            [float] NULL,
		[PP_Kursirano]          [float] NULL,
		[sifraNBS]              [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[LOB_5]                 [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Izvor]                 [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[GodPoc]                [float] NULL
)
GO
ALTER TABLE [dbo].[ImportKontrola_20180430] SET (LOCK_ESCALATION = TABLE)
GO
