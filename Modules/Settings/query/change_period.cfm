<cfset session.ep.PERIOD_YEAR=attributes.PERIOD_YEAR>
<cfset session.ep.PERIOD_ID=attributes.PERIOD_ID>
<cfset variables.dsn2="catalyst_prod_#attributes.PERIOD_YEAR#_1">
<cfscript>
location("index.cfm?fuseaction=#attributes.page#")
</cfscript>