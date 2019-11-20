SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[izvPotencijalnoSporneZK1]
as
select I02_Od_dat, I02_VS, Poistka_ID  
from SSIS_Propisane 
WHERE zk=-1 and ISNUMERIC(left(I02_VS,len(I02_VS)-1))<>1
GO
