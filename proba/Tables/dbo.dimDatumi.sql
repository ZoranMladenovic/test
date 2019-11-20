SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimDatumi] (
		[DimDatum]               [int] NOT NULL,
		[Datum]                  [date] NULL,
		[Godina]                 [smallint] NULL,
		[Kvartal]                [smallint] NULL,
		[Mesec]                  [smallint] NULL,
		[Nedelja]                [smallint] NULL,
		[Dan]                    [smallint] NULL,
		[DanUNedelji]            [smallint] NULL,
		[DanUNedeljiTxt]         [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MesecTxt]               [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PrviDanMeseca]          [int] NULL,
		[PoslednjiDanMeseca]     [int] NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimDatumiC]
	ON [dbo].[dimDatumi] ([DimDatum])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_dimDatumi1]
	ON [dbo].[dimDatumi] ([Datum])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimDatumi] SET (LOCK_ESCALATION = TABLE)
GO
