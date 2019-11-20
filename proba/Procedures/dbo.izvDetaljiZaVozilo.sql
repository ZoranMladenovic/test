SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvDetaljiZaVozilo] @dimObjekat int
as
select vRegBroj, vBrojSasije, vMarka, 
	json_value([ObjekatJS],'$.BrojMotora') BrojMotora,
	json_value([ObjekatJS],'$.Model') Model,
	json_value([ObjekatJS],'$.BrojSedista') BrojSedista,
	json_value([ObjekatJS],'$.Zapremina') Zapremina,
	json_value([ObjekatJS],'$.Snaga') Snaga,
	json_value([ObjekatJS],'$.Kategorija') Kategorija,
	json_value([ObjekatJS],'$.Nosivost') Nosivost,
	json_value([ObjekatJS],'$.GodinProizvodnje') GodinProizvodnje,
	json_value([ObjekatJS],'$.Gorivo') Gorivo,
	json_value([ObjekatJS],'$.Farba') Boja
from dimObjekti 
WHERE dimObjekat=@dimObjekat

GO
