

<cffunction name="add_stock_rows" returntype="string" output="false">
		<cfargument name="sr_dsn_type" type="string" default="#dsn2#">
        <cfargument name="sr_process_type" type="boolean" default="">
		<cfargument name="sr_main_process_type" default="">
		<cfargument name="sr_control_process_type" type="string" default="">
        <cfargument name="sr_stock_row_count" type="numeric">
        <cfargument name="sr_max_id" type="numeric" default="">
        <cfargument name="sr_department_id" type="numeric" default="">
        <cfargument name="sr_location_id" type="string" default="">
        <cfargument name="sr_process_date" type="string" default="">
        <cfargument name="sr_is_purchase_sales" type="boolean" default="1"><!--- 0 Alış 1 Satış --->
        <cfargument name="sr_product_id_list" type="string" default="">
        <cfargument name="sr_stock_id_list" type="string" default="">
        <cfargument name="sr_unit_list" type="string" default="">
        <cfargument name="sr_amount_list" type="string" default="">
        <cfargument name="sr_spec_id_list" type="string" default="">
        <cfargument name="sr_spec_main_id_list" type="string" default="">
        <cfargument name="sr_lot_no_list" type="string" default="">
        <cfargument name="sr_shelf_number_list" type="string" default="">
        <cfargument name="sr_manufact_code_list" type="string" default="">
        <cfargument name="sr_amount_other_list" type="string" default="">
        <cfargument name="sr_unit_other_list" type="string" default="">
        <cfargument name="sr_deliver_date_list" type="string" default="">
        <cfargument name="sr_paper_row_id_list" type="string" default="">
        <cfargument name="sr_width_list" type="string" default="">
        <cfargument name="sr_depth_list" type="string" default="">
        <cfargument name="sr_height_list" type="string" default="">
        <cfargument name="sr_wrk_row_id_list" type="string" default="">
        <cfargument name="sr_row_department_id" type="string" default="">
        <cfargument name="sr_row_location_id" type="string" default="">
		<cfargument name="is_company_related_action" default="0">
		<cfargument name="company_related_dsn" default="#new_dsn3#">
			<cfset arguments.sr_process_date_time = arguments.sr_process_date>
        <cfset arguments.sr_process_date = createdate(year(arguments.sr_process_date),month(arguments.sr_process_date),day(arguments.sr_process_date))>
	<cfif  len(arguments.sr_main_process_type) gt 0>
		<cfelse>
			<cfset arguments.sr_main_process_type = arguments.sr_process_type>
		</cfif>
       
	    
        <cfif arguments.is_company_related_action>
            <cfset new_dsn3 = arguments.company_related_dsn>
        <cfelse>
        	<cfset new_dsn3 = dsn3>
        </cfif>
	
</cffunction>
<cfabort>