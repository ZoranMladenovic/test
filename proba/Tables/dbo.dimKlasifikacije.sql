SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[dimKlasifikacije] (
		[Tip]       [tinyint] NOT NULL,
		[Sifra]     [tinyint] NOT NULL,
		[ID]        [int] NOT NULL
)
GO
ALTER TABLE [dbo].[dimKlasifikacije] SET (LOCK_ESCALATION = TABLE)
GO
