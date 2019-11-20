SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[factGodisnjaPremija] (
		[factGodisnjaPremija]     [int] IDENTITY(1, 1) NOT NULL,
		[factPolisa]              [int] NOT NULL,
		[pocetaki]                [int] NOT NULL,
		[kraji]                   [int] NOT NULL,
		[dimRizik]                [int] NOT NULL,
		[dimTarifa]               [int] NOT NULL,
		[iznos]                   [decimal](18, 2) NOT NULL,
		[VaziOd]                  [int] NULL,
		[VaziDo]                  [int] NULL,
		[IznosKorigovan]          [decimal](18, 2) NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [IX_factGodisnjaPremijaC]
	ON [dbo].[factGodisnjaPremija]
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[factGodisnjaPremija] SET (LOCK_ESCALATION = TABLE)
GO
