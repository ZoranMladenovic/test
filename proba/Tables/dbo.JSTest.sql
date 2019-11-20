SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JSTest] (
		[jSTest]           [int] IDENTITY(1, 1) NOT NULL,
		[poistka_id]       [bigint] NULL,
		[Po_Verzia_No]     [smallint] NULL,
		[Sadzba_No]        [smallint] NULL,
		[Spe_ID]           [bigint] NULL,
		[js]               [varchar](5000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[vBS]              AS (json_value([js],'$.BrojSasije'))
)
GO
ALTER TABLE [dbo].[JSTest] SET (LOCK_ESCALATION = TABLE)
GO
