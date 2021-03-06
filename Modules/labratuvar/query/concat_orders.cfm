<cfdump  var="#attributes#">
<cfquery name="getStations" datasource="#dsn#">
SELECT (CONVERT(VARCHAR, STATION_ID) + ',0,0,0,-1,' + CONVERT(VARCHAR, EXIT_DEP_ID) + ',' + CONVERT(VARCHAR, EXIT_LOC_ID) + ',' + CONVERT(VARCHAR, PRODUCTION_DEP_ID) + ',' + CONVERT(VARCHAR, PRODUCTION_LOC_ID)) AS STATION_ID_LIST
	,STATION_NAME,WIDTH,LENGTH
FROM catalyst_prod_1.WORKSTATIONS
WHERE STATION_ID =#attributes.station_id#
</cfquery>
<cfset attributes.STATION_ID_LIST=getStations.STATION_ID_LIST>
<cfset attributes.STATION_ID_1_0=getStations.STATION_ID_LIST>
<cfset AmountN=0>
<cfset stk_buyuk=0>
<cfset last_am=0>

<cfloop list="#attributes.p_order_id#" item="item">
    <cfset "attributes.Gev_#item#"=copyOrders(item)>
    <cfset AmountN=AmountN+evaluate("attributes.Amount#item#")>
    <cfset new_am=evaluate("attributes.Amount#item#")>
    <cfif new_am gt last_am >
        <cfset last_am=new_am>
        <cfset stk_buyuk=evaluate("attributes.StockId#item#")>
    </cfif>
    
</cfloop>

