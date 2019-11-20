SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[factOsiguraniRizici] (
		[factOsiguraniRizik]     [int] IDENTITY(1, 1) NOT NULL,
		[factPolisa]             [int] NOT NULL,
		[Sadzba_no]              [smallint] NOT NULL,
		[dimRizik]               [int] NOT NULL,
		[TipTarife]              [smallint] NULL,
		[TarifID]                [smallint] NULL,
		[Premija]                [decimal](18, 2) NOT NULL,
		[OSuma]                  [decimal](18, 2) NOT NULL,
		[LOB5]                   [char](5) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[OsiguraniObjekat]       [varchar](400) COLLATE SQL_Croatian_CP1250_CI_AS NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [IX_factOsiguraniRiziciC]
	ON [dbo].[factOsiguraniRizici]
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Typ_tarif - 1 osnovni, 3 dopunski', 'SCHEMA', N'dbo', 'TABLE', N'factOsiguraniRizici', 'COLUMN', N'TipTarife'
GO
ALTER TABLE [dbo].[factOsiguraniRizici] SET (LOCK_ESCALATION = TABLE)
GO
