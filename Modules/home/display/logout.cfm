<!----

<cfscript>
get_our_company_tmp     = createObject("component","cfc.settings");
</cfscript>

<cfdump  var="#get_our_company_tmp.changeSystemParams(1,2019)#">----->

<cfscript>
structClear(session);
location("index.cfm?fuseaction=");
</cfscript>
