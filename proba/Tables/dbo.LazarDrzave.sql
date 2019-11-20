SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LazarDrzave] (
		[GetCodebookPlacesPostalNumbersResult]     [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[error]                                    [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[LazarDrzave] SET (LOCK_ESCALATION = TABLE)
GO
