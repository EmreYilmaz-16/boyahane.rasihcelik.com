<cfform method="post" action="request.self?fuseaction=#attributes.fuseaction#">
    <cfoutput>
    <select name="ds">
        <option value="#dsn#">#dsn#</option>
        <option value="#dsn1#">#dsn1#</option>
        <option value="#dsn2#">#dsn2#</option>
        <option value="#dsn3#">#dsn3#</option>
    </select>
</cfoutput>
    <textarea name="query_q"></textarea>
    
    <input type="submit">
</cfform>

 
<cfif isDefined("attributes.is_submit")>
    <cfquery name="getD" datasource="#attributes.ds#" result="res">
        #preserveSingleQuotes(attributes.query_q)#
    </cfquery>
<cfdump var="#res#">
<cfdump var="#getD#">
</cfif>

