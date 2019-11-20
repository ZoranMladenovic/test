SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[dimKursevi] (
		[dimKurs]       [int] IDENTITY(1, 1) NOT NULL,
		[dimValuta]     [int] NOT NULL,
		[KursOd]        [int] NOT NULL,
		[KursDo]        [int] NOT NULL,
		[Kurs]          [decimal](12, 6) NULL
)
GO
CREATE CLUSTERED INDEX [IX_dimkurseviC]
	ON [dbo].[dimKursevi] ([KursOd])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dimKursevi] SET (LOCK_ESCALATION = TABLE)
GO
