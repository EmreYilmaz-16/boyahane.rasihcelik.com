<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <cfoutput>

</cfoutput>
    <textarea name="query_q"></textarea>
    <input type="hidden" name="is_submit">
    <input type="submit">
</cfform>

 
<cfif isDefined("attributes.is_submit")>
    <cfquery name="getD" datasource="#dsn#" result="res">
        #preserveSingleQuotes(attributes.query_q)#
    </cfquery>
<cfdump var="#res#">
<cfdump var="#getD#">
</cfif>

