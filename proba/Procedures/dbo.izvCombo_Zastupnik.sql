SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvCombo_Zastupnik] @OJ varchar(8000), @UserID int
as

declare @a int=0

select @a=count(*) from dimRadnici WHERE SifraZastupnika=@UserID and dimOjGleda is NOT NULL

IF @a=0
	select a.dimRadnik,  cast(a.SifraZastupnika as varchar(100))+ ' - ' + a.Naziv Naziv 
	from dimRadnici a
	WHERE SifraZastupnika=@UserID
ELSE
	select a.dimRadnik,  cast(a.SifraZastupnika as varchar(100))+ ' - ' + a.Naziv Naziv 
	from dimRadnici a inner JOIN  STRING_SPLIT(@OJ, ',') oj on a.dimOjPripada=oj.value
GO
