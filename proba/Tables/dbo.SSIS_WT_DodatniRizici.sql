SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SSIS_WT_DodatniRizici] (
		[Id]           [int] NOT NULL,
		[Naziv]        [varchar](200) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[RizikoID]     [int] NULL
)
GO
ALTER TABLE [dbo].[SSIS_WT_DodatniRizici] SET (LOCK_ESCALATION = TABLE)
GO
