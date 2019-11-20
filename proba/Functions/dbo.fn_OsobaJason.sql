SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_OsobaJason]
(

	@Partner_ID bigint,@poistka_id bigint
)
RETURNS varchar(5000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar varchar(5000)

select @ResultVar=(
select  RC_ICO MB, naziv
from SSIS_OOsobe 
WHERE Partner_ID=@Partner_ID AND poistka_id=@poistka_id
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)

	-- Return the result of the function
	RETURN @ResultVar

END
GO
