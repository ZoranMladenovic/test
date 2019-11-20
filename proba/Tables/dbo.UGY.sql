SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[UGY] (
		[BrojPolise]     [bigint] NULL,
		[godina]         [int] NULL,
		[Verzija]        [smallint] NULL
)
GO
ALTER TABLE [dbo].[UGY] SET (LOCK_ESCALATION = TABLE)
GO
