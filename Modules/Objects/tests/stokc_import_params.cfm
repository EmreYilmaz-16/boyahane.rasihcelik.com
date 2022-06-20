<cfquery name="getP" datasource="#dsn1#">
    SELECT P.PRODUCT_CODE,PU.PRODUCT_UNIT_ID FROM PRODUCT AS P
    LEFT JOIN #DSN3#.PRODUCT_UNIT AS PU ON PU.PRODUCT_ID=P.PRODUCT_ID
    
     WHERE P.PRODUCT_ID=#EKLENECEK.URUN_ID#
</cfquery>

<cfquery name="stock_count" datasource="#DSN3#">
	SELECT STOCK_ID FROM STOCKS WHERE PRODUCT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#EKLENECEK.URUN_ID#">
</cfquery>
<cfset FORM.NEW_STOCK_CODE = "#getP.PRODUCT_CODE#.#stock_count.RECORDCOUNT+1#">
  <cfquery name="get_barcode_no" datasource="#dsn1#">
                            SELECT LEFT(BARCODE, 12) AS BARCODE FROM PRODUCT_NO
                        </cfquery>
                        <cfset barcode = (get_barcode_no.barcode*1)+1>
                        <cfquery name="upd_barcode_no" datasource="#dsn1#">
                            UPDATE PRODUCT_NO SET BARCODE = '#barcode#X'
                        </cfquery>

<CFSET FORM.BARCOD="#barcode#">
<CFSET FORM.PRODUCT_ID=EKLENECEK.URUN_ID>
<CFSET attributes.property_count=0>
<cfset STOCK_CODE_2=EKLENECEK.RENK_KODU>
<cfset FORM.PROPERTY_DETAIL=EKLENECEK.RENK_ADI>
<cfset FORM.UNIT=getP.PRODUCT_UNIT_ID>
<cfset FORM.MANUFACT_CODE ="">