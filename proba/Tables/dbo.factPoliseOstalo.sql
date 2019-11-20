SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[factPoliseOstalo] (
		[factPolisaOstalo]     [int] IDENTITY(1, 1) NOT NULL,
		[factPolisa]           [int] NOT NULL,
		[OstaloJS]             [varchar](5000) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_factPolisaOstalo]
	ON [dbo].[factPoliseOstalo] ([factPolisa])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[factPoliseOstalo] SET (LOCK_ESCALATION = TABLE)
GO
