SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_WAInfo] (
		[Id]                           [bigint] NULL,
		[ClassType]                    [nvarchar](255) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[FullName]                     [nvarchar](100) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[InfoQuoteNumber]              [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[CreatedAt]                    [datetime] NULL,
		[BirthYear]                    [int] NULL,
		[PaymentDynamic]               [int] NULL,
		[Gender]                       [int] NULL,
		[Currency]                     [int] NULL,
		[InsuranceStartDate]           [datetime] NULL,
		[InsuranceDurationInYears]     [int] NULL,
		[InsuranceDelayInYears]        [int] NULL,
		[AnnualPremium]                [decimal](18, 2) NULL,
		[InsuredAmount]                [decimal](18, 2) NULL,
		[Installment]                  [decimal](18, 2) NULL,
		[TotalAnnualPremium]           [decimal](18, 2) NULL,
		[TotalInstallment]             [decimal](18, 2) NULL,
		[UserId]                       [int] NULL,
		[LoginType]                    [int] NULL,
		[FinancialBasis]               [int] NULL,
		[IsStandingOrder]              [bit] NULL
)
GO
ALTER TABLE [dbo].[SSIS_WAInfo] SET (LOCK_ESCALATION = TABLE)
GO
