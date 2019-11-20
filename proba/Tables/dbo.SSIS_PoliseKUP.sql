SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_PoliseKUP] (
		[BrojPolise]               [int] NULL,
		[BrojPonude]               [int] NULL,
		[SifPosrednika]            [int] NULL,
		[SifVrsteOsiguranja]       [int] NULL,
		[DatumPocetak]             [date] NULL,
		[DatumKraj]                [date] NULL,
		[DatumRaskida]             [date] NULL,
		[DatumZakljucenja]         [date] NULL,
		[TotalPremija]             [float] NULL,
		[Valuta]                   [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TotalSuma]                [float] NULL,
		[IznosPoreza]              [float] NULL,
		[Storno]                   [bit] NULL,
		[Lizing]                   [bit] NULL,
		[TotalRataPremije]         [float] NULL,
		[StatusUgovora]            [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[DatumPoslednjeObnove]     [date] NULL,
		[DospeloPorez]             [float] NULL
)
GO
ALTER TABLE [dbo].[SSIS_PoliseKUP] SET (LOCK_ESCALATION = TABLE)
GO
