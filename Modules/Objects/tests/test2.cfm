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
    <cfset dsn3="#dsn#_1">

<cfset appointment_data=DeserializeJSON(attributes.app_data)>


<cfquery name="getOrderStocks" datasource="#dsn#">
  SELECT POS.*,P.PRODUCT_NAME FROM catalyst_prod_1.PRODUCTION_ORDERS_STOCKS AS POS
  LEFT JOIN catalyst_prod_product.PRODUCT AS P ON P.PRODUCT_ID=POS.PRODUCT_ID
   WHERE POS.P_ORDER_ID=#appointment_data.P_ORDER_ID#
</cfquery>
<cfquery name="getPo" datasource="#dsN#">
  SELECT * FROM catalyst_prod_1.PRODUCTION_ORDERS WHERE P_ORDER_ID=#appointment_data.P_ORDER_ID#
</cfquery>
<cfquery name="getOrderInfo" datasource="#dsN#">
  SELECT POR.ORDER_ID,POR.ORDER_ROW_ID,O.ORDER_NUMBER FROM catalyst_prod_1.PRODUCTION_ORDERS_ROW AS POR 
LEFT JOIN catalyst_prod_1.ORDERS AS O ON O.ORDER_ID=POR.ORDER_ID
WHERE POR.PRODUCTION_ORDER_ID=#appointment_data.P_ORDER_ID#

</cfquery>

<cfset attributes.PRODUCT_SARF_RECORDCOUNT = getOrderStocks.recordcount>
<cfset attributes.DETAIL=getPo.DETAIL>
<cfset attributes.DETAIL=getPo.DETAIL>
<cfset attributes.STATION_ID=appointment_data.STATION_ID>
<cfset attributes.P_ORDER_ID = appointment_data.P_ORDER_ID>
<cfset BitTar=createODBCDateTime(appointment_data.endDate)>
<cfset BasTar=createODBCDateTime(appointment_data.startDate)>
<cfset attributes.FINISH_DATE=dateFormat(BitTar,"yyyy-mm-dd")>
<cfset attributes.START_DATE=dateFormat(BasTar,"yyyy-mm-dd")>
<cfset attributes.FINISH_H=hour(BitTar)>
<cfset attributes.FINISH_M=minute(BitTar)>
<cfset attributes.START_H=hour(BasTar)>
<cfset attributes.START_M=minute(BasTar)>
<cfset attributes.IS_CONTINUE59 = 0>
<cfset attributes.IS_DEMAND = 0>
<cfset attributes.IS_GENERATE_SERIAL_NOS = 0>
<cfset attributes.LOT_NO = getPo.LOT_NO>
<cfset attributes.MAIN_STOCK_ID = getPo.STOCK_ID>
<cfset attributes.STOCK_ID = getPo.STOCK_ID>
<cfset attributes.OLD_FINISH_DATE = getPo.FINISH_DATE>
<cfset attributes.OLD_PROCESS_LINE =1>
<cfset attributes.OLD_PROCESS_STAGE =getPo.PROD_ORDER_STAGE>
<cfset attributes.OLD_QUANTITY =getPo.QUANTITY>
<cfset attributes.OLD_SPECT_VAR_ID =getPo.SPECT_VAR_ID>
<cfset attributes.SPECT_VAR_NAME  =getPo.SPECT_VAR_NAME >
<cfset attributes.SPECT_MAIN_ID =getPo.SPEC_MAIN_ID>
<cfset attributes.OLD_START_DATE =getPo.START_DATE>
<cfset attributes.ORDER_ID =getOrderInfo.ORDER_ID>
<cfset attributes.ORDER_ID_ =getOrderInfo.ORDER_NUMBER>
<cfset attributes.ORDER_ROW_ID =getOrderInfo.ORDER_ROW_ID>
<cfset attributes.PROCESS_STAGE =59>
<cfset attributes.PRODUCT_FIRE_RECORDCOUNT =0>
<cfset attributes.PRODUCT_NAME =appointment_data.text>
<cfset attributes.PROJECT_HEAD="">
<cfset attributes.PROJECT_ID="">
<cfset attributes.P_ORDER_ID=appointment_data.P_ORDER_ID>
<cfset attributes.QUANTITY =getPo.QUANTITY>
<cfset attributes.QUANTITY_ =getPo.QUANTITY>
<cfset attributes.RECORD_NUM_EXIT = getOrderStocks.recordcount>
<cfset attributes.RECORD_NUM_OUTAGE = getOrderStocks.recordcount>
<cfset attributes.REFERENCE_NO =getPo.REFERENCE_NO>
<cfset attributes.SPECT_VAR_ID =getPo.SPECT_VAR_ID>

