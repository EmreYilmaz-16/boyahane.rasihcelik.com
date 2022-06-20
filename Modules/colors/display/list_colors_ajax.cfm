<cfquery name="getColors" datasource="#dsn3#">
SELECT S.PROPERTY,S.STOCK_CODE_2,S.STOCK_ID,C.NICKNAME,PC.PRODUCT_CAT FROM catalyst_prod_1.STOCKS AS S 
LEFT JOIN catalyst_prod.COMPANY AS C ON C.COMPANY_ID=S.COMPANY_ID
LEFT JOIN catalyst_prod_product.PRODUCT_CAT AS PC ON PC.PRODUCT_CATID=S.PRODUCT_CATID
WHERE PROPERTY IS NOT NULL AND LEN(TRIM(PROPERTY))<>0 AND C.NICKNAME IS NOT NULL
</cfquery>
<table class="table table-sm">
<cfoutput query="getColors">
    <tr>
        <td><a class="btn btn-link" onclick='coppyColorF(#STOCK_ID#)'>#PROPERTY#</a><td>
        <td>#STOCK_CODE_2#<td>
        <td>#PRODUCT_CAT#<td>
        <td>#NICKNAME#<td>
    </tr>
</cfoutput>
</table>