<cfquery NAME="UPPOPS" DATASOURCE="#DSN3#">
update PRODUCTION_ORDERS set STATUS=0 WHERE P_ORDER_ID IN(#attributes.p_order_id#)
</cfquery>

<cfdump  var="#last_am#">
<cfdump  var="#stk_buyuk#">
<cfquery name="getSm" datasource="#dsn3#">
    SELECT SPECT_MAIN_ID,STOCK_ID FROM SPECT_MAIN WHERE STOCK_ID=#stk_buyuk#
</cfquery>
<cfdump  var="#getSm#">

<cfdump  var="#AmountN#">
<cfquery NAME="GETWSt" DATASOURCE="#DSN3#">
    SELECT SUM(O_MINUTE) AS TS FROM catalyst_prod_1.OPERATION_TYPES 
        WHERE OPERATION_TYPE_ID IN(
                SELECT OPERATION_TYPE_ID 
                    FROM catalyst_prod_1.PRODUCT_TREE 
                    WHERE STOCK_ID IN (
                        SELECT STOCK_ID 
                        FROM catalyst_prod_1.PRODUCTION_ORDERS 
                        WHERE P_ORDER_ID IN (
                            #attributes.p_order_id#
                            )
                        )
                    )
</cfquery>
<cfset df=dateAdd("n", GETWSt.TS+180 , now())>
<cfset ds=dateAdd("n", 180 , now())>
<br>
<cfdump  var="#df#"><br>
<cfdump  var="#ds#"><br>
<cfdump  var="#GETWSt#">

<cfdump  var="#attributes#">
<cfquery name="getLot" datasource="#dsn3#">
    select PRODUCTION_LOT_NO,PRODUCTION_LOT_NUMBER from GENERAL_PAPERS WHERE PRODUCTION_LOT_NUMBER IS NOT NULL
</cfquery>
            
            <cfset attributes.DETAIL="">
            <cfset attributes.ORDER_ID_1="">
            <cfset attributes.ORDER_ROW_ID_1="">
            <cfset attributes.IS_LINE_NUMBER_1="0">
            <cfset attributes.IS_OPERATOR_DISPLAY_1="1">
            <cfset attributes.PRODUCTION_ROW_COUNT_1="0">
            <cfset attributes.STOCK_RESERVED="1">
            <cfset attributes.SHOW_LOT_NO_COUNTER="0">
            <cfset attributes.PRODUCT_AMOUNT_1_0="#AmountN#">
            <cfset attributes.IS_STAGE="4">
            <cfset attributes.PROJECT_ID_1="">
            <cfset attributes.PROCESS_STAGE="59">
            <cfset attributes.IS_TIME_CALCULATION_1="0">
            <cfset attributes.LOT_NO="#getLot.PRODUCTION_LOT_NO#-#getLot.PRODUCTION_LOT_NUMBER+1#">
            <cfset attributes.FINISH_DATE_1=df>
            <cfset attributes.DELIVER_DATE_1_0=df>
            <cfset attributes.DELIVER_DATE=df>
            <cfset attributes.START_DATE_1=ds>
            <cfset attributes.START_DATE=ds>
            <cfset attributes.deliver_date=df>
            <cfset attributes.deliver_date=df>
            <cfset attributes.PRODUCT_VALUES_1_0="#getSm.STOCK_ID#,0,0,0,#getSm.SPECT_MAIN_ID#">
<cfset attributes.FINISH_H_1="#hour(attributes.FINISH_DATE_1)#">
<cfset attributes.FINISH_M_1="#minute(attributes.FINISH_DATE_1)#">
<cfset attributes.START_H_1="#hour(attributes.START_DATE_1)#">
<cfset attributes.START_M_1="#minute(attributes.START_DATE_1)#">
 <cfset attributes.DELIVER_DATE_1=attributes.FINISH_DATE_1>
<cfdump  var="#attributes#">
<cfinclude  template="/Modules/labratuvar/query/add_production_ordel_all.cfm">

<cffunction name="copyOrders">
<cfargument  name="p_order_id">
<cfquery name="Copy" datasource="#dsn3#" result="copyResult">
INSERT INTO catalyst_prod_1.BIRLESEN_EMIR (OLD_P_ORDER_ID, NEW_P_ORDER_ID, STOCK_ID, DP_ORDER_ID, ORDER_ID, STATION_ID, START_DATE, FINISH_DATE, QUANTITY, STATUS_ID, STATUS, PROJECT_ID, P_ORDER_NO, PO_RELATED_ID, 
                         ORDER_ROW_ID, SPECT_VAR_ID, SPECT_VAR_NAME, DETAIL, PROD_ORDER_STAGE, IS_STOCK_RESERVED, PRINT_COUNT, IS_DEMONTAJ, LOT_NO, REFERENCE_NO, PRODUCTION_LEVEL, SPEC_MAIN_ID, 
                         PRODUCT_NAME2, IS_GROUP_LOT, IS_STAGE, WRK_ROW_ID, EXIT_DEP_ID, EXIT_LOC_ID, DEMAND_NO, PRODUCTION_DEP_ID, PRODUCTION_LOC_ID, RECORD_IP, RECORD_EMP, RECORD_DATE, UPDATE_EMP, 
                         UPDATE_DATE, UPDATE_IP, WORK_ID, RESULT_AMOUNT, WRK_ROW_RELATION_ID, GROUP_LOT_NO, PARTY_ID, PARTNER_WORK_STAGE, IS_COLLECTED, IS_URGENT)
SELECT P_ORDER_ID AS OLD_P_ORDER_ID, 0 AS NEW_P_ORDER_ID, STOCK_ID, DP_ORDER_ID, ORDER_ID, STATION_ID, START_DATE, FINISH_DATE, QUANTITY, STATUS_ID, STATUS, PROJECT_ID, P_ORDER_NO, PO_RELATED_ID, 
                         ORDER_ROW_ID, SPECT_VAR_ID, SPECT_VAR_NAME, DETAIL, PROD_ORDER_STAGE, IS_STOCK_RESERVED, PRINT_COUNT, IS_DEMONTAJ, LOT_NO, REFERENCE_NO, PRODUCTION_LEVEL, SPEC_MAIN_ID, 
                         PRODUCT_NAME2, IS_GROUP_LOT, IS_STAGE, WRK_ROW_ID, EXIT_DEP_ID, EXIT_LOC_ID, DEMAND_NO, PRODUCTION_DEP_ID, PRODUCTION_LOC_ID, RECORD_IP, RECORD_EMP, RECORD_DATE, UPDATE_EMP, 
                         UPDATE_DATE, UPDATE_IP, WORK_ID, RESULT_AMOUNT, WRK_ROW_RELATION_ID, GROUP_LOT_NO, PARTY_ID, PARTNER_WORK_STAGE, IS_COLLECTED, IS_URGENT FROM catalyst_prod_1.PRODUCTION_ORDERS WHERE P_ORDER_ID=#ARGUMENTS.p_order_id#

</cfquery>

<cfreturn copyResult.GeneratedKey>

</cffunction>
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
	 <cffunction name="writeTree_order" returntype="void">
            <cfargument name="spect_main_id">
            <cfargument name="old_amount">
            <cfscript>
                var i = 1;
				var sub_products = get_subs_order(spect_main_id);
				for (i=1; i lte listlen(sub_products,'???'); i = i+1)
				{
					_next_amount_ = ListGetAt(ListGetAt(sub_products,i,'???'),1,'??');//alt+987 = ??? --//alt+789 = ??
					_next_spect_id_ = ListGetAt(ListGetAt(sub_products,i,'???'),2,'??');
					_next_stock_id_ = ListGetAt(ListGetAt(sub_products,i,'???'),3,'??');
					_next_line_number_ = ListGetAt(ListGetAt(sub_products,i,'???'),4,'??');
					phantom_spec_main_id_list = listappend(phantom_spec_main_id_list,_next_spect_id_,',');
					phantom_stock_id_list = listappend(phantom_stock_id_list,_next_stock_id_,',');
					phantom_line_number_list = listappend(phantom_line_number_list,_next_line_number_,',');
					if(_next_spect_id_ gt 0)
					{
						'multipler_#_next_spect_id_#' = _next_amount_*old_amount;
						writeTree_order(_next_spect_id_,_next_amount_*old_amount);
					}
				 }
            </cfscript>
        </cffunction>

	      <cffunction name="get_subs_operation" returntype="any">
            <cfargument name="next_stock_id">
            <cfargument name="next_spec_id">
            <cfargument name="next_product_tree_id">
            <cfargument name="type">
     		<cfscript>
				if(type eq 0) where_parameter = 'PT.STOCK_ID = #next_stock_id#'; else where_parameter = 'RELATED_PRODUCT_TREE_ID = #next_product_tree_id#';							
				SQLStr = "
						SELECT
							PRODUCT_TREE_ID,
							AMOUNT,
							ISNULL(SPECT_MAIN_ID,0) SPECT_MAIN_ID,
							ISNULL(RELATED_ID,0) STOCK_ID,
							ISNULL(PT.OPERATION_TYPE_ID,0) OPERATION_TYPE_ID
						FROM
							PRODUCT_TREE PT
						WHERE
							#where_parameter#
						ORDER BY LINE_NUMBER ASC
					";
				query1 = cfquery(SQLString : SQLStr, Datasource : dsn3);
				stock_id_ary='';
				'type_#attributes.deep_level_op#' = type;
				for (str_i=1; str_i lte query1.recordcount; str_i = str_i+1)
				{
					stock_id_ary=listappend(stock_id_ary,query1.PRODUCT_TREE_ID[str_i],'???');
					stock_id_ary=listappend(stock_id_ary,query1.SPECT_MAIN_ID[str_i],'??');
					stock_id_ary=listappend(stock_id_ary,query1.STOCK_ID[str_i],'??');
					stock_id_ary=listappend(stock_id_ary,query1.AMOUNT[str_i],'??');
					stock_id_ary=listappend(stock_id_ary,query1.OPERATION_TYPE_ID[str_i],'??');
					stock_id_ary=listappend(stock_id_ary,attributes.deep_level_op,'??');
				}
			 </cfscript>
             <cfreturn stock_id_ary>
        </cffunction>	
		 	<cffunction name="get_subs_order" returntype="any" >
            <cfargument name="spect_id">
            <cfscript>
                SQLStr = "
                        SELECT
                            AMOUNT,
                            ISNULL(RELATED_MAIN_SPECT_ID,0) RELATED_MAIN_SPECT_ID,
                            ISNULL(STOCK_ID,0) STOCK_ID,
                            ISNULL(LINE_NUMBER, 0) LINE_NUMBER
                        FROM 
                            SPECT_MAIN_ROW SM
                        WHERE
                            SPECT_MAIN_ID = #arguments.spect_id#
                            AND IS_PHANTOM = 1
                    ";
                query1 = cfquery(SQLString : SQLStr, Datasource : dsn3);
                stock_id_ary='';
                for (str_i=1; str_i lte query1.recordcount; str_i = str_i+1)
                {
                    stock_id_ary=listappend(stock_id_ary,query1.AMOUNT[str_i],'???');
                    stock_id_ary=listappend(stock_id_ary,query1.RELATED_MAIN_SPECT_ID[str_i],'??');
                    stock_id_ary=listappend(stock_id_ary,query1.STOCK_ID[str_i],'??');
                    stock_id_ary=listappend(stock_id_ary,query1.LINE_NUMBER[str_i],'??');
                }
            </cfscript>
            <cfreturn stock_id_ary>
        </cffunction>
        	 <cffunction name="get_production_times" returntype="string" output="no">
        <cfargument name="station_id" type="boolean" default="1">
        <cfargument name="shift_id" type="boolean" default="1">
        <cfargument name="stock_id" type="boolean" default="1">
        <cfargument name="amount" type="boolean" default="1">
        <cfargument name="min_date" type="numeric" default="0">
        <cfargument name="setup_time_min" type="numeric" default="0">
        <cfargument name="production_type" type="boolean" default="0">
        <cfargument name="_now_" type="string" default="">
        <cfquery name="GET_STATION_CAPACITY" datasource="#DSN3#"><!--- Se??ilen istasyona ve ??r??ne ba??l?? olarak istasyonumuzun o ??r??n?? ne kadar zamanda ??retti??i bilgileri --->
            SELECT 
                *
            FROM
                WORKSTATIONS_PRODUCTS WSP,
                WORKSTATIONS W
            WHERE
                W.STATION_ID=WSP.WS_ID AND 
                WSP.STOCK_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.stock_id#"> AND
                WS_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.station_id#">
        </cfquery>
        <cfif GET_STATION_CAPACITY.RECORDCOUNT>
            <cfset capacity = GET_STATION_CAPACITY.CAPACITY />
        <cfelse>
            <cfset capacity = 1 />
        </cfif>    
        <cfset amount = arguments.amount />
        <!--- ??stasyon zamanlar??nda bazen hata oluyordu,onu engellemek i??in eklendi...??retim zaman?? 0,000001 gibi bi de??er inifty oluyor ve 0 geldi??i i??in ??ak??yordu --->
        <cfif capacity eq 0><cfset capacity =1 /></cfif>
        <cfset gerekli_uretim_zamani_dak = wrk_round((amount/capacity)*60,6) />
        <cfif arguments.setup_time_min gt 0><cfset gerekli_uretim_zamani_dak = arguments.setup_time_min + gerekli_uretim_zamani_dak /></cfif>
        <!--- <cfoutput><font color="FF0000">**********#arguments.min_date#************************ </font> </cfoutput> --->
        <cfif len(arguments._now_) and isdate(arguments._now_)>
            <cfset _now_ = arguments._now_ />
        <cfelse>
            <cfset _now_ = date_add('h',session.ep.TIME_ZONE,now()) />
        </cfif>
        <cfquery name="get_station_times" datasource="#dsn#">
            SELECT * FROM SETUP_SHIFTS WHERE IS_PRODUCTION = 1 AND FINISHDATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#"> AND SHIFT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.shift_id#">
        </cfquery>
        <cfif get_station_times.recordcount>
            <cfset calisma_start = (get_station_times.START_HOUR*60)+get_station_times.START_MIN />
            <cfset calisma_finish = (get_station_times.END_HOUR*60)+get_station_times.END_MIN />
        <cfelse>
            <cfset calisma_start = 01 />
            <cfset calisma_finish = 1439 />
        </cfif>
        <cfquery name="get_station_select" datasource="#dsn3#">
            SELECT DISTINCT
                DATEPART(hh,START_DATE)*60+DATEPART(n,START_DATE) AS START_TIME,
                DATEPART(M,START_DATE) AS START_MONT,
                DATEPART(D,START_DATE) AS START_DAY,
                DATEPART(hh,FINISH_DATE)*60+DATEPART(n,FINISH_DATE) AS FINISH_TIME,
                DATEPART(M,FINISH_DATE) AS FINISH_MONT,
                DATEPART(D,FINISH_DATE) AS FINISH_DAY,
                datediff(d,START_DATE,FINISH_DATE) AS FARK,
                START_DATE,FINISH_DATE	
            FROM 
                PRODUCTION_ORDERS 
            WHERE 
                STATION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.station_id#"> AND 
                (START_DATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#"> OR FINISH_DATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#">)
        UNION ALL
            SELECT
                DISTINCT
                DATEPART(hh,START_DATE)*60+DATEPART(n,START_DATE) AS START_TIME,
                DATEPART(M,START_DATE) AS START_MONT,
                DATEPART(D,START_DATE) AS START_DAY,
                DATEPART(hh,FINISH_DATE)*60+DATEPART(n,FINISH_DATE) AS FINISH_TIME,
                DATEPART(M,FINISH_DATE) AS FINISH_MONT,
                DATEPART(D,FINISH_DATE) AS FINISH_DAY,
                datediff(d,START_DATE,FINISH_DATE) AS FARK,
                START_DATE,FINISH_DATE	
            FROM 
                PRODUCTION_ORDERS_CASH
            WHERE 
                STATION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.station_id#"> AND 
                (START_DATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#"> OR FINISH_DATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#">)
            ORDER BY 
                START_DATE ASC,FINISH_DATE ASC
        </cfquery>
        <cfset full_days ='' />	<!---dolu olan g??nleri yani i?? y??klemesi yapam??yaca????m g??nleri belirliyoruz. --->
        <cfset production_type = arguments.production_type /><!--- 0 ise s??rekli ??retim 1 ise par??al?? ??retim yapacak  --->
        <!--- ??retimlerimizin i??inden ba??lang???? ve biti?? saatlerini hesaplayarak ??al????ma saatlerimizi ??ekillendiriyoruz. --->
        <table cellpadding="1" cellspacing="1" border="1" width="100%" class="">
        <cfoutput query="get_station_select">
            <cfset p_start_day = DateFormat(START_DATE,'YYYYMMDD') />
            <cfset p_finish_day = DateFormat(FINISH_DATE,'YYYYMMDD') />
           <tr>
            <cfif FARK gt 0><!--- Ba??lang???? ve biti?? tarihleri ayn?? olmayan ??retim emirleri gelsin sadece. --->
                <cfloop from="0" to="#FARK#" index="_days_">
                    <cfset new_days = DateFormat(date_add('D',_days_,START_DATE),'YYYYMMDD') />
                    <cfif not ListFind(full_days,new_days,',') and new_days gte DateFormat(_NOW_,'YYYYMMDD')><!--- DOLU G??NLER ??????NDE OLMAYAN G??NLER GELS??N SADECE --->
                        <cfif not isdefined('empty_days#new_days#') OR(isdefined('empty_days#new_days#') and not len(Evaluate('empty_days#new_days#')))><cfset 'empty_days#new_days#' = '#calisma_start#-#calisma_finish#' /><!--- ----#new_days# ---></cfif>
                            <td>
                                <cfif new_days eq p_start_day><!--- ??retimin Ba??lad?????? G??n ise --->
                               <font color="33CC33">#new_days#[#START_TIME#]</font>
                                    <cfif START_TIME lte ListGetAt(Evaluate('empty_days#new_days#'),2,'-') and START_TIME gte ListGetAt(Evaluate('empty_days#new_days#'),1,'-')><!--- ??retim zaman??m??z ??al????ma saatleri aras??nda ise --->
                                       <cfset 'empty_days#new_days#' = '#ListGetAt(Evaluate('empty_days#new_days#'),1,'-')#-#START_TIME-1#' />
                                    </cfif>
                                <cfelseif new_days eq p_finish_day><!--- ??retimin Bitti??i G??n ise --->
                                <font color="FF0000">biti??=>#new_days#[#FINISH_TIME#]</font>
                                    <!--- <cfif ListLen(Evaluate('empty_days#new_days#'),'-') lt 2>#new_days#cccc#Evaluate('empty_days#new_days#')#aaaa<cfabort></cfif> --->
                                    <cfif FINISH_TIME lte ListGetAt(Evaluate('empty_days#new_days#'),2,'-') and FINISH_TIME gte ListGetAt(Evaluate('empty_days#new_days#'),1,'-')>
                                        <cfset 'empty_days#new_days#' = '#FINISH_TIME+1#-#ListGetAt(Evaluate('empty_days#new_days#'),2,'-')#' />
                                    <cfelseif  FINISH_TIME gte ListGetAt(Evaluate('empty_days#new_days#'),2,'-')><!--- e??er biti?? zaman?? ??al????ma saatlerinin ??zerinde ise,o zamanda o g??n??de dolu g??nler aras??na al??yoruz. --->
                                        <cfset full_days =ListAppend(full_days,new_days,',') />#new_days#
                                    </cfif>
                                <cfelse><!--- ??retimin ba??lag???? ve biti?? tarihi aras??nda kalan g??nler ise bu g??nler zaten ??retim ile dolu g??nler oldu??u i??in direkt olarak kapat??yoruz. --->
                                    <cfset full_days =ListAppend(full_days,new_days,',') />#new_days#XX
                                </cfif>
                               <!--- ///[#Evaluate('empty_days#new_days#')#]// --->
                           </td>
                      </cfif>
                </cfloop>
            </cfif>
            </tr>
        </cfoutput>
        </table>
        <!--- bURDA ??SE BA??LANGI?? VE B??T???? G??NLER?? AYNI OLAN ??RET??MLER?? ??EK??LLEND??R??CEZ. --->
        <cfoutput query="get_station_select">
            <cfset p_start_day = DateFormat(START_DATE,'YYYYMMDD') />
            <cfif FARK eq 0 and not listfind(full_days,p_start_day,',') and p_start_day gte DateFormat(_NOW_,'YYYYMMDD')><!--- Ba??lama ve biti?? tarihi ayn?? olan g??nler yani 1 g??n i??inde ba??lay??p biten ??retimlere bak??yoruz. --->
                    <cfif not isdefined('empty_days#p_start_day#') OR (isdefined('empty_days#p_start_day#') and not len(Evaluate('empty_days#p_start_day#')))><cfset 'empty_days#p_start_day#' = '#calisma_start#-#calisma_finish#'></cfif>
                    <!--- <cfset days_list = listdeleteduplicates(ListAppend(days_list,p_start_day,',')) /> --->
                    <cfif START_TIME lt calisma_start><cfset START_TIME = calisma_start /></cfif>
                    <cfif FINISH_TIME lt calisma_finish><cfset FINISH_TIME = calisma_finish /></cfif>
                    <cfloop list="#Evaluate('empty_days#p_start_day#')#" index="list_d">
                         <cfif ListLen(list_d,'-') neq 2>
                            <cfset saat_basi=list_d /><!--- Sadece hata vermesin diye eklendi daha sonra silinecek! --->
                            <cfset saat_sonu=list_d+60 />
                            <cfset list_d = '#saat_basi#-#saat_sonu#' />
                        <cfelse>
                            <cfset saat_basi=ListGetAt(list_d,1,'-') />
                            <cfset saat_sonu=ListGetAt(list_d,2,'-') /><!--- 11:00-13:00 --->
                        </cfif>
                        <cfif START_TIME gt saat_basi and START_TIME lt saat_sonu and FINISH_TIME lt saat_sonu><!--- ortadaysa 11:30-12--->
                            <cfset aaa='#ListGetAt(list_d,1,'-')#-#START_TIME-1#' />
                            <cfset bb='#FINISH_TIME+1#-#ListGetAt(list_d,2,'-')#' />
                            <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),aaa) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),bb) />
                          <!--- ##=>111111 : #aaa#--<!--- #bb# ---><br/> <!---  ---> --->
                         <cfelseif START_TIME lte saat_basi and FINISH_TIME gt saat_basi and FINISH_TIME lt saat_sonu><!--- 9-12 --->
                            <cfset ccc = '#FINISH_TIME+1#-#ListGetAt(list_d,2,'-')#' />
                           <cfif listlen(Evaluate('empty_days#p_start_day#')) and list_d gt 0 and listfind(Evaluate('empty_days#p_start_day#'),list_d) gt 0>
                                <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                                <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),ccc) />
                            </cfif>
                          <!---  2222222 :#START_TIME#---#FINISH_TIME#--*#ccc#<br/><!---  ---> --->
                         <cfelseif START_TIME lte saat_basi and FINISH_TIME gt saat_basi and FINISH_TIME gte saat_sonu> <!--- 9-14 --->
                            <cfif listlen(Evaluate('empty_days#p_start_day#')) and list_d gt 0 and listfind(Evaluate('empty_days#p_start_day#'),list_d) gt 0>
                                <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            </cfif>
                         <cfelseif START_TIME lte saat_basi and  FINISH_TIME gt saat_basi and FINISH_TIME lt saat_sonu><!--- 11-12 --->
                            <cfset ffff = '#FINISH_TIME+1#-#ListGetAt(list_d,2,'-')#' />
                            <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),ffff) />
                           <!--- 33333333 :#START_TIME#---#FINISH_TIME#--*#ffff#<br/><!---  ---> --->
                         <cfelseif START_TIME gt saat_basi and  START_TIME lt saat_sonu and FINISH_TIME gte saat_sonu><!--- 12-13,12-14 --->
                            <cfset dddd = '#saat_basi#-#START_TIME-1#' />
                            <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),dddd) />
                         <!---  44444444 :#START_TIME#---#FINISH_TIME#--*#dddd#<br/><!---   ---> --->
                        <cfelseif START_TIME gt saat_basi and START_TIME lte saat_sonu and FINISH_TIME gte saat_sonu>
                            <cfset eeee = '#ListGetAt(list_d,1,'-')#-#START_TIME-1#' />
                            <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),eeee) />
                          <!---  555555 : ******#list_d#********-------#eeee#<br/> --->
                        <cfelseif (START_TIME lte calisma_start and FINISH_TIME gte calisma_finish)><!--- 9-14 --->
                            <!--- kapand??: --->
                            <cfset full_days = ListAppend(full_days,p_start_day,',') />
                        </cfif>
                    </cfloop>
               <!---     #p_start_day#==>#Evaluate('empty_days#p_start_day#')#</font> <br/>
                  #p_start_day#==>[[#Evaluate('empty_days#p_start_day#')#]]<br/>
                    #Evaluate('empty_days#p_start_day#')#***#START_TIME#-#FINISH_TIME#<br/> --->
            </cfif>
        </cfoutput>
        <cfset uretim_birlesim_dakika = 0 />
        <cfoutput>
            <cfset songun = 365 /><!--- ??retim verildikten sonra 1 y??l boyunca bo?? zamana bak??yoruz. --->
            <cfloop from="0" to="#songun#" index="_i_n_d_">
                <cfset crate_days = DateFormat(date_add('d',_i_n_d_,_NOW_),'YYYYMMDD') /><!--- ilk g??n olarak bug??n?? al??yoruz. --->
                <cfif not listfind(full_days,crate_days,',')><!--- Yukarda belirledi??imiz dolu g??nlerin i??inde de??il ise --->           
                    <cfif not isdefined('empty_days#crate_days#') OR(isdefined('empty_days#crate_days#') and not len(Evaluate('empty_days#crate_days#')))><cfset 'empty_days#crate_days#' = '#calisma_start#-#calisma_finish#'><!--- tan??mlanmam???? bo?? kalm???? g??nleri ??al????ma saatlerinin zamanlar??n?? at??yoruz. ---></cfif>
                    <cfset last_empty_time = listlast(Evaluate('empty_days#crate_days#'),',') /><!---sonzaman=>g??n??n son bo?? saatinin aral?????? mesela [15:15-16:20],[17:00-19:30] saatleri bo?? zamanlar olsun,sondan ekleme yapmak i??in burda[17:00-19:30] luk k??sm?? getiriyor.  --->
                    <cfset next_day = DateFormat(date_add('d',_i_n_d_+1,now()),'YYYYMMDD') /><!--- bir sonraki g??n?? belirliyoruz. --->
                    <cfif DateFormat(_NOW_,'YYYYMMDD') eq crate_days><!--- e??er bug??ne bak??l??yorsa  --->
                        <cfset now_minute = (ListGetAt(TimeFormat(_now_,'HH:MM'),1,':') * 60) + ListGetAt(TimeFormat(_now_,'HH:MM'),2,':') /><!--- ??u an?? dk olarak set ediyoruz. --->
                        <cfloop list="#Evaluate('empty_days#crate_days#')#" index="now_edit">
                            <!--- #now_minute#___#ListGetAt(now_edit,1,'-')#___#ListGetAt(now_edit,2,'-')# --->
                            <cfif now_minute gt ListGetAt(now_edit,1,'-') and now_minute lt ListGetAt(now_edit,2,'-')><!--- bug??n??n bo?? saatlerini ??u andan sonra olacak ??ekilde d??zenliyoruz. mesela ??u anda saat 14:00 olsun,bo?? zaman [12:00-16:00] bu durumda bu bo?? zaman [14:00-16:00] aras?? oluyor. --->
                                 <cfset 'empty_days#crate_days#' = ListSetAt(Evaluate('empty_days#crate_days#'),ListFind(Evaluate('empty_days#crate_days#'),now_edit,','),"#now_minute#-#ListGetAt(now_edit,2,'-')#",',') />
                            <cfelseif now_minute gt ListGetAt(now_edit,1,'-') and now_minute gt ListGetAt(now_edit,2,'-')>
                                 <cfset full_days =ListAppend(full_days,crate_days,',') />
                            <cfelseif now_minute gt ListGetAt(now_edit,1,'-') and now_minute lt ListGetAt(now_edit,2,'-')>
                                 <cfif ListFind(full_days,crate_days,',') gt 0>
                                     <cfset full_days =ListDeleteAt(full_days,ListFind(full_days,crate_days,','),',') />
                                </cfif>
                                 <cfif ListFind(evaluate('empty_days#crate_days#'),now_edit,',')-1 gt 0>
                                     <cfset 'empty_days#crate_days#' =ListDeleteAt(evaluate('empty_days#crate_days#'),ListFind(evaluate('empty_days#crate_days#'),now_edit,',')-1,',') />
                                 </cfif>
                            <cfelseif now_minute lt ListGetAt(now_edit,1,'-') and now_minute lt ListGetAt(now_edit,2,'-')>
                                <cfif ListFind(full_days,crate_days,',') gt 0>
                                     <cfset full_days =ListDeleteAt(full_days,ListFind(full_days,crate_days,','),',') />
                                </cfif>
                                 <cfif ListFind(evaluate('empty_days#crate_days#'),now_edit,',')-1 gt 0>
                                     <cfset 'empty_days#crate_days#' =ListDeleteAt(evaluate('empty_days#crate_days#'),ListFind(evaluate('empty_days#crate_days#'),now_edit,',')-1,',') />
                                 </cfif>
                            </cfif>
                        </cfloop>
                    </cfif>#crate_days#==>#Evaluate('empty_days#crate_days#')#</font> <br/>
                    <cfif not listfind(full_days,crate_days,',')>
                    <cfif production_type eq 0><!--- continue ??retim yap??l??yor ise --->
                        <!--- #Evaluate('empty_days#crate_days#')#-- --->
                        <!--- #crate_days# #next_day#==> #Evaluate('empty_days#crate_days#')#==>sonzaman==> #last_empty_time# ==>birsonkg??nba??==>#next_first_empty_time# --->
                        <!--- <cfif ListLast(last_empty_time,'-') eq calisma_finish><!--- son bo?? zaman??n biti?? saati istasyonun ??al????ma biti?? saatine e??itmi --->
                            <cfset last_time_diff = ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')>
                        <cfelse>    
                            <cfset last_time_diff = -1>
                        </cfif>bug??nFark??=>#last_time_diff# --->
                       <!---  <cfif ListFirst(next_first_empty_time,'-') eq calisma_start>
                            <cfset firs_time_diff =  ListLast(next_first_empty_time,'-')-ListFirst(next_first_empty_time,'-')>
                        <cfelse>    
                            <cfset firs_time_diff = -1>
                        </cfif>=>sonrakiGFark=>#firs_time_diff# --->
                        <!--- g??nler baz??nda --->
                        <!--- birg??n bo??lu??una girecek bir ??retim ise bo?? olan zamanlar d??ns??n --->
                        <cfif gerekli_uretim_zamani_dak lte (calisma_finish-calisma_start)><!--- 1 g??n i??inde bitebilecek bir ??retim ise g??n??n i??indeki bo?? zamanlara bak??yoruz. --->
                             <cfloop list="#Evaluate('empty_days#crate_days#')#" index="l_list">
                                <cfif ListGetAt(l_list,2,'-')-ListGetAt(l_list,1,'-') gte gerekli_uretim_zamani_dak>
                                    <cfset finded_production_start_day = crate_days />
                                    <cfset finded_production_finish_day = crate_days />
                                    <cfset finded_production_start_time = "#Int(ListGetAt(l_list,1,'-')/60)# : #ListGetAt(l_list,1,'-') mod 60#" />
                                    <cfset finded_production_finish_time = "#Int((ListGetAt(l_list,1,'-')+gerekli_uretim_zamani_dak)/60)# : #(ListGetAt(l_list,1,'-')+gerekli_uretim_zamani_dak) mod 60#" />
                                   <!---  bulundu!**#finded_production_start_day# -- #finded_production_start_time#-#finded_production_finish_time#<br/> --->
                                    <cfset finded_production_start_finish_times = "#finded_production_start_day#,#finded_production_start_time#,#finded_production_finish_day#,#finded_production_finish_time#" />
                                <cfreturn finded_production_start_finish_times>
                                    <cfexit method="exittemplate"><!--- uygun aral?????? bulursa ????ks??n --->
                                </cfif>
                            </cfloop>
                        </cfif>
                        <!--- birbirni takip eden g??nlerde ??retim. --->
                        <cfif not listfind(full_days,next_day,',')><!--- bir sonraki g??n dolu g??nler aras??nda de??ilse  --->
                            <cfif not isdefined('empty_days#next_day#')><!--- bir sonraki g??n??n ba??lag??n?? zaman??n?? al??caz mesela 09:15-12:20 --->
                                <cfset next_first_empty_time = '#calisma_start#-#calisma_finish#' />
                            <cfelse>
                                <cfset next_first_empty_time = ListFirst(Evaluate('empty_days#DateFormat(date_add('d',_i_n_d_+1,now()),'YYYYMMDD')#'),',') />
                            </cfif>
                        <cfelse> 
                            <cfset next_first_empty_time = -1 />
                        </cfif>
                        <cfif (not listfind(full_days,next_day,',')) and<!--- buldu??umuz bir sonraki g??n dolu g??nler aras??nda de??il ise --->
                               (ListLast(last_empty_time,'-') eq calisma_finish) and<!--- bug??n??n son bo?? zaman??n??n biti?? saati calisma program??n??n biti?? saati ile e??itmi --->
                               (ListFirst(next_first_empty_time,'-') eq calisma_start)<!--- bir sonraki g??ndeki bo?? zaman??n ba??lang???? saati calisma program??n??n ba??lamg???? saati ile e??itmi --->
                               >
                               <!--- <font color="0000FF">#Evaluate('empty_days#crate_days#')# uz:#ListLen(Evaluate('empty_days#crate_days#'),',')#</font> --->
                                <cfif ListLen(Evaluate('empty_days#crate_days#'),',') neq 1><!--- bir taneden fazla bo?? ??al????ma an?? varsa e??er g??n??m??zde yani =>[10:05-12:30],[13:13-15:00] b??yle ise --->
                                    <cfset finded_production_start_time = "#Int(ListGetAt(last_empty_time,1,'-')/60)# : #ListGetAt(last_empty_time,1,'-') mod 60#" />
                                    <cfset finded_production_start_day = crate_days />
                                    <cfset uretim_birlesim_dakika = ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')+ListLast(next_first_empty_time,'-')-ListFirst(next_first_empty_time,'-') />
                                <cfelseif ListFirst(next_first_empty_time,'-') eq calisma_start and ListLast(next_first_empty_time,'-') eq calisma_finish><!--- bir sonraki g??ndeki bo?? zaman??n ba??lang???? saati calisma program??n??n ba??lamg???? saati ile e??itmi --->
                                    <cfset uretim_birlesim_dakika = uretim_birlesim_dakika + (ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')) />
                                <cfelse>
                                    <cfset uretim_birlesim_dakika = uretim_birlesim_dakika + (ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')) + ListLast(next_first_empty_time,'-')-ListFirst(next_first_empty_time,'-') />
                                </cfif>	  
                        <cfelse>
                                <cfset uretim_birlesim_dakika = 0 />
                        </cfif>
                        <!---bulunan zaman?? kar????la??t??r??yoruz. --->
                        <cfif uretim_birlesim_dakika gte gerekli_uretim_zamani_dak>
                            <!--- <font color="66666"> --->
                                <cfif not isdefined('finded_production_start_day')>
                                    <cfset finded_production_start_day = crate_days />
                                    <cfset finded_production_start_time = "#Int(ListGetAt(last_empty_time,1,'-')/60)# : #ListGetAt(last_empty_time,1,'-') mod 60#" />
                                </cfif>
                                <cfset _fark_ = uretim_birlesim_dakika-gerekli_uretim_zamani_dak />
                                <cfset finded_production_finish_day = next_day />
                                <cfset finded_production_finish_time =" #Int((ListGetAt(next_first_empty_time,2,'-') - _fark_)/60)# : #(ListGetAt(next_first_empty_time,2,'-') - _fark_) mod 60#" />
                           <!---  #finded_production_start_day#__#finded_production_start_time#-----#finded_production_finish_day# : #finded_production_finish_time#
                            BULUNDU!!!!!!!!!!!!!!!!!!</font> --->
                            <cfset finded_production_start_finish_times = "#finded_production_start_day#,#finded_production_start_time#,#finded_production_finish_day#,#finded_production_finish_time#" />
                            <cfreturn finded_production_start_finish_times>
                            <cfexit method="exittemplate">
                        </cfif>
                    <cfelse><!--- Par??al?? ??retim yap??l??yorsa --->
                          <cfif uretim_birlesim_dakika eq 0><!--- ilk g??n??m??z belli oluyor.--->
                                <cfset finded_production_start_day = crate_days /><cfif listlen(Evaluate('empty_days#finded_production_start_day#'),'-') lt 2>DOLU G??NLER =>#full_days#---#finded_production_start_day#=>#Evaluate('empty_days#finded_production_start_day#')#--</cfif>
                                <cfset finded_production_start_time = "#Int(ListFirst(Evaluate('empty_days#finded_production_start_day#'),'-')/60)# : #ListFirst(Evaluate('empty_days#finded_production_start_day#'),'-') mod 60#" />
                          </cfif>
                           <font color="FF0000">#Evaluate('empty_days#crate_days#')#</font><br/>
                          <cfloop list="#Evaluate('empty_days#crate_days#')#" index="new_indx">
                                <cfset uretim_birlesim_dakika = uretim_birlesim_dakika + (ListGetAt(new_indx,2,'-')-ListGetAt(new_indx,1,'-')) />
                                <cfif uretim_birlesim_dakika gte gerekli_uretim_zamani_dak>
                                    <cfset finded_production_finish_day = crate_days /><!--- ??retimin doldu??u an?? buluyoruz. --->
                                    <cfset onceki_uretim_birlesim_dakika = uretim_birlesim_dakika-(ListGetAt(new_indx,2,'-')-ListGetAt(new_indx,1,'-')) />
                                    <cfset fark = gerekli_uretim_zamani_dak-onceki_uretim_birlesim_dakika />
                                    <cfset finded_production_finish_time =" #Int(((ListGetAt(new_indx,1,'-')+fark))/60)# : #((ListGetAt(new_indx,1,'-')+fark)) mod 60#" />
                                    <cfset finded_production_start_finish_times = "#finded_production_start_day#,#finded_production_start_time#,#finded_production_finish_day#,#finded_production_finish_time#" />
                               <cfreturn finded_production_start_finish_times>
                                    <cfexit method="exittemplate">
                                </cfif>
                          </cfloop>
                    </cfif>
                    </cfif>
                    <!--- bu sat??rlar silinmesin bunlar test yaparken gerekli oluyor. 
                   <font color="red">#ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')#<!--- +#ListLast(next_first_empty_time,'-')-ListFirst(next_first_empty_time,'-')# --->==>[[[#uretim_birlesim_dakika#]]]</font>--->
                </cfif>
            </cfloop>
        </cfoutput>
    </cffunction>
      <cffunction name="wrk_round" returntype="string" output="false">
        <cfargument name="number" required="true">
        <cfargument name="decimal_count" required="no" default="2">
        <cfargument name="kontrol_float" required="no" default="0"><!--- ??r??n a??ac??nda ??ok ufak de??erler girildi??inde E- format??nda yaz??lanlar bozulmas??n diye eklendi SM20101007 --->
        <cfscript>
            if (not len(arguments.number)) return '';
            if(arguments.kontrol_float eq 0)
            {
                if (arguments.number contains 'E') arguments.number = ReplaceNoCase(NumberFormat(arguments.number), ',', '', 'all');
            }
            else
            {
                if (arguments.number contains 'E') 
                {
                    first_value = listgetat(arguments.number,1,'E-');
                    first_value = ReplaceNoCase(first_value,',','.');
                    last_value = ReplaceNoCase(listgetat(arguments.number,2,'E-'),'0','','all');
                    //if(last_value gt 5) last_value = 5;
                    for(kk_float=1;kk_float lte last_value;kk_float=kk_float+1)
                    {
                        zero_info = ReplaceNoCase(first_value,'.','');
                        first_value = '0.#zero_info#';
                    }
                    arguments.number = first_value;
                            first_value = listgetat(arguments.number,1,'.');
                arguments.number = "#first_value#.#Left(listgetat(arguments.number,2,'.'),8)#";
                    if(arguments.number lt 0.00000001) arguments.number = 0;
                    return arguments.number;
                }
            }
            if (arguments.number contains '-'){
                negativeFlag = 1;
                arguments.number = ReplaceNoCase(arguments.number, '-', '', 'all');}
            else negativeFlag = 0;
            if(not isnumeric(arguments.decimal_count)) arguments.decimal_count= 2;	
            if(Find('.', arguments.number))
            {
                tam = listfirst(arguments.number,'.');
                onda =listlast(arguments.number,'.');
                if(onda neq 0 and arguments.decimal_count eq 0) //yuvarlama say??s?? s??f??rsa noktadan sonraki ilk rakama gore tam k??s??mda yuvarlama yap??l??r
                {
                    if(Mid(onda, 1,1) gte 5) // yuvarlama 
                        tam= tam+1;	
                }
                else if(onda neq 0 and len(onda) gt arguments.decimal_count)
                {
                    if(Mid(onda,arguments.decimal_count+1,1) gte 5) // yuvarlama
                    {
                        onda = Mid(onda,1,arguments.decimal_count);
                        textFormat_new = "0.#onda#";
                        textFormat_new = textFormat_new+1/(10^arguments.decimal_count);
                        
                        decimal_place_holder = '_.';
                        for(decimal_index=1;decimal_index<=arguments.decimal_count;++decimal_index)
                            decimal_place_holder = '#decimal_place_holder#_';
                        textFormat_new = LSNumberFormat(textFormat_new,decimal_place_holder);
                            
                        if(listlen(textFormat_new,'.') eq 2)
                        {
                            tam = tam + listfirst(textFormat_new,'.');
                            onda =listlast(textFormat_new,'.');
                        }
                        else
                        {
                            tam = tam + listfirst(textFormat_new,'.');
                            onda = '';
                        }
                    }
                    else
                        onda= Mid(onda,1,arguments.decimal_count);
                }
            }
            else
            {
                tam = arguments.number;
                onda = '';
            }
            textFormat='';
            if(len(onda) and onda neq 0 and arguments.decimal_count neq 0)
                textFormat = "#tam#.#onda#";
            else
                textFormat = "#tam#";
            if (negativeFlag) textFormat =  "-#textFormat#";
            return textFormat;
        </cfscript>
    </cffunction>
	   <cffunction name="writeTree_operation" returntype="void">
            <cfargument name="next_stock_id">
            <cfargument name="next_spec_id">
            <cfargument name="next_product_tree_id">
            <cfargument name="type">
     		<cfscript>
				var i = 1;
				var sub_products = get_subs_operation(next_stock_id,next_spec_id,next_product_tree_id,type);
				attributes.deep_level_op = attributes.deep_level_op + 1;
				for (i=1; i lte listlen(sub_products,'???'); i = i+1)
				{
					_next_product_tree_id_ = ListGetAt(ListGetAt(sub_products,i,'???'),1,'??');//alt+987 = ??? --//alt+789 = ??
					_next_spect_id_ = ListGetAt(ListGetAt(sub_products,i,'???'),2,'??');
					_next_stock_id_ = ListGetAt(ListGetAt(sub_products,i,'???'),3,'??');
					_next_amount_ = ListGetAt(ListGetAt(sub_products,i,'???'),4,'??');
					_next_operation_id_ = ListGetAt(ListGetAt(sub_products,i,'???'),5,'??');
					_next_deep_level_ = ListGetAt(ListGetAt(sub_products,i,'???'),6,'??');
					product_tree_id_list = listappend(product_tree_id_list,_next_product_tree_id_,',');
					operation_type_id_list = listappend(operation_type_id_list,_next_operation_id_,',');
					amount_list = listappend(amount_list,_next_amount_,',');
					"deep_level_#_next_operation_id_#" = _next_deep_level_;
					deep_level_list = listappend(deep_level_list,_next_deep_level_,',');
					if(_next_operation_id_ gt 0) type_=3;else type_=0;
		
					if(attributes.deep_level_op lt 40)
					{
						writeTree_operation(_next_stock_id_,_next_spect_id_,_next_product_tree_id_,type_);
					}
				 }
			 </cfscript>
        </cffunction>
