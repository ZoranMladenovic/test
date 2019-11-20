SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_VoziloJason]
(

	@Spe_ID bigint,@poistka_id bigint
)
RETURNS varchar(5000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar varchar(5000)

select @ResultVar=(
select RegBroj, BrojSasije, motor_id as BrojMotora, Marka, Model, Broj_Putnika as BrojPutnika, Broj_Sedista as BrojSedista, Broj_Mjesta as BrojMesta
from SSIS_Vozila 
WHERE Spe_ID=@Spe_ID AND poistka_id=@poistka_id
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)

	-- Return the result of the function
	RETURN @ResultVar

END
GO
