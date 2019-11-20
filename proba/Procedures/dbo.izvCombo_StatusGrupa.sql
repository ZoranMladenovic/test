SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[izvCombo_StatusGrupa]
as
select DISTINCT StatusGrupa from dimStatusi order by 1 desc
GO
