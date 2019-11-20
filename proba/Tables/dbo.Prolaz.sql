SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Prolaz] (
		[factPolisa]           [int] NOT NULL,
		[Polisa]               [bigint] NOT NULL,
		[Ponuda]               [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Od]                   [date] NULL,
		[Do]                   [date] NULL,
		[Produkt_ID]           [int] NOT NULL,
		[ProduktName]          [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NOT NULL,
		[Riziko_ID]            [int] NULL,
		[RizikoNaziv]          [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Tarif_ID]             [int] NULL,
		[NazivTarife]          [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SifraZastupnika]      [bigint] NULL,
		[Zastupnik]            [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Status_ID]            [varchar](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[LOB5]                 [char](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[iznos]                [decimal](38, 2) NULL,
		[Valuta]               [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Kurs]                 [numeric](9, 6) NULL,
		[ZakljucenjeNaziv]     [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RC_ICO]               [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Ugovarac]             [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[Prolaz] SET (LOCK_ESCALATION = TABLE)
GO
