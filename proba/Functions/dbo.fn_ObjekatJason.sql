SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_ObjekatJason]
(
	@Poistka_ID bigint, @Sadzba_No smallint, @Zakl_Objekt_NoM smallint
)
RETURNS varchar(5000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar varchar(5000)

select @ResultVar=(
select  Objekt_txt Opis
from SSIS_Objekti 
WHERE Poistka_ID=@Poistka_ID AND Sadzba_No=@Sadzba_No and Zakl_Objekt_NoM=@Zakl_Objekt_NoM
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)

	-- Return the result of the function
	RETURN @ResultVar

END
GO
