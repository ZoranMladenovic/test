SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[napuni_factPropisi] 
as 


-- korekcija za pretplatu premije (Sanja Avramovic)
update SSIS_Propisane SET premija=0 WHERE Kod_ID in ('I03E','I09M','I09D')
--update SSIS_Propisane SET premija=-1 WHERE Kod_ID in ('I09E')

CREATE TABLE #factPropisi(
	[factPolisa] [int] NOT NULL,
	[DatOd] [int] NOT NULL,
	[DatDo] [int] NOT NULL,
	[DatDospeca] [int] NOT NULL,
	[Rata] [decimal](18, 2) NOT NULL,
	[Placeno] [decimal](18, 2) NOT NULL,
	[Predpis_ID] [bigint] NOT NULL,
	[Porez] [smallint] NULL,
	[DatUplate] [int] NULL,
	[VS] [varchar](15) NULL
) ON [PRIMARY]



DECLARE @Jedn int
select @Jedn=dimPeriodka from dimPeriodike where Perioda_id=0
 
INSERT #factPropisi(factPolisa, Predpis_ID, DatOd, DatDo, DatDospeca, rata, placeno,Porez, DatUplate, VS) 
select B.factPolisa, a.I02_Predpis_ID, 
	case when b.dimDinamika=@Jedn THEN b.VaziOd ELSE isnull(d1.DimDatum,1) END,  
	CASE WHEN b.dimDinamika=@Jedn THEN b.VaziDo ELSE isnull(d2.DimDatum,109573) END, 
	isnull(d3.DimDatum,109573), isnull(a.rata,0), isnull(a.Placeno,0),  
	case WHEN a.porez=-1 then -1 WHEN a.Premija=-1 then 0 when a.zk=-1 then -2 WHEN a.Kamata=-1 then -4 else -3 end Porez,  
	d4.DimDatum, CASE WHEN a.ZK=-1 THEN a.I02_VS END 
FROM SSIS_Propisane a INNER JOIN factPolise b ON a.Poistka_ID=b.Polisa  
	LEFT JOIN dimDatumi d1 ON a.I02_Od_dat=d1.Datum 
	LEFT JOIN dimDatumi d2 ON a.I02_Do_dat=d2.Datum 
	LEFT JOIN dimDatumi d3 ON a.DatumDospeca=d3.Datum 
	LEFT JOIN dimDatumi d4 ON a.I02_Platba_Dat=d4.Datum 
	left JOIN dimPodProdukti dpp ON dpp.Specijal=1 and b.dimPodProdukt=dpp.dimPodProdukt 
where dpp.dimPodProdukt is NULL and a.ZK<>-1 
 
-- ZK 
DECLARE  @zk int 
select @zk=dimPodProdukt from dimPodProdukti where Produkt_Id=1010 and PodProdukt_Id=99 
 
select left(I02_VS, len(I02_VS)-1) vs, *  
into #t1 
from SSIS_Propisane a  
where zk=-1 and ISNUMERIC(left(I02_VS, len(I02_VS)-1))=1 
 
INSERT #factPropisi(factPolisa, Predpis_ID, DatOd, DatDo, DatDospeca, rata, placeno,Porez, DatUplate, VS) 
select B.factPolisa, a.I02_Predpis_ID, 
	case when b.dimDinamika=@Jedn THEN b.VaziOd ELSE isnull(d1.DimDatum,1) END,  
	CASE WHEN b.dimDinamika=@Jedn THEN b.VaziDo ELSE isnull(d2.DimDatum,109573) END,
	--isnull(d1.DimDatum,1),  isnull(d2.DimDatum,109573), 
	isnull(d3.DimDatum,109573), isnull(a.rata,0), isnull(a.Placeno,0),  
	case WHEN a.porez=-1 then -1 WHEN a.Premija=-1 then 0 when a.zk=-1 then -2 WHEN a.Kamata=-1 then -4 else -3 end Porez,  
	d4.DimDatum, CASE WHEN a.ZK=-1 THEN a.I02_VS END 
FROM #t1 a INNER JOIN factPolise b ON a.Poistka_ID=b.Ponuda and a.vs=b.Polisa 
	LEFT JOIN dimDatumi d1 ON a.I02_Od_dat=d1.Datum 
	LEFT JOIN dimDatumi d2 ON a.I02_Do_dat=d2.Datum 
	LEFT JOIN dimDatumi d3 ON a.DatumDospeca=d3.Datum 
	LEFT JOIN dimDatumi d4 ON a.I02_Platba_Dat=d4.Datum 
where b.dimPodProdukt=@zk and a.ZK=-1 
 
DECLARE @pr int 
select @pr=max(dimProdukt) from dimProdukti where Produkt_ID=-5 
 
UPDATE a 
SET DatDospeca=DatOd 
from #factPropisi a inner JOIN factPolise b on a.factPolisa=b.factPolisa 
	INNER JOIN dimProdukti c on b.dimProdukt=c.dimProdukt 
WHERE c.Nadredjena=@pr and a.DatOd<>a.DatDospeca and a.Porez<>-4

truncate table factPropisi 

INSERT factPropisi(factPolisa,DatOd,DatDo,DatDospeca,Rata,Placeno,Predpis_ID,Porez,DatUplate,VS)
SELECT * from #factPropisi


drop TABLE #factPropisi
GO
