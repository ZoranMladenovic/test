SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dimRizici] (
		[dimRizik]        [int] IDENTITY(1, 1) NOT NULL,
		[Riziko_ID]       [int] NULL,
		[RizikoNaziv]     [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Poreklo]         [smallint] NULL
)
GO
ALTER TABLE [dbo].[dimRizici]
	ADD
	CONSTRAINT [DF_dimRizici_Poreklo]
	DEFAULT ((1)) FOR [Poreklo]
GO
CREATE CLUSTERED INDEX [IX_dimRiziciC]
	ON [dbo].[dimRizici] ([dimRizik])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimRizici] SET (LOCK_ESCALATION = TABLE)
GO
