SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[snGodisnjaPremija] (
		[datum]               [date] NOT NULL,
		[factPolisa]          [int] NULL,
		[Polisa]              [bigint] NOT NULL,
		[Ponuda]              [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Riziko_ID]           [int] NULL,
		[RizikoNaziv]         [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Tarif_ID]            [int] NULL,
		[NazivTarife]         [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SifraZastupnika]     [bigint] NULL,
		[Naziv]               [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Typ_zisk]            [varchar](4) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Status_ID]           [varchar](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[LOB5]                [char](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[iznos]               [decimal](18, 2) NULL
)
GO
ALTER TABLE [dbo].[snGodisnjaPremija] SET (LOCK_ESCALATION = TABLE)
GO
