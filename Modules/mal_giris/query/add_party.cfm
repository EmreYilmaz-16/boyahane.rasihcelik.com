

<cfif isDefined("attributes.EX_STOK")>
<cfset attributes.STOCK_ID_LIST="#attributes.KUMAS_CINS_ID#,#attributes.EX_STOK#">
<cfelse>
<cfset attributes.STOCK_ID_LIST="#attributes.KUMAS_CINS_ID#">
</cfif>
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
        SELECT PRICE,PRICE_KDV,MONEY FROM catalyst_prod_product.PRICE_STANDART WHERE PRODUCT_ID=(SELECT PRODUCT_ID FROM catalyst_prod_1.STOCKS WHERE STOCK_ID=#li#) and PRICESTANDART_STATUS=1 and PURCHASESALES=1 
    </cfquery>
    <cfset "attributes.price#i#"=getStandartPrice.PRICE*evaluate("PRICEL.#getStandartPrice.MONEY#")>
    <cfset "attributes.tax#i#"=0>
    <cfset "attributes.row_nettotal#i#"=attributes.kg*evaluate("PRICEL.#getStandartPrice.MONEY#")*getStandartPrice.PRICE>
    <cfset "attributes.duedate#i#"=0>
    <cfset "attributes.other_money_#i#" = getStandartPrice.MONEY>
    <cfset "attributes.other_money_value_#i#" = attributes.kg*getStandartPrice.PRICE>
    <cfset "attributes.price_other#i#"=getStandartPrice.PRICE>
    <cfset "attributes.order_currency#i#"=-1>
    order_currency
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
            transaction_dsn : kullan??lan sayfa i??inde table dan farkl?? dsn tan??m?? oldu??u durumlarda kullan??lan dsn g??nderilir.
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
            revisions : javascript version erg??n ko??ak 20040209
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
Eksik Kay??t
1-PARTNER_ID GELM??YOR SE????L?? F??RMANIN YETK??L??S??N?? GET??R ok 
2-ORDER_EMPLOYEE_ID GELM??YOR SESS??ONDAN AL ok
3-RESERVED ?? ERHAN AB??YE SOR ? ok reserve ediliyor
4-DELIVER_DATE BO?? GEL??YOR TESL??M TAR??H?? Y??NE BUG??N OLAB??L??R YADA PLANLAMA KARAR VEREB??L??R  ok
5-DISCOUNT_TOTAL NULL 0 YAP ok
6-GROSS_TOTAL NULL F??YAT HESAPLAMASI SONRASI DOLDUR TL TUTAR ok
7-NET_TOTAL NULL F??YAT HESAPLAMASI SONRASI DOLDUR   TL TUTAR ok
8-OTV_TOTAL,TAX_TOTAL NULL 0 YAP ok
9-OTHER_MONEY M????TER?? ??ALI??ILAN PARA B??R??M??N?? GET??R ok
10-OTHER_MONEY VALUE NULL F??YAT HESAPLAMASI SONRASI  DOLDUR #TOTAL ok
11-SHIP_DATE NUL ERHAN AB??YE SOR BU G??N OLAB??L??R ok
12-SHIP_ADRESS NULL M????TER?? KARTINDAN ??EK 
12-DELIVER_COMP_ID NULL M????TER??_ID SINI YAZ
13-FRM_BRANCH_ID NULL 1 YAP
14-SHIP_ADRESS_ID -1
15-COUNTRY_ID NULL 1 YAP
Fiyatlar
1- M????teri ??al??????lan Fatura Tipini al
2- G??ncel Kuru AL
3- Sat??rlar?? D??n
4- Fatura Toplam Tutar??n?? Yaz
 -------->


<cfinclude  template="add_order_pda.cfm">