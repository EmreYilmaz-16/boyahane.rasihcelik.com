Buraya Geldim Mi Acep
<cfif isDefined("session.ep.company_id") and attributes.active_period neq session.ep.period_id>
	<!--- 20050302 sadece donem kontrolu gereken yerlerde kullanilacak --->
	<script type="text/javascript">
		alert("İşlem Yapmak İstediğiniz Muhasebe Dönemi ile Aktif Muhasebe Döneminiz Farklı Muhasebe Döneminizi Kontrol Ediniz!");
	//	window.location.href='<cfoutput>#request.self#?fuseaction=#listgetat(attributes.fuseaction,1,'.')#.welcome</cfoutput>';
	</script>
	<cfabort>
</cfif>
