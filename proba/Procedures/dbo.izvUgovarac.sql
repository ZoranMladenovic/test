SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[izvUgovarac] @dimUgovarac int
as
select a.Partner_ID, a.Naziv, a.RC_ICO, a.Drzava, a.PTT, a.Grad, a.Ulica, a.Broj, a.Mobilni, a.EMail, a.SMSEmailDozvoljen, a.Telefon, a.Fax,
	b.TipAdrese OTipAdrese, b.Stat_txt OStat_txt, b.PSC OPSC, b.PSC_txt OPSC_txt, b.Ulica OUlica, b.Dom_No ODom_No, b.Tel_No OTel_No, b.Fax_No OFax_No
from dimUgovaraci a left JOIN SSIS_OstaleAdrese b on a.Partner_ID=b.partner_id
where a.dimUgovarac=@dimUgovarac
order by b.TipAdrese
GO
