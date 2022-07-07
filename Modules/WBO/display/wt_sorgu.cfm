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


<table class="table">
    <cfoutput>
    <tr>
        <cfloop list="#res.COLUMNLIST#" item="i">
            <td>
                #i#     
            </td>
        </cfloop>
    </tr>
    <cfloop query="getD">
        <tr>
            <cfloop list="#res.COLUMNLIST#" item="i">
               <td> #evaluate(i)#</td>
            </cfloop>
        </tr>
    </cfloop>
</cfoutput>
</table>
</cfif>