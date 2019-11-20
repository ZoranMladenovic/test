SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fSviPodredjeni] (@id bigint)  
	RETURNS @expl_tbl TABLE (val bigint, nivo int, broj int)  
AS  
BEGIN 
	DECLARE @Hid as Hierarchyid, @level int, @broj int
	select @Hid=PutanjaGleda, @level=nivo from dimRadnici where  SifraZastupnika=@id

	INSERT into @expl_tbl(val, NIVO)
	select dimRadnik,nivo-@level nivo
	from dimRadnici
	WHERE Putanja.IsDescendantOf(@Hid)=1 
	

	select @broj=count(*) from @expl_tbl
	update @expl_tbl set broj=@broj
RETURN
end
GO
