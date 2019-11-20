SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[factPropisiPodeljeno] (
		[factPropisPodeljeno]     [int] IDENTITY(1, 1) NOT NULL,
		[factPolisa]              [int] NOT NULL,
		[dimTarifa]               [int] NOT NULL,
		[dimRizik]                [int] NOT NULL,
		[factPropis]              [int] NOT NULL,
		[Riziko_sum]              [decimal](18, 2) NULL
)
GO
CREATE CLUSTERED COLUMNSTORE INDEX [IX_factPropisiPodeljenoC]
	ON [dbo].[factPropisiPodeljeno]
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[factPropisiPodeljeno] SET (LOCK_ESCALATION = TABLE)
GO
