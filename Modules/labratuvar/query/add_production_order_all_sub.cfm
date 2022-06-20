﻿
<cfset dsn3="#dsn#_1">
	<cfif isDefined("attributes.is_multi") and Len(attributes.is_multi)>
	<cfloop collection="#attributes#" item="xx">
		<cfset yeniAtt = Replace(xx,'MULTI_','')>
		<cfset "attributes.#yeniAtt#" = Evaluate("attributes.#xx#")>
	</cfloop>
</cfif>
<cfif not isdefined("is_import_prod")>
	<table border="1">
	<tr>
		<td><cfif attributes.is_demand eq 1>Talepler<cfelse>Üretim Emirleri</cfif> Oluşturuluyor..Lütfen Bekleyiniz...</td>
	</tr>
	<cfflush interval="1000">
</cfif>
<cfset new_keyword_ = "">
<cfif isdefined("attributes.is_manuel")>
	<cfquery name="GET_W" datasource="#dsn3#">
		SELECT 
			STATION_ID,
			STATION_NAME,
			ISNULL(EXIT_DEP_ID,0) AS EXIT_DEP_ID,
			ISNULL(EXIT_LOC_ID,0) AS EXIT_LOC_ID,
			ISNULL(PRODUCTION_DEP_ID,0) AS PRODUCTION_DEP_ID,
			ISNULL(PRODUCTION_LOC_ID,0) AS PRODUCTION_LOC_ID
		FROM 
			WORKSTATIONS 
		ORDER BY 
			STATION_NAME ASC
	</cfquery>
	<cfloop query="GET_W">
		<cfset 'EXIT_DEP_ID_#STATION_ID#' = EXIT_DEP_ID>
		<cfset 'EXIT_LOC_ID_#STATION_ID#' = EXIT_LOC_ID>
		<cfset 'PRODUCTION_DEP_ID_#STATION_ID#' = PRODUCTION_DEP_ID>
		<cfset 'PRODUCTION_LOC_ID_#STATION_ID#' = PRODUCTION_LOC_ID>
	</cfloop>
	<cfscript>
		GET_AMOUNT = QueryNew("ORDER_NUMBER,ORDER_DETAIL,SPEC_MAIN_ID,SPECT_VAR_ID,DELIVER_DATE,STOCK_ID,PRODUCT_NAME,IS_PROTOTYPE,ORDER_ROW_ID,ORDER_ID,PROJECT_ID,KONTROL_ORDER,ROW_NO,WRK_ROW_RELATION_ID","VarChar,VarChar,integer,integer,Date,integer,VarChar,integer,integer,integer,integer,integer,integer,VarChar");
		row_of_query = 0;
		attributes.ORDER_ROW_ID = '';
		attributes.ORDER_ROW_ID_LIST = '';
		attributes.STATION_ID_LIST = '';
		attributes.production_amount_list = '';
		attributes.WORKS_PROG_ID_LIST = '';
		attributes.PRODUCTION_START_DATE_LIST = '';
		attributes.PRODUCTION_START_H_LIST = '';
		attributes.PRODUCTION_START_M_LIST = '';
		attributes.PRODUCTION_FINISH_DATE_LIST = '';
		attributes.PRODUCTION_FINISH_H_LIST = '';
		attributes.PRODUCTION_FINISH_M_LIST = '';
		attributes.DEMAND_NO_LIST = '';
		attributes.WRK_ROW_RELATION_ID_LIST = '';
	</cfscript>
	<cfloop from="1" to="#attributes.record_num#" index="kk">
		<cfif evaluate("attributes.row_kontrol#kk#")>
			 <cfscript>
			 	if(not isdefined("attributes.demand_no#kk#")) "attributes.demand_no#kk#" = '';
			 	if(not isdefined("attributes.wrk_row_relation_id#kk#")) "attributes.wrk_row_relation_id#kk#" = '';
			 	if(len(evaluate("attributes.order_row_id#kk#")))
				{
					row_order_id = evaluate("attributes.order_row_id#kk#");
					order_id = evaluate("attributes.order_id#kk#");
					kontrol_order = 1;
				}
				else
				{
					row_order_id = kk;
					order_id = kk;
					kontrol_order = 0;
				}
			 	row_of_query = row_of_query + 1;
			 	attributes.ORDER_ROW_ID = ListAppend(attributes.ORDER_ROW_ID,row_order_id,',');
			 	attributes.ORDER_ROW_ID_LIST = ListAppend(attributes.ORDER_ROW_ID_LIST,"#row_order_id##kk#",',');
				if(not (isdefined("attributes.station_id_#kk#_0") and len(evaluate("attributes.station_id_#kk#_0"))))
				{
					"attributes.station_id_#kk#_0" = 0;
				}
				if(evaluate("attributes.station_id_#kk#_0") neq 0)
				{
					exit_dep_id = Evaluate('EXIT_DEP_ID_#evaluate("attributes.station_id_#kk#_0")#');
					exit_loc_id = Evaluate('EXIT_LOC_ID_#evaluate("attributes.station_id_#kk#_0")#');
					production_dep_id = Evaluate('PRODUCTION_DEP_ID_#evaluate("attributes.station_id_#kk#_0")#');
					production_loc_id = Evaluate('PRODUCTION_LOC_ID_#evaluate("attributes.station_id_#kk#_0")#');
				}
				else
				{
					exit_dep_id = 0;
					exit_loc_id = 0;
					production_dep_id = 0;
					production_loc_id = 0;
				}	
				attributes.STATION_ID_LIST = ListAppend(attributes.STATION_ID_LIST,"#evaluate("attributes.station_id_#kk#_0")#,0,0,0,-1,#exit_dep_id#,#exit_loc_id#,#production_dep_id#,#production_loc_id#",'@');
				attributes.production_amount_list = ListAppend(attributes.production_amount_list,evaluate("attributes.quantity#kk#"),',');
				attributes.WORKS_PROG_ID_LIST = ListAppend(attributes.WORKS_PROG_ID_LIST,0,',');
				attributes.PRODUCTION_START_DATE_LIST = ListAppend(attributes.PRODUCTION_START_DATE_LIST,evaluate("attributes.start_date#kk#"),',');
				attributes.PRODUCTION_START_H_LIST = ListAppend(attributes.PRODUCTION_START_H_LIST,evaluate("attributes.start_h#kk#"),',');
				attributes.PRODUCTION_START_M_LIST = ListAppend(attributes.PRODUCTION_START_M_LIST,evaluate("attributes.start_m#kk#"),',');
				attributes.PRODUCTION_FINISH_DATE_LIST = ListAppend(attributes.PRODUCTION_FINISH_DATE_LIST,evaluate("attributes.finish_date#kk#"),',');
				attributes.PRODUCTION_FINISH_H_LIST = ListAppend(attributes.PRODUCTION_FINISH_H_LIST,evaluate("attributes.finish_h#kk#"),',');
				attributes.PRODUCTION_FINISH_M_LIST = ListAppend(attributes.PRODUCTION_FINISH_M_LIST,evaluate("attributes.finish_m#kk#"),',');
				attributes.DEMAND_NO_LIST = ListAppend(attributes.DEMAND_NO_LIST,evaluate("attributes.demand_no#kk#"),',');
				attributes.WRK_ROW_RELATION_ID_LIST = ListAppend(attributes.WRK_ROW_RELATION_ID_LIST,evaluate("attributes.wrk_row_relation_id#kk#"),',');
				QueryAddRow(GET_AMOUNT,1);
				QuerySetCell(GET_AMOUNT,"ORDER_NUMBER","",row_of_query);
				QuerySetCell(GET_AMOUNT,"ORDER_DETAIL","",row_of_query);
				QuerySetCell(GET_AMOUNT,"SPEC_MAIN_ID","#evaluate("attributes.spect_main_id#kk#")#",row_of_query);
				QuerySetCell(GET_AMOUNT,"SPECT_VAR_ID","#evaluate("attributes.spect_var_id#kk#")#",row_of_query);
				QuerySetCell(GET_AMOUNT,"DELIVER_DATE","#evaluate("attributes.finish_date#kk#")#",row_of_query);
				QuerySetCell(GET_AMOUNT,"STOCK_ID","#evaluate("attributes.stock_id#kk#")#",row_of_query);
				QuerySetCell(GET_AMOUNT,"PRODUCT_NAME","#evaluate("attributes.product_name#kk#")#",row_of_query);
				QuerySetCell(GET_AMOUNT,"IS_PROTOTYPE","",row_of_query);
				QuerySetCell(GET_AMOUNT,"ORDER_ROW_ID",row_order_id,row_of_query);
				QuerySetCell(GET_AMOUNT,"ORDER_ID",order_id,row_of_query);
				QuerySetCell(GET_AMOUNT,"PROJECT_ID",attributes.project_id,row_of_query);
				QuerySetCell(GET_AMOUNT,"KONTROL_ORDER",kontrol_order,row_of_query);
				QuerySetCell(GET_AMOUNT,"ROW_NO",kk,row_of_query);
				QuerySetCell(GET_AMOUNT,"WRK_ROW_RELATION_ID","#evaluate("attributes.wrk_row_relation_id#kk#")#",row_of_query);
			</cfscript>
		</cfif>
	</cfloop>
<cfelse>
	<cfif isDefined("attributes.is_multi") and Len(attributes.is_multi)>
		<cfset Main_Table = "GET_AMOUNT_MAIN">
	<cfelse>
		<cfset Main_Table = "GET_AMOUNT">
	</cfif>
	<cfquery name="#Main_Table#" datasource="#DSN3#">
		SELECT
			ORDERS.ORDER_NUMBER,
			ORDERS.ORDER_DETAIL,
			(SELECT SPECT_MAIN_ID FROM SPECTS WHERE SPECTS.SPECT_VAR_ID = ORDER_ROW.SPECT_VAR_ID) AS SPEC_MAIN_ID,
			ORDER_ROW.SPECT_VAR_ID,
			ORDERS.DELIVERDATE AS DELIVER_DATE,
			ORDER_ROW.STOCK_ID,
			STOCKS.PRODUCT_NAME,
			STOCKS.IS_PROTOTYPE,
			ORDER_ROW.ORDER_ROW_ID,
			ORDER_ROW.ORDER_ID,
			ORDERS.PROJECT_ID,
			1 AS KONTROL_ORDER,
			WRK_ROW_ID WRK_ROW_RELATION_ID
		FROM
			ORDER_ROW,
			ORDERS,
			STOCKS
		WHERE 
			ORDER_ROW.ORDER_ROW_ID IN(#attributes.order_row_id#)AND
			ORDER_ROW.ORDER_ID = ORDERS.ORDER_ID AND
			STOCKS.STOCK_ID = ORDER_ROW.STOCK_ID AND 
			ORDER_ROW.SPECT_VAR_ID IS NOT NULL
	</cfquery>
</cfif>


<cfif isDefined("attributes.is_multi") and Len(attributes.is_multi)>
	<cfquery name="GET_AMOUNT" dbtype="query">
		SELECT STOCK_ID,SPEC_MAIN_ID FROM GET_AMOUNT_MAIN GROUP BY STOCK_ID,SPEC_MAIN_ID
	</cfquery>
</cfif>

<cf_papers paper_type="production_lot">
<cfscript>
	if(attributes.is_demand eq 1){
		attributes.stock_reserved = 0;
		attributes.is_stage = -1;
	}	
	else{
		attributes.stock_reserved = 1;
		attributes.is_stage = '4';
	}
	attributes.is_demontaj = 0;
	attributes.lot_no = paper_number;
	attributes.total_production_product = 0;
	if(isdefined("attributes.is_add_multi_demand") and attributes.is_add_multi_demand eq 1)
		attributes.total_production_product_all = 2;
	else
		attributes.total_production_product_all = GET_AMOUNT.recordcount;
</cfscript>

<cfif GET_AMOUNT.recordcount>
	<cfset prod_ind = 0>
	<cfloop query="GET_AMOUNT">
		<cfif isDefined("attributes.is_multi") and Len(attributes.is_multi)>
			<cfquery name="get_amount_info" dbtype="query">
				SELECT * FROM GET_AMOUNT_MAIN WHERE STOCK_ID = #GET_AMOUNT.STOCK_ID# <cfif Len(GET_AMOUNT.SPEC_MAIN_ID)>AND SPEC_MAIN_ID = #GET_AMOUNT.SPEC_MAIN_ID#</cfif>
			</cfquery>
			<cfset kontrol_order = 1>
			<cfset _ORDER_NUMBER_ = ValueList(get_amount_info.ORDER_NUMBER)>
			<cfif ListLen(ValueList(get_amount_info.SPECT_VAR_ID))>
				<cfset _spec_var_id_ = ValueList(get_amount_info.SPECT_VAR_ID)>
			<cfelse>
				<cfset _spec_var_id_ = 0>	
			</cfif>
		<cfelse>
			<cfset _ORDER_NUMBER_ = ORDER_NUMBER>
			<cfif len(SPECT_VAR_ID)>
				<cfset _spec_var_id_ = SPECT_VAR_ID>
			<cfelse>
				<cfset _spec_var_id_ = 0>	
			</cfif>
		</cfif>
		<cfset _spec_main_id_ = SPEC_MAIN_ID>
		<cfset _stock_id_ = STOCK_ID>

		<cfif not len(_spec_main_id_)>
			<cfquery name="get_product_main_spec_default" datasource="#dsn3#"><!--- Ürün Ağacından En Son Varyasyonlanan yani kaydedilen SPECT_MAIN_ID'yi getiriyor. --->
				SELECT TOP 1 SPECT_MAIN_ID FROM SPECT_MAIN SM WHERE SM.STOCK_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#_stock_id_#"> AND SM.IS_TREE = 1 ORDER BY SM.RECORD_DATE DESC,SM.UPDATE_DATE DESC
			</cfquery>
			<cfif get_product_main_spec_default.recordcount>
				<cfset _spec_main_id_ = get_product_main_spec_default.SPECT_MAIN_ID>
				<cfset _spec_var_id_ = 0>
			</cfif>
		</cfif>
		<cfscript>
			if(isdefined("GET_AMOUNT.row_no"))
				prod_ind2 = row_no;
			else
				prod_ind2 = currentrow;
			
			if(isDefined("attributes.is_multi") and Len(attributes.is_multi))
			{
				_project_id_ = ListDeleteDuplicates(ValueList(get_amount_info.PROJECT_ID));
				_order_id_ = ValueList(get_amount_info.ORDER_ID);
				_order_row_id_ = ValueList(get_amount_info.ORDER_ROW_ID);
				list_line = prod_ind2;
			}
			else
			{
			_project_id_ = PROJECT_ID;
			_order_id_ = GET_AMOUNT.ORDER_ID;
			_order_row_id_ = GET_AMOUNT.ORDER_ROW_ID;
			if(isdefined("attributes.ORDER_ROW_ID_LIST"))
				list_line = ListFind(attributes.ORDER_ROW_ID_LIST,"#_order_row_id_##prod_ind2#",',');
			else
				list_line = ListFind(attributes.ORDER_ROW_ID,"#_order_row_id_#",',');

			}
			// list_line = ListFind(attributes.ORDER_ROW_ID,_order_row_id_,',');//listeden gelen değerlere göre sıralama yapıcaz...
			
			if(ListLen(attributes.station_id_list,'@') and ListLen(ListGetAt(attributes.station_id_list,list_line,'@')))
				station_info =ListGetAt(attributes.station_id_list,list_line,'@');
			else
				station_info ='0,0,0,0,0,0,0,0,0';
			if(isdefined("attributes.is_add_multi_demand") and attributes.is_add_multi_demand eq 1)
			{
				control_link = 1;
				loop_count = ListGetAt(attributes.production_amount_list,list_line,',');
				row_amount = 1;
			}
			else
			{
				loop_count = 1;
				row_amount = ListGetAt(attributes.production_amount_list,list_line,',');
			}
		</cfscript>
		<cfif isdefined("_spec_main_id_") and len(_spec_main_id_)>
			<cfloop from="1" to="#loop_count#" index="ii_indx">
				<cfscript>
					attributes.total_production_product = attributes.total_production_product + 1;
					prod_ind = prod_ind + 1;
					'attributes.station_id_#prod_ind#_0' = "#ListGetAt(station_info,1,',')#,0,0,0,-1,#ListGetAt(station_info,6,',')#,#ListGetAt(station_info,7,',')#,#ListGetAt(station_info,8,',')#,#ListGetAt(station_info,9,',')#";
					"attributes.product_amount_#prod_ind#_0" = row_amount;
					"attributes.product_values_#prod_ind#_0" = "#STOCK_ID#,#_spec_var_id_#,0,0,#_spec_main_id_#";
					attributes.order_amount = row_amount;
					production_row_count = 0;
					if((isdefined("attributes.stage_info") and len(attributes.stage_info) and attributes.stage_info gt 0) or not (isdefined("attributes.stage_info") and len(attributes.stage_info)))
						writeTree(_spec_main_id_,0,0,0);
					if(listlen(attributes.WORKS_PROG_ID_LIST) gte list_line)
						"attributes.works_prog_#prod_ind#" = ListGetAt(attributes.WORKS_PROG_ID_LIST,list_line,',');
					else
						"attributes.works_prog_#prod_ind#" = 1;
					"attributes.order_row_id_#prod_ind#" =_order_row_id_;
					"attributes.order_id_#prod_ind#" =_order_id_;
					"attributes.kontrol_order_#prod_ind#" =kontrol_order;
					"attributes.production_type_#prod_ind#" =0;
					if(len(ListGetAt(attributes.production_start_date_list,list_line,',')))
						"attributes.start_date_#prod_ind#" = ListGetAt(attributes.production_start_date_list,list_line,',');
					else
						"attributes.start_date_#prod_ind#" ="";
					"attributes.start_h_#prod_ind#" = ListGetAt(attributes.production_start_h_list,list_line,',');
					"attributes.start_m_#prod_ind#" = ListGetAt(attributes.production_start_m_list,list_line,',');
					
					if(isdefined("attributes.production_finish_date_list"))
					{
						if(len(ListGetAt(attributes.production_finish_date_list,list_line,',')))
							"attributes.deliver_date_#prod_ind#" = ListGetAt(attributes.production_finish_date_list,list_line,',');
						else
							"attributes.deliver_date_#prod_ind#" = "";
						"attributes.finish_h_#prod_ind#" =ListGetAt(attributes.production_finish_h_list,list_line,',');
						"attributes.finish_m_#prod_ind#" = ListGetAt(attributes.production_finish_m_list,list_line,',');
					}
					else
					{
						if(len(ListGetAt(attributes.production_start_date_list,list_line,',')))
							"attributes.deliver_date_#prod_ind#" = ListGetAt(attributes.production_start_date_list,list_line,',');
						else
							"attributes.deliver_date_#prod_ind#" = "";
						"attributes.finish_h_#prod_ind#" =ListGetAt(attributes.production_start_h_list,list_line,',');
						"attributes.finish_m_#prod_ind#" = ListGetAt(attributes.production_start_m_list,list_line,',');
					}
					
					if(isdefined("attributes.demand_no_list") and len(attributes.demand_no_list))
					{
						if(len(ListGetAt(attributes.demand_no_list,list_line,',')))
							"attributes.demand_no_#prod_ind#" = ListGetAt(attributes.demand_no_list,list_line,',');
						else
							"attributes.demand_no_#prod_ind#" = "";
					}
					if(isdefined("attributes.WRK_ROW_RELATION_ID_LIST") and len(attributes.WRK_ROW_RELATION_ID_LIST))
					{
						if(len(ListGetAt(attributes.WRK_ROW_RELATION_ID_LIST,list_line,',')))
							"attributes.wrk_row_relation_id_#prod_ind#" = ListGetAt(attributes.WRK_ROW_RELATION_ID_LIST,list_line,',');
						else
							"attributes.wrk_row_relation_id_#prod_ind#" = "";
					}
					"attributes.project_id_#prod_ind#" =_project_id_;
					if(isdefined("attributes.is_time_calculation"))
						"attributes.is_time_calculation_#prod_ind#" = attributes.is_time_calculation;
					else
						"attributes.is_time_calculation_#prod_ind#" = 0 ;
					"attributes.is_operator_display_#prod_ind#" = 0 ;
					"attributes.production_row_count_#prod_ind#" = production_row_count ;
					"attributes.xml_is_order_row_deliver_date_update_#prod_ind#" = 1;
					if(isdefined("attributes.is_line_number"))
						"attributes.is_line_number_#prod_ind#" = attributes.is_line_number;
					else
						"attributes.is_line_number_#prod_ind#" = 0 ;
				</cfscript>
				<cfinclude template="add_production_ordel_all.cfm">
			</cfloop>
		</cfif>
	</cfloop>
<cfelse>
	<script type="text/javascript">
		alert("<cf_get_lang dictionary_id='61268.Sipariş Satırlarında Spec Seçilmemiş Kayıtlar Mevcut , Lütfen Siparişi Kontrol Ediniz !'>");
		window.location.href='<cfoutput>#cgi.referer#</cfoutput>';
	</script>
</cfif>
<cfif not isdefined("is_import_prod")>
</table>
</cfif>

