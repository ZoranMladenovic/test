SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_AxaBruto] (
		[DatumKnjizenja]             [datetime] NULL,
		[IDPolicy]                   [int] NULL,
		[PolicyNumber]               [nvarchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PremiumStatementNumber]     [nvarchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[createdate]                 [datetime] NULL,
		[IssueDate]                  [datetime] NULL,
		[PolisaOd]                   [datetime] NULL,
		[PolisaDo]                   [datetime] NULL,
		[datumStorna]                [datetime] NULL,
		[IDRisk]                     [int] NULL,
		[RiskName]                   [nvarchar](150) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[AxaPremija]                 [money] NULL,
		[WsoPremija]                 [money] NULL,
		[CurrencyRate]               [money] NULL,
		[AxaPremijaDin]              [money] NULL,
		[WsoPremijaDin]              [money] NULL,
		[IDInsuredObjectClass]       [bigint] NULL,
		[InsuredSubjectName]         [nvarchar](400) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TariffGroupCode]            [varchar](15) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[TariffGroupName]            [nvarchar](350) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[InsuranceTypeCode]          [varchar](12) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PolicyStatusCode]           [varchar](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[CurrencyLabel]              [varchar](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PrezimeUgovaraca]           [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[ImeUgovaraca]               [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MBUgovaraca]                [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[vrstaUgovaraca]             [varchar](7) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PrezimeOsiguranika]         [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[ImeOsiguranika]             [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MBOsiguranika]              [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[vrstaOsiguranika]           [varchar](7) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PrezimePosrednika]          [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[ImePosrednika]              [nvarchar](50) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[MBPosrednika]               [varchar](20) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[vrstaPosrednika]            [varchar](7) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[ObracunOd]                  [datetime] NULL,
		[ObracunDo]                  [datetime] NULL,
		[Tehnicka]                   [float] NULL,
		[Rezija]                     [float] NULL,
		[Preventiva]                 [float] NULL,
		[PM]                         [varchar](3) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED INDEX [IX_SSIS_AxaBrutoC]
	ON [dbo].[SSIS_AxaBruto] ([IDPolicy])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SSIS_AxaBruto] SET (LOCK_ESCALATION = TABLE)
GO
