SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[izvCombo_Zakljucenja]
as
select dimZakljucenje, ZakljucenjeNaziv from dimZakljucenja order by 1
GO
