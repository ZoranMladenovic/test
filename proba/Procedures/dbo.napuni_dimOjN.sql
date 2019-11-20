SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[napuni_dimOjN]
as
truncate table dimOj

insert ssis_OJ (Oj_ID, OJ_Naziv, Nadredjena_OJ_ID)
VALUES ('NN', 'Nepoznata OJ', 'WSO')

CREATE TABLE #ssis_OJ(
	[dimOJ] [int] IDENTITY(1,1) NOT NULL,
	[Oj_ID] [varchar](6) NULL,
	[OJ_Naziv] [varchar](40) NULL,
	[Nadredjena_OJ_ID] [varchar](10) NULL,
	[NadredjenaOJ] [int] NULL
) ON [PRIMARY]

insert #ssis_OJ(oj_id, Nadredjena_OJ_ID, OJ_Naziv)
select b.IDOrgJed, b.IDParent, b.Naziv from ssis_OJ a RIGHT JOIN SSIS_EKOJ b on a.Oj_ID=b.IDOrgJed 
UNION
select a.Oj_ID, a.Nadredjena_OJ_ID, a.OJ_Naziv from ssis_OJ a LEFT JOIN SSIS_EKOJ b on a.Oj_ID=b.IDOrgJed WHERE b.IDOrgJed is NULL
-------------
UPDATE a set Nadredjena_OJ_ID='NN' FROM #ssis_OJ a LEFT JOIN #ssis_OJ b ON a.Nadredjena_OJ_ID=b.Oj_ID WHERE b.dimOJ is NULL
UPDATE #ssis_OJ SET Nadredjena_OJ_ID='WSO' WHERE Oj_ID=Nadredjena_OJ_ID
UPDATE #ssis_OJ SET Nadredjena_OJ_ID = NULL WHERE Oj_ID='WSO'

UPDATE a
SET NadredjenaOJ=b.dimOJ
FROM #ssis_OJ a inner JOIN #ssis_OJ b ON a.Nadredjena_OJ_ID=b.Oj_ID


CREATE TABLE #Children   
   (  
    EID int,  
    MID int,  
    Num int  
	)


INSERT #Children(EID,MID,NUM)
select DIMOJ,NadredjenaOJ,
  ROW_NUMBER() OVER (PARTITION BY NadredjenaOJ ORDER BY NadredjenaOJ)   
from #ssis_OJ;


WITH paths(path, EID)   
AS (  
SELECT hierarchyid::GetRoot() AS OrgNode, EID   
FROM #Children AS C   
WHERE MID IS NULL   

UNION ALL   
SELECT   
CAST(p.path.ToString() + CAST(C.Num AS varchar(30)) + '/' AS hierarchyid),   
C.EID  
FROM #Children AS C   
JOIN paths AS p   
   ON C.MID = P.EID   
) 
INSERT dimOj (OjNode,dimOj,OJ_ID,OjName, Nivo)  
SELECT P.path, o.dimOJ, o.OJ_ID, o.OJ_Naziv, path.GetLevel()
FROM #ssis_OJ AS O   
JOIN Paths AS P   
   ON O.dimOJ = P.eid
GO
