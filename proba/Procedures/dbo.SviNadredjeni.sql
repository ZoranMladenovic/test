SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[SviNadredjeni] @id int
as

select b.nivo, b.SifraZastupnika, b.Naziv, b.NazivRM
from dimRadnici a inner JOIN dimRadnici b ON a.Putanja.IsDescendantOf(b.Putanja)=1
WHERE a.dimRadnik=@id
order by 1 desc


GO
