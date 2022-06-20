  <cffunction name="cfquery" returntype="any" output="false">
        <!--- 
            usage : my_query_name = cfquery(SQLString:required,Datasource:required(bos olabilir),dbtype:optional,is_select:optinal); 
            Select olmayan yerlerde is_select:false olarak verilmelidir
        --->
        <cfargument name="SQLString" type="string" required="true">
        <cfargument name="Datasource" type="string" required="true">
        <cfargument name="dbtype" type="string" required="no">
        <cfargument name="is_select" type="boolean" required="no" default="true">
        
        <cfif isdefined("arguments.dbtype") and len(arguments.dbtype)>
            <cfquery name="workcube_cf_query" dbtype="query">
                #preserveSingleQuotes(arguments.SQLString)#
            </cfquery>
        <cfelse>
            <cfquery name="workcube_cf_query" datasource="#arguments.Datasource#">
                #preserveSingleQuotes(arguments.SQLString)#
            </cfquery>
        </cfif>
        <cfif arguments.is_select>
            <cfreturn workcube_cf_query>
        <cfelse>
            <cfreturn true>
        </cfif>
    </cffunction>  
<cfquery name="getOrderRow" datasource="#dsn#">
    SELECT PRODUCT_NAME,ORDER_ID,QUANTITY FROM catalyst_prod_1.ORDER_ROW WHERE ORDER_ROW_ID=#attributes.order_row_id#
</cfquery>
<cfset attributes.order_id=getOrderRow.ORDER_ID>
<cfset attributes.QUANTITY=getOrderRow.QUANTITY>
<cfinclude  template="add_work_include.cfm">
<cfinclude  template="add_production_order_all_sub.cfm">