<cfloop query="getOrderStocks">
<cfset "attributes.AMOUNT_EXIT#currentrow#"=AMOUNT>
<cfset "attributes.AMOUNT_EXIT_#currentrow#"=AMOUNT>
<cfset "attributes.FIRE_AMOUNT_EXIT#currentrow#"=FIRE_AMOUNT>
<cfset "attributes.FIRE_RATE_EXIT#currentrow#"=FIRE_RATE>
<cfset "attributes.IS_FREE_AMOUNT_EXIT#currentrow#"=IS_FREE_AMOUNT>
<cfset "attributes.IS_PHANTOM_EXIT#currentrow#"=IS_PHANTOM>
<cfset "attributes.IS_PROPERTY_EXIT#currentrow#"=IS_PROPERTY>
<cfset "attributes.IS_SEVK_EXIT#currentrow#"=IS_SEVK>
<cfset "attributes.LINE_NUMBER_EXIT#currentrow#"=LINE_NUMBER>
<cfset "attributes.PRODUCT_ID_EXIT#currentrow#"=PRODUCT_ID>
<cfset "attributes.PRODUCT_NAME_EXIT#currentrow#"=PRODUCT_NAME>
<cfset "attributes.ROW_KONTROL_EXIT#currentrow#"=1>
<cfset "attributes.SPECT_ID_EXIT#currentrow#"="">
<cfset "attributes.SPECT_MAIN_ROW_EXIT#currentrow#"=SPECT_MAIN_ROW_ID>
<cfset "attributes.SPECT_ID_EXIT#currentrow#"="">
</cfloop>


<h1>Merhaba</h1>



