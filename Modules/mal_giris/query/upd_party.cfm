<cfdump  var="#attributes#">

<cfquery name="getOrderaS" datasource="#dsn#_1">
    SELECT * FROM ORDERS WHERE ORDER_ID = (SELECT ORDER_ID FROM ORDER_ROW WHERE ORDER_ROW_ID=#attributes.order_row_id#)
</cfquery>

<cfset ATTRIBUTES.SALES_PARTNER_ID = getOrderaS.SALES_PARTNER_ID>
<CFIF LEN(ATTRIBUTES.SALES_PARTNER_ID)> <CFSET ATTRIBUTES.SALES_MEMBER="0"><CFELSE><CFSET ATTRIBUTES.SALES_MEMBER=""></CFIF>
<cfset ATTRIBUTES.ORDER_HEAD = getOrderaS.ORDER_HEAD>
<cfset attributes.order_date =#getOrderaS.ORDER_DATE#>
<cfparam  name="attributes.OFFER_ID " default="">
<cfquery name="getOrder_rowP" datasource="#dsn#_1">
    SELECT * FROM ORDER_ROW WHERE  ORDER_ID=#getOrderaS.ORDER_ID#
</cfquery>

<cfloop query="getOrder_rowP">
<CFSET "OP_PRODUCT_ID#ORDER_ROW_ID#"=PRODUCT_ID>
<CFSET "OP_UNIT#ORDER_ROW_ID#"=UNIT>
<CFSET "OP_UNIT_ID#ORDER_ROW_ID#"=UNIT_ID>
</cfloop>
<cfquery name="aa" dbtype="query">
    SELECT * FROM getOrder_rowP WHERE ORDER_ROW_ID <> #attributes.order_row_id#
</cfquery>
<cfquery name="BB" dbtype="query">
    SELECT * FROM getOrder_rowP WHERE ORDER_ROW_ID = #attributes.order_row_id#
</cfquery>

<cfset attributes.COMPANY_ID=getOrderaS.COMPANY_ID>
<cfset attributes.KG=BB.QUANTITY>
<cfset attributes.KG=BB.QUANTITY>
<cfset attributes.STOCK_ID_LIST=valueList(aa.STOCK_ID)>
<cfset attributes.STOCK_ID_LIST="#attributes.STOCK_ID_LIST#,#attributes.ekstoka#">

<cfset attributes.ROWS_=listLen(attributes.STOCK_ID_LIST)>
<cfquery name="getMusteriRisk" datasource="#dsn#">
SELECT CC.MONEY,C.MANAGER_PARTNER_ID,C.COMPANY_ADDRESS FROM COMPANY_CREDIT AS CC LEFT JOIN COMPANY AS C ON C.COMPANY_ID=CC.COMPANY_ID WHERE CC.COMPANY_ID=#attributes.company_id#
</cfquery>

<cfset attributes.partner_id=getMusteriRisk.MANAGER_PARTNER_ID>
<cfset attributes.order_employee_id =session.ep.USERID>
<cfset attributes.reserved=1>
<cfset attributes.deliverdate=now()>
<cfset attributes.ship_date=now()>
<cfset attributes.DISCOUNT_TOTAL=0>
<cfset TLtot=0>
<cfset Omtot=0>
<cfset attributes.basket_money=getMusteriRisk.MONEY>
<cfquery name="getKur" datasource="#dsn#">
    SELECT MONEY,RATE2,RATE1,RATE3 FROM catalyst_prod.MONEY_HISTORY WHERE  CONVERT(date,RECORD_DATE)<=CONVERT(date,GETDATE()) AND CONVERT(DATE,RECORD_DATE)>=CONVERT(date,GETDATE()) AND COMPANY_ID=1
    UNION SELECT 'TL' AS  MONEY,1 AS RATE2,1 AS RATE1,1 AS RATE3
</cfquery>

<cfloop query="getKur">
    <cfset "PRICEL.#MONEY#" = RATE2>
    <cfset "T_FIYAT.#MONEY#"=0>
    <cfset "attributes.hidden_rd_money_#currentrow#"="#MONEY#">
    <cfset "attributes.txt_rate1_#currentrow#"=RATE1>
    <cfset "attributes.txt_rate2_#currentrow#"=RATE2>
</cfloop>

<cfset FiyT=0>
<cfset FiyA=0>
<cfset OTotal=0>
<cfset Total=0>
<cfloop list="#attributes.STOCK_ID_LIST#" item="li" index="i">
    <cfquery name="getStandartPrice" datasource="#dsn#_product">
        SELECT PRICE,PRICE_KDV,MONEY FROM catalyst_prod_product.PRICE_STANDART WHERE PRODUCT_ID=(SELECT PRODUCT_ID FROM #dsn3#.STOCKS WHERE STOCK_ID=#li#) and PRICESTANDART_STATUS=1 and PURCHASESALES=1 
    </cfquery>
    <cfset "attributes.price#i#"=getStandartPrice.PRICE*evaluate("PRICEL.#getStandartPrice.MONEY#")>
    <cfset "attributes.tax#i#"=0>
    <cfset "attributes.row_nettotal#i#"=attributes.kg*evaluate("PRICEL.#getStandartPrice.MONEY#")*getStandartPrice.PRICE>
    <cfset "attributes.duedate#i#"=0>
    <cfset "attributes.other_money_#i#" = getStandartPrice.MONEY>
    <cfset "attributes.other_money_value_#i#" = attributes.kg*getStandartPrice.PRICE>
    <cfset "attributes.price_other#i#"=getStandartPrice.PRICE>
    <cfset "attributes.order_currency#i#"=-1>
    <cfquery name="getqqqq" dbtype="query">
        SELECT ORDER_ROW_ID FROM getOrder_rowP WHERE STOCK_ID=#li#
    </cfquery>
    <CFIF getqqqq.RECORDCOUNT>
    <cfset "attributes.action_row_id#i#"=getqqqq.ORDER_ROW_ID>
    <cfset "attributes.product_id#i#" = evaluate("OP_PRODUCT_ID#getqqqq.ORDER_ROW_ID#")>
    <cfset "attributes.unit#i#" =  evaluate("OP_UNIT#getqqqq.ORDER_ROW_ID#")>
    <cfset "attributes.unit_id#i#" =  evaluate("OP_UNIT_ID#getqqqq.ORDER_ROW_ID#")>
    <CFELSE>
    <cfset "attributes.unit#i#" =  evaluate("OP_UNIT#attributes.order_row_id#")>
    <cfset "attributes.unit_id#i#" =  evaluate("OP_UNIT_ID#attributes.order_row_id#")>
    <cfset "attributes.action_row_id#i#"= #attributes.order_row_id#>
     <cfset "attributes.product_id#i#" = evaluate("OP_PRODUCT_ID#attributes.order_row_id#")>
    
    </CFIF>
    
    <cfset "attributes.stock_id#i#"=li>
    <cfset "attributes.amount#i#"=BB.QUANTITY>
    <cfset "attributes.amount#i#"=BB.QUANTITY>
    <cfset carpan=1>

      <!----<cfset "T_FIYAT_#getStandartPrice.MONEY#" = evaluate("T_FIYAT_#getStandartPrice.MONEY#")+attributes.kg*evaluate("PRICEL.#getStandartPrice.MONEY#")*getStandartPrice.PRICE>----->
    <cfset FiyA=FiyA+attributes.kg*getStandartPrice.PRICE>
    <cfset FiyT=FiyT+attributes.kg*evaluate("PRICEL.#getStandartPrice.MONEY#")*getStandartPrice.PRICE>
        <!----  <cfif getStandartPrice.MONEY neq getMusteriRisk.MONEY><cfset FiyT=FiyA/evaluate("PRICEL.#getMusteriRisk.MONEY#")><cfelse><cfset FiyT=FiyT+  <cfset FiyT=FiyT+attributes.kg*evaluate("PRICEL.#getStandartPrice.MONEY#")*getStandartPrice.PRICE></cfif>----->
        
</cfloop>



<cfloop query="getKur">
<CFSET "T_FIYAT.#MONEY#"=FiyT/evaluate('PRICEL.#MONEY#')>
</cfloop>
<cfset form.basket_gross_total = T_FIYAT.TL>
<cfset form.basket_tax_total = 0>
<cfset form.basket_otv_total = 0>
<cfset form.basket_discount_total = 0>
<cfset form.basket_net_total = T_FIYAT.TL>
<cfset form.basket_discount_total = 0>
<cfset form.basket_money =getMusteriRisk.MONEY >
<cfset form.basket_rate1 = 1>
<cfset form.basket_rate2 = evaluate("PRICEL.#getMusteriRisk.MONEY#")>
<cfset DSN_ALIAS =dsn>
<cfset DSN1 ="#dsn#_product">
<cfset attributes.kur_say=3>
<cfset attributes.kur_say=3>
<cfset DSN1_ALIAS ="#dsn#_product">
<cfset attributes.order_employee="00">
<cfset attributes.order_employee_id=session.ep.USERID>
  <cfset specer =  CreateObject("component", "mmFunctions")>
    <cfset specer = specer.specer>
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
     <cffunction name="basket_kur_ekle">
        <cfargument name="action_id" required="true">
        <cfargument name="table_type_id" required="true">
        <cfargument name="process_type" required="true">
        <cfargument name="basket_money_db" type="string" default="">
        <cfargument name="transaction_dsn">
        <!---
            by : Arzu BT 20031211
            notes : Basket_money tablosuna islemlere gore kur bilgilerini kaydeder.
            process_type:1 upd 0 add
            transaction_dsn : kullanılan sayfa içinde table dan farklı dsn tanımı olduğu durumlarda kullanılan dsn gönderilir.
            usage :
                invoice:1
                ship:2
                order:3
                offer:4
                servis:5
                stock_fis:6
                internmal_demand:7
                prroduct_catalog 8
                sale_quote:9
                subscription:13
            revisions : javascript version ergün koçak 20040209
            kullanim:
            <cfscript>
                basket_kur_ekle(action_id:MY_ID,table_type_id:1,process_type:0);
            </cfscript>		
        --->
        <cfscript>
            switch (arguments.table_type_id){
                case 1: fnc_table_name="INVOICE_MONEY"; fnc_dsn_name="#dsn2#";break;
                case 2: fnc_table_name="SHIP_MONEY"; fnc_dsn_name="#dsn2#"; break;
                case 3: fnc_table_name="ORDER_MONEY"; fnc_dsn_name="#dsn3#"; break;
                case 4: fnc_table_name="OFFER_MONEY"; fnc_dsn_name="#dsn3#"; break;
                case 5: fnc_table_name="SERVICE_MONEY"; fnc_dsn_name="#dsn3#";break;
                case 6: fnc_table_name="STOCK_FIS_MONEY"; fnc_dsn_name="#dsn2#"; break;
                case 7: fnc_table_name="INTERNALDEMAND_MONEY"; fnc_dsn_name="#dsn3#"; break;
                case 8: fnc_table_name="CATALOG_MONEY"; fnc_dsn_name="#dsn3#"; break;
                case 10: fnc_table_name="SHIP_INTERNAL_MONEY"; fnc_dsn_name="#dsn2#"; break;	
                case 11: fnc_table_name="PAYROLL_MONEY"; fnc_dsn_name="#dsn2#"; break;
                case 12: fnc_table_name="VOUCHER_PAYROLL_MONEY"; fnc_dsn_name="#dsn2#"; break;
                case 13: fnc_table_name="SUBSCRIPTION_CONTRACT_MONEY"; fnc_dsn_name="#dsn3#"; break;			
                case 14: fnc_table_name="PRO_MATERIAL_MONEY"; fnc_dsn_name="#dsn#"; break;
            }
            if(len(arguments.basket_money_db))fnc_dsn_name = "#arguments.basket_money_db#";
        </cfscript>
        <cfif not (isdefined('arguments.transaction_dsn') and len(arguments.transaction_dsn))>
            <cfset arguments.transaction_dsn = fnc_dsn_name>
            <cfset arguments.action_table_dsn_alias = ''>
        <cfelse>
            <cfset arguments.action_table_dsn_alias = '#fnc_dsn_name#.'>
        </cfif>
        <cfif arguments.process_type eq 1>
            <cfquery name="del_money_obj_bskt" datasource="#arguments.transaction_dsn#">
                DELETE FROM 
                    #arguments.action_table_dsn_alias##fnc_table_name#
                WHERE 
                    ACTION_ID=#arguments.action_id#
            </cfquery>
        </cfif>
        <cfloop from="1" to="#attributes.kur_say#" index="fnc_i">
            <cfquery name="add_money_obj_bskt" datasource="#arguments.transaction_dsn#">
                INSERT INTO #arguments.action_table_dsn_alias##fnc_table_name# 
                (
                    ACTION_ID,
                    MONEY_TYPE,
                    RATE2,
                    RATE1,
                    IS_SELECTED
                )
                VALUES
                (
                    #arguments.action_id#,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#wrk_eval('attributes.hidden_rd_money_#fnc_i#')#">,
                    #evaluate("attributes.txt_rate2_#fnc_i#")#,
                    #evaluate("attributes.txt_rate1_#fnc_i#")#,
                    <cfif evaluate("attributes.hidden_rd_money_#fnc_i#") is attributes.BASKET_MONEY>
                        1
                    <cfelse>
                        0
                    </cfif>					
                )
            </cfquery>
        </cfloop>
    </cffunction> 
    <cffunction name="wrk_eval" returntype="string" output="false">
	<!--- loop inen donen satirlarda evaluatten kaynaklanan tirnak isareti sorununu cozer --->
	<cfargument name="gelen" required="no" type="string">
	<cfset wrk_sql_value = "#replaceNoCase(trim(evaluate("#gelen#")),"'","''","ALL")#">
	<cfreturn wrk_sql_value>
</cffunction>
<!-------
Eksik Kayıt
1-PARTNER_ID GELMİYOR SEÇİLİ FİRMANIN YETKİLİSİNİ GETİR ok 
2-ORDER_EMPLOYEE_ID GELMİYOR SESSİONDAN AL ok
3-RESERVED İ ERHAN ABİYE SOR ? ok reserve ediliyor
4-DELIVER_DATE BOŞ GELİYOR TESLİM TARİHİ YİNE BUGÜN OLABİLİR YADA PLANLAMA KARAR VEREBİLİR  ok
5-DISCOUNT_TOTAL NULL 0 YAP ok
6-GROSS_TOTAL NULL FİYAT HESAPLAMASI SONRASI DOLDUR TL TUTAR ok
7-NET_TOTAL NULL FİYAT HESAPLAMASI SONRASI DOLDUR   TL TUTAR ok
8-OTV_TOTAL,TAX_TOTAL NULL 0 YAP ok
9-OTHER_MONEY MÜŞTERİ ÇALIŞILAN PARA BİRİMİNİ GETİR ok
10-OTHER_MONEY VALUE NULL FİYAT HESAPLAMASI SONRASI  DOLDUR #TOTAL ok
11-SHIP_DATE NUL ERHAN ABİYE SOR BU GÜN OLABİLİR ok
12-SHIP_ADRESS NULL MÜŞTERİ KARTINDAN ÇEK 
12-DELIVER_COMP_ID NULL MÜŞTERİ_ID SINI YAZ
13-FRM_BRANCH_ID NULL 1 YAP
14-SHIP_ADRESS_ID -1
15-COUNTRY_ID NULL 1 YAP
Fiyatlar
1- Müşteri Çalışılan Fatura Tipini al
2- Güncel Kuru AL
3- Satırları Dön
4- Fatura Toplam Tutarını Yaz
 -------->


<cfinclude  template="upd_order_pda.cfm">
<!----<cfinclude template="/Modules/labratuvar/query/add_work_include.cfm">
<cfinclude  template="/Modules/labratuvar/query/add_production_order_all_sub.cfm">----->
<cfinclude  template="/Modules/labratuvar/query/porder_func.cfm">
<cfset MainP="">
<cfset SubPorders="0">

<cfquery name="getRows" datasource="#dsn3#">
select * from #dsn3#.ORDER_ROW where ORDER_ROW_ID IN(0
    <cfloop from="1" to="#attributes.rows_#" index="i">
        ,#evaluate("attributes.action_row_id#i#")#
    </cfloop>

) <!---AND ORDER_ROW_ID<>#attributes.ROW_MAIN_ID#---->
</cfquery>
<cfdump  var="#getRows#">
<cfloop query="getRows">
<cfif ORDER_ROW_ID neq attributes.ROW_MAIN_ID>
<cfquery name="getS" datasource="#dsn3#">
	select * from #dsn3#.WORKSTATIONS where STATION_ID IN (
	select WS_ID from #dsn3#.WORKSTATIONS_PRODUCTS 
    where OPERATION_TYPE_ID=(SELECT OPERATION_TYPE_ID FROM #dsn3#.PRODUCT_TREE 
    WHERE STOCK_ID=#getRows.STOCK_ID#)
	) AND COMMENT LIKE '%H%'	
</cfquery>
<cfdump  var="#getS#">

<cfset attributes.process_stage="59">
<cfset attributes.IS_ADD_MULTI_DEMAND="0">
<cfset attributes.IS_CUE_THEORY="1">
<cfset attributes.IS_DEMAND="0">
<cfset attributes.IS_SELECT_SUB_PRODUCT ="1">
<cfset attributes.WORKS_PROG_ID_LIST="">
<cfset attributes.IS_TIME_CALCULATION="0">
<cfset attributes.ORDER_ID="#getRows.ORDER_ID#">
<cfset attributes.ORDER_ROW_ID="#getRows.ORDER_ROW_ID#">
<cfset attributes.PRODUCTION_AMOUNT_LIST="#getRows.QUANTITY#">
<cfset attributes.PRODUCTION_START_DATE_LIST="#dateFormat(now(),'yyyy-mm-dd')#">
<cfset attributes.PRODUCTION_START_H_LIST="00">
<cfset attributes.PRODUCTION_START_M_LIST="00">
<cfset attributes.STATION_ID_LIST="#getS.STATION_ID#,0,0,0,-1,4,4,4,4">
<cfinclude  template="/Modules/labratuvar/query/add_production_order_all_sub.cfm">
<cfset SubPorders="#SubPorders#,#attributes.actionId#">
<cfelse>
<cfinclude template="/Modules/labratuvar/query/add_work_include.cfm">
<cfinclude  template="/Modules/labratuvar/query/add_production_order_all_sub.cfm">
<cfset MainP=attributes.actionId >
</cfif>
</cfloop>
<span style="color:red"><cfdump  var="#SubPorders#"></span><br>
<cfdump  var="#MainP#">
<cfquery name="Upd" datasource="#dsn3#">
    UPDATE PRODUCTION_ORDERS SET PO_RELATED_ID=#MainP# WHERE P_ORDER_ID IN (#SubPorders#)
</cfquery>
<script>
 var elems=document.getElementsByClassName("modal")
 for(let i=0;i<elems.length;i++){
     var modal = bootstrap.Modal.getInstance(elems[i])
     modal.hide()
 }
</script>
