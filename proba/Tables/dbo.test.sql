SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[test] (
		[test]     [int] IDENTITY(1, 1) NOT NULL,
		[int1]     [int] NULL,
		[int2]     [int] NULL,
		[int3]     [int] NULL
)
GO
ALTER TABLE [dbo].[test] SET (LOCK_ESCALATION = TABLE)
GO
