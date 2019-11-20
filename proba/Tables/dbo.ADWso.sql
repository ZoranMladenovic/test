SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ADWso] (
		[AccountExpirationDate]          [datetime] NULL,
		[Description]                    [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[DisplayName]                    [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Enabled]                        [bit] NULL,
		[GivenName]                      [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Mail]                           [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Mobile]                         [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Name]                           [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PasswordNeverExpires]           [bit] NULL,
		[PasswordNotRequired]            [bit] NULL,
		[SamAccountName]                 [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[UserPrincipalName]              [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[Department]                     [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[PhysicalDeliveryOfficeName]     [nvarchar](4000) COLLATE SQL_Croatian_CP1250_CI_AS NULL,
		[UserCannotChangePassword]       [bit] NULL
)
GO
ALTER TABLE [dbo].[ADWso] SET (LOCK_ESCALATION = TABLE)
GO
