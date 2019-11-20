SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImportKontrola] (
		[BrojPolise]          [float] NULL,
		[Verzija]             [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[BrojPonude]          [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Riziko_ID]           [float] NULL,
		[Tarif_id]            [float] NULL,
		[Periodicnost]        [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Valuta]              [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Posrednik]           [float] NULL,
		[Filijala]            [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TotalPremija]        [float] NULL,
		[InkasnaPremija]      [float] NULL,
		[PremijaPoRiziku]     [float] NULL,
		[SvedeniPocetak]      [datetime] NULL,
		[SvedeniKraj]         [datetime] NULL,
		[SvedenoTrajanje]     [float] NULL,
		[PP_Dani]             [float] NULL,
		[PP_Premija]          [float] NULL,
		[PP_Kursirano]        [float] NULL,
		[sifraNBS]            [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[LOB_5]               [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Izvor]               [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[GodPoc]              [float] NULL
)
GO
ALTER TABLE [dbo].[ImportKontrola] SET (LOCK_ESCALATION = TABLE)
GO