<cfif isdefined("attributes.p_order_id")>
	<cfscript>//ilişkili üretim emirlerine sonuç girilmemiş ise güncelleme yapılabilir!onun kontrolü
        related_production_list=attributes.p_order_id;
        function WriteRelatedProduction(P_ORDER_ID)
            {
                var i = 1;
                QueryText = '
                        SELECT 
                            P_ORDER_ID
                        FROM 
                            PRODUCTION_ORDERS
                        WHERE 
                            PO_RELATED_ID = #P_ORDER_ID#';
                'GET_RELATED_PRODUCTION#P_ORDER_ID#' = cfquery(SQLString : QueryText, Datasource : dsn3);
                if(Evaluate('GET_RELATED_PRODUCTION#P_ORDER_ID#').recordcount) 
                {
                    for(i=1;i lte Evaluate("GET_RELATED_PRODUCTION#P_ORDER_ID#").recordcount;i=i+1)
                    {
                        related_production_list = ListAppend(related_production_list,Evaluate("GET_RELATED_PRODUCTION#P_ORDER_ID#").P_ORDER_ID[i],',');
                        WriteRelatedProduction(Evaluate("GET_RELATED_PRODUCTION#P_ORDER_ID#").P_ORDER_ID[i]);
                    }
                }
            }
        WriteRelatedProduction(attributes.p_order_id);
    </cfscript>
    <cfset attributes.p_order_id = related_production_list>
    <cfquery name="GET_RELATED_PRODUCTION_RESULT" datasource="#dsn3#">
        SELECT PRODUCTION_ORDER_NO FROM PRODUCTION_ORDER_RESULTS WHERE P_ORDER_ID IN (#attributes.p_order_id#)
    </cfquery>
    <cfset related_production_no_list = ValueList(GET_RELATED_PRODUCTION_RESULT.PRODUCTION_ORDER_NO,',')>
    <cfif GET_RELATED_PRODUCTION_RESULT.recordcount and is_result_control eq 1><!--- xmle bağlandı --->
        <script type="text/javascript">
            alert("<cf_get_lang no ='635.Bu Üretim Emrinin İlişkili Olduğu Üretimlerden Sonuç Girilenler Var,Güncelleme Yapılamaz Sonuç Girilenler'>.! \n :<cfoutput>#related_production_no_list#</cfoutput>");
            history.go(-1);
        </script>
        <cfabort>
    </cfif>
</cfif>
<cfdump  var="#appointment_data#">
<cfdump  var="#session#">
<div style="color:magenta"><cfdump  var="#now()#"></div>
<div style="color:orange"><cfdump  var="#attributes.START_H #"><br><cfdump  var="#attributes.START_M #"></div>
<div style="color:purple"><cfdump  var="#attributes.FINISH_H #"><br><cfdump  var="#attributes.FINISH_M #"></div>
<div style="color:red"><cfdump  var="#attributes.start_date #"><br><cfdump  var="#attributes.finish_date #"></div>
<cfset attributes.start_date = createODBCDateTime(attributes.start_date)>
<cfset attributes.finish_date = createODBCDateTime(attributes.finish_date)>
<div style="color:green"><cfdump  var="#attributes.start_date #"><br><cfdump  var="#attributes.finish_date #"></div>
<cfscript>
	attributes.startdate_fn = dateAdd("n",attributes.start_m,dateAdd("h",attributes.start_h+SESSION.EP.TIME_ZONE,attributes.start_date));
	attributes.finishdate_fn = dateAdd("n",attributes.finish_m,dateAdd("h",attributes.finish_h+SESSION.EP.TIME_ZONE,attributes.finish_date));
	attributes.start_date = dateAdd("n",attributes.start_m,dateAdd("h",attributes.start_h+SESSION.EP.TIME_ZONE ,attributes.start_date));
	attributes.finish_date = dateAdd("n",attributes.finish_m,dateAdd("h",attributes.finish_h+SESSION.EP.TIME_ZONE ,attributes.finish_date));
</cfscript>
<div style="color:blue"><cfdump  var="#attributes.start_date #"><br><cfdump  var="#attributes.finish_date #"></div>


<cfif isdefined("attributes.station_id")  and len(attributes.station_id)>
	<cfquery name="GET_STATION" datasource="#dsn3#">
		SELECT 
			STATION_NAME,
			EXIT_DEP_ID,
			EXIT_LOC_ID,
			ENTER_DEP_ID,
			ENTER_LOC_ID,
			PRODUCTION_DEP_ID,
			PRODUCTION_LOC_ID
		FROM 
			WORKSTATIONS 
		WHERE 
			STATION_ID = #attributes.station_id#
	</cfquery>
</cfif>
<cfif isdefined("get_station.exit_dep_id") and len(get_station.exit_dep_id)>
	<cfset _EXIT_DEP_ID = get_station.exit_dep_id>
	<cfset _EXIT_LOC_ID = get_station.exit_loc_id>
<cfelse>
	<cfset _EXIT_DEP_ID = ''>
	<cfset _EXIT_LOC_ID = ''>
</cfif>
<cfif isdefined("get_station.production_dep_id") and len(get_station.production_dep_id)>
	<cfset _PRODUCTION_DEP_ID = get_station.production_dep_id>
	<cfset _PRODUCTION_LOC_ID = get_station.production_loc_id>
<cfelse>
	<cfset _PRODUCTION_DEP_ID = ''>
	<cfset _PRODUCTION_LOC_ID = ''>
</cfif>
<cfset temp_start = attributes.start_date>

		
		
		<cfquery name="add_production_order" datasource="#dsn3#">
			UPDATE 
				PRODUCTION_ORDERS
			SET
				STOCK_ID = #attributes.stock_id#, 
				QUANTITY = #attributes.quantity#,
				STATION_ID = <cfif isdefined("attributes.station_id")  and len(attributes.station_id)>#attributes.station_id#,<cfelse>NULL,</cfif>
				START_DATE = #attributes.startdate_fn#,
				FINISH_DATE = #attributes.finishdate_fn#,
				UPDATE_EMP = #session.ep.userid#,
				UPDATE_DATE = #now()#,
				UPDATE_IP = '#CGI.REMOTE_ADDR#',
				WORK_ID = <cfif isdefined('attributes.work_id') and len(attributes.work_id) and len(attributes.work_head)>#attributes.work_id#<cfelse>NULL</cfif>
				<cfif isdefined('attributes.po_related_id') and len(attributes.po_related_id)>,PO_RELATED_ID = #attributes.po_related_id#</cfif>
			WHERE
				P_ORDER_ID = #ListGetAt(attributes.p_order_id,1,',')#<!--- İlişkili üretim emirleride beraber gönderildiği için ilk eleman yani ana üretim emirinin id'sini alıyoruz. --->
		</cfquery>	
		
		<cfquery name="GET_PAPER" datasource="#dsn3#">
			SELECT P_ORDER_NO,P_ORDER_ID FROM PRODUCTION_ORDERS WHERE P_ORDER_ID = #ListGetAt(attributes.p_order_id,1,',')#
		</cfquery>
        <!--- Siparişten geliyorsa ve ürünün spec'i değiştirilmiş ise siparişle bağlantısının kopmamasını sağlıyoruz. --->
        <cfif isdefined('attributes.ORDER_ROW_ID') and len(attributes.ORDER_ROW_ID) and isdefined('attributes.OLD_SPECT_VAR_ID') and len(attributes.SPECT_VAR_ID) and attributes.OLD_SPECT_VAR_ID neq attributes.SPECT_VAR_ID>
            <!--- Bu bloğa girdi ise siparişteki spect_Var_id değişmiştir,o sebeble bizde siparişi güncelliyoruz. --->
            <cfquery name="UPD_ORDERS" datasource="#dsn3#">
            	UPDATE ORDER_ROW SET SPECT_VAR_ID = #attributes.SPECT_VAR_ID# WHERE ORDER_ROW_ID = #attributes.ORDER_ROW_ID#
            </cfquery>
        </cfif>

<cfif 1 eq 1><!--- XML ayarlarından üretim emrinin bitiş tarihi satış siparişinin teslim tarihini güncellensin seçilmiş ise. --->
	<cfif len(attributes.order_row_id)><!--- sipariş satır id'leri varsa --->
        <cfquery name="update_order_row_deliver_date" datasource="#dsn3#">
        	UPDATE ORDER_ROW 
            SET DELIVER_DATE = #attributes.finishdate_fn#
            WHERE ORDER_ROW_ID IN (#attributes.order_row_id#)
        </cfquery>
    </cfif>
</cfif>

   

    
<cfset attributes.actionId=ListGetAt(attributes.p_order_id,1,',')>
<script type="text/javascript">
	var d=new Date();
    window.opener.LoadData('','')
    window.close();
</script>


<!-----

<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" name="forum1" id="forum1">
    <input type="text" placeholder="Keyword" name="Keyword" id="keyword">
    <cf_select_customer frm_name="forum1" on_company_select="getKumas()" readonly="0">
    <input type="hidden" value="1" name="is_submit">
    <input type="submit">
</cfform>
<cfif isDefined("attributes.is_submit")>
<cfset DSN3="#dsn#_1">
<cfquery name="getColors" datasource="#dsn3#">
    SELECT COMPANY_ID,STOCK_ID,PROPERTY,STOCK_CODE,STOCK_CODE_2 FROM catalyst_prod_1.STOCKS WHERE 1=1 <cfif len(attributes.keyword)> AND (
       STOCK_CODE LIKE '%#attributes.Keyword#%' 
        OR PROPERTY LIKE '%#attributes.keyword#%'
        OR STOCK_CODE_2 LIKE '%#attributes.keyword#%'
        )</cfif> and
         PROPERTY IS NOT NULL  AND PROPERTY<>''
        <cfif len(attributes.company_id)> and COMPANY_ID =#attributes.company_id#</cfif>
</cfquery>
<table class="table table-sm table-stripped">
<thead>
<tr><th>#</th><th>Renk Kodu</th><th>Renk</th><th><th></tr>
</thead>
<tbody id="t1">
  <cfoutput query="getColors">
      <tr>
          <td>#currentrow#</td>
          <td>#STOCK_CODE_2#</td>
          <td>#Property#</td>
          <td><a href="#request.self#?fuseaction=color.form_upd_color&stock_id=#STOCK_ID#"> <i class="fas fa-pen"></i></a></td>
      </tr>
  </cfoutput>
  </tbody>
</table>
</cfif>


<script>
$("#keyword").keydown(function(){
  var t=$("#t1");
     var value = $(this).val().toLowerCase();
  if(t.length){
    console.log(t.children())
     $("#t1 tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });

  }
})

</script>

----->