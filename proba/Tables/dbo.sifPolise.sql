SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[sifPolise] (
		[TipSifarnika]     [smallint] NULL,
		[Sifra]            [smallint] NULL,
		[factPolisa]       [int] NULL
)
GO
CREATE CLUSTERED INDEX [IX_sifPoliseC]
	ON [dbo].[sifPolise] ([factPolisa])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[sifPolise] SET (LOCK_ESCALATION = TABLE)
GO
