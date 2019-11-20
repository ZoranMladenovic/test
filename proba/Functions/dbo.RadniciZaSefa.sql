SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[RadniciZaSefa] (@SZ bigint)  
	RETURNS @expl_tbl TABLE (val int, broj int)  
AS  
BEGIN 
	declare @o hierarchyid, @broj int

	SELECT @o=ojnode
	from dimRadnici a INNER JOIN dimOj b on a.dimOjGleda=b.dimOj
	WHERE a.SifraZastupnika=@sz

	INSERT into @expl_tbl(val)
	select b.dimRadnik
	from dimOj a INNER JOIN dimRadnici b ON a.dimOj=b.dimOjPripada
	WHERE OjNode.IsDescendantOf(@o)=1 
	UNION
	select b.dimRadnik
	from dimOj a INNER JOIN dimRadnici b ON a.dimOj=b.dimOjPripada
	WHERE SifraZastupnika=@sz

	select @broj=count(*) from @expl_tbl
	update @expl_tbl set broj=@broj

RETURN
end
GO
