SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvAODug] @UserID int, @BrojDana int
as

select * 
INTO #t
from dbo.fSviPodredjeni(@UserID)

select o.OjName, b.SifraZastupnika Manager, b.Naziv ManagerNaziv, a.SifraZastupnika Zastupnik, a.Naziv ZastupnikNaziv, c.dug, a.AOLimit, a.dimRadnik
from dimRadnici a INNER JOIN dimRadnici b on a.Putanja.GetAncestor(1)=b.Putanja
	INNER JOIN #t a0 on a.dimRadnik=a0.val
	INNER JOIN dimOj o on a.dimOjPripada=o.dimOj
	INNER JOIN
		(select b.dimRadnik, sum(a.Rata-a.Placeno) dug
		from factPropisi a inner join factPolise b on a.factPolisa=b.factPolisa
			INNER join dimProdukti c on b.dimProdukt=c.dimProdukt
			INNER join dimDatumi d2 on d2.DimDatum=b.DatumSklapanja
			INNER JOIN dimDatumi d1 on d1.DimDatum=a.DatDospeca
			inner join dimStatusi st on b.dimStatus=st.dimStatus
		where c.Produkt_ID=1010 and d1.Datum<=cast(dateadd(day,-@BrojDana,getdate()) as DATE)
			and d2.Datum>='20160101' and a.Rata-a.Placeno>0 and st.Status_ID!='S22'
		GROUP BY b.dimRadnik) c ON a.dimRadnik=c.dimRadnik
where c.dug>0.1*a.AOLimit
ORDER BY 1,2

GO
