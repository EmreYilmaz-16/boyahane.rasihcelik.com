
<cfquery name="getPOrders" datasource="#dsn3#">
SELECT 
S.PRODUCT_NAME,
S.PROPERTY,
S.STOCK_CODE_2,
C.COMPANY_ID,
S.STOCK_ID,
PO.P_ORDER_ID,
POR.ORDER_ID,
O.ORDER_NUMBER,
O.ORDER_HEAD,
ORR.AMOUNT2,
ORR.QUANTITY,
PO.PROD_ORDER_STAGE,
PO.STATION_ID,
C.NICKNAME
 FROM catalyst_prod_1.PRODUCTION_ORDERS AS PO 
LEFT JOIN catalyst_prod_1.STOCKS AS S ON S.STOCK_ID=PO.STOCK_ID
LEFT JOIN catalyst_prod.COMPANY AS C ON C.COMPANY_ID=S.COMPANY_ID
LEFT JOIN catalyst_prod_1.PRODUCTION_ORDERS_ROW AS POR ON POR.PRODUCTION_ORDER_ID=PO.P_ORDER_ID
LEFT JOIN catalyst_prod_1.ORDER_ROW  AS ORR ON ORR.ORDER_ROW_ID=POR.ORDER_ROW_ID
LEFT JOIN catalyst_prod_1.ORDERS AS O ON O.ORDER_ID=ORR.ORDER_ID
WHERE PO.PROD_ORDER_STAGE=59  AND PO.STATION_ID IN (SELECT STATION_ID FROM catalyst_prod_1.WORKSTATIONS WHERE UP_STATION=#attributes.up_station#)
</cfquery>
<cfdump  var="#getPOrders#">
<div class="card">
    <div class="card-header">Parti Seç</div>
    <div clas="card-body">
        <table class="table table-sm table-striped">
        <cfoutput query="getPOrders">
        <tr>
        <td>#NICKNAME#</td>
        <td><a href="##" onclick="PartiEkle(#P_ORDER_ID#,#STOCK_ID#,#QUANTITY#,'#NICKNAME#','#PROPERTY#','#PRODUCT_NAME#',this)">#PRODUCT_NAME#</a></td>
        <td>#PROPERTY#</td>
        <td>#QUANTITY#</td>
        </tr>
        </cfoutput>
        </table>
    </div>
</div>

<script>
<cfinclude  template="list_emir_ajax.js">
</script>