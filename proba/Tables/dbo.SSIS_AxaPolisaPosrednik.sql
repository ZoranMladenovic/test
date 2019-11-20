SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_AxaPolisaPosrednik] (
		[IDPolicy]                   [int] NULL,
		[PolicyNumber]               [nvarchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[SellingChannelTypeCode]     [varchar](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[CompanyName]                [nvarchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PersonalID]                 [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
ALTER TABLE [dbo].[SSIS_AxaPolisaPosrednik] SET (LOCK_ESCALATION = TABLE)
GO
