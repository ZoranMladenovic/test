SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[StringToTable]   
 (@separator varchar(10), @string varchar(5000))  
RETURNS @expl_tbl TABLE   
 (val varchar(2000))  
AS  
BEGIN  
 if (charindex(@separator, @string) = 0) and (ltrim(rtrim(@string)) <> '')  
  insert into @expl_tbl values(ltrim(rtrim(@string)))  
 else  
 begin  
  while charindex(@separator, @string) > 0  
  begin  
   if (ltrim(rtrim(left(@string, charindex(@separator, @string) - 1))) <> '')  
    insert into @expl_tbl values(ltrim(rtrim(left(@string, charindex(@separator, @string) - 1))))  
   set @string = substring(@string, charindex(@separator, @string) + len(@separator), len(@string) - charindex(@separator, @string))  
  end  
  if ltrim(rtrim(@string)) <> ''  
   insert into @expl_tbl values(ltrim(rtrim(@string)))  
 end  
 RETURN   
END  




GO
