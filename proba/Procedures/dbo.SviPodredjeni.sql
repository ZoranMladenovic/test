SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SviPodredjeni] @id int
as
DECLARE @Hid as Hierarchyid, @level int
select @Hid=PutanjaGleda from dimRadnici where dimRadnik=@id

select PutanjaGleda,SifraZastupnika, Naziv, NazivRM, cast(Putanja as varchar(4000)) putanja, nivo
from dimRadnici
WHERE Putanja.IsDescendantOf(@Hid)=1 
order by 5


GO
