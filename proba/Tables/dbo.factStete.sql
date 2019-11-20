SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[factStete] (
		[factSteta]                 [int] IDENTITY(1, 1) NOT NULL,
		[factPolisa]                [int] NOT NULL,
		[dimRizik]                  [int] NOT NULL,
		[dimDelimicniRizik]         [smallint] NULL,
		[dimObjekat]                [int] NOT NULL,
		[DatumNastanka]             [int] NOT NULL,
		[DatumPrijave]              [int] NOT NULL,
		[DatumPoslednjeIsplate]     [int] NOT NULL,
		[BrojZahtevaArhiva]         [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[StatusStete]               [int] NULL,
		[StatusOpis]                [varchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[dimValuta]                 [int] NULL,
		[RezervisaniIznos]          [decimal](18, 2) NULL,
		[IsplaceniIznos]            [decimal](18, 2) NULL,
		[SkodaID]                   [bigint] NULL,
		[Osteceni]                  [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[UzrokID]                   [int] NULL,
		[UzrokOpis]                 [varchar](150) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Regres]                    [smallint] NULL,
		[OstvareniRegres]           [decimal](18, 2) NULL,
		[OcekivaniRegres]           [decimal](18, 2) NULL,
		[StatusRegresaID]           [int] NULL,
		[StatusRegresa]             [varchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE UNIQUE CLUSTERED INDEX [IX_factSteteC]
	ON [dbo].[factStete] ([factSteta])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_factStete1]
	ON [dbo].[factStete] ([factPolisa])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[factStete] SET (LOCK_ESCALATION = TABLE)
GO
