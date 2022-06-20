<cfquery name="getPeriods" datasource=#dsn#>
SELECT * FROM SETUP_PERIOD WHERE OUR_COMPANY_ID=1
</cfquery>

<cfquery name="getirs" datasource="#dsn#">
SELECT top 10  * FROM(
    <cfloop query="getPeriods">
    SELECT  SIP.PROPERTY1 AS UCRET_DUR, <!-----OK----->
SIP.PROPERTY2  AS KUMAS_DUR, <!-----OK----->
SIP.PROPERTY3  AS EVRAK_NO2, <!-----OK----->
PRTC.RETURN_CAT  AS IADE_NEDEN,<!-----OK----->
SIP.PROPERTY4  AS IADE_NEDEN_ID,<!-----OK----->
SIP.PROPERTY5  AS GR_MTUL, <!-----OK----->
SIP.PROPERTY6  AS TOP_ADET, <!-----OK----->
SIP.PROPERTY7  AS H_GRAM, <!-----OK----->
SIP.PROPERTY8  AS ORDER_NO, <!-----OK----->
S.SHIP_NUMBER,<!-----OK----->
S.LOCATION_IN,<!-----OK----->
S.DEPARTMENT_IN,<!-----OK----->
SR.AMOUNT AS AMOUNT,<!-----OK----->
SR.AMOUNT2 AS AMOUNT2,<!-----OK----->
ST.PRODUCT_NAME,<!-----OK----->
ST.PRODUCT_CODE_2,<!-----OK----->
C.MEMBER_CODE,<!-----OK----->
C.NICKNAME,<!-----OK----->
C.COMPANY_ID,
S.REF_NO AS SHIP_REF_NO,<!-----OK----->
S.SHIP_DETAIL,
ST.STOCK_ID,
S.SHIP_ID,
S.RECORD_DATE,
#getPeriods.PERIOD_ID# as PERIOD
FROM catalyst_prod_#getPeriods.PERIOD_YEAR#_#getPeriods.OUR_COMPANY_ID#.SHIP_INFO_PLUS AS SIP
LEFT JOIN catalyst_prod_#getPeriods.PERIOD_YEAR#_#getPeriods.OUR_COMPANY_ID#.SHIP AS S ON SIP.SHIP_ID=S.SHIP_ID
LEFT JOIN catalyst_prod_#getPeriods.PERIOD_YEAR#_#getPeriods.OUR_COMPANY_ID#.SHIP_ROW AS SR ON  SR.SHIP_ID=S.SHIP_ID
LEFT JOIN #dsn3#.STOCKS AS ST ON SR.STOCK_ID=ST.STOCK_ID
LEFT JOIN catalyst_prod.COMPANY AS C ON C.COMPANY_ID=S.COMPANY_ID
LEFT JOIN #dsn3#.SETUP_PROD_RETURN_CATS AS PRTC ON PRTC.RETURN_CAT_ID=CONVERT(INT,SIP.PROPERTY4)
<cfif currentrow neq getPeriods.recordcount> UNION</cfif>
    </cfloop>
) AS TBL
WHERE TBL.LOCATION_IN=6 AND TBL.DEPARTMENT_IN=4
ORDER BY RECORD_DATE DESC
</cfquery>

<table class="table table-sm table-striped">
    <thead>
        <tr>
            <th>Müşteri</th>
            <th>Giriş No</th>
            <th>K.G</th>
            <th>Metre</th>
            <th>Giriş Tarihi</th>
        </tr>
    </thead>
    <tbody>
        <cfoutput query="getirs">
        <tr>
            <td>#NICKNAME#</td>
            <td><a href="##" onclick="openModal_partner('index.cfm?fuseaction=mal_giris.emptypopup_ajaxpage_detail_mal_giris&upd_id=#SHIP_ID#&period=#PERIOD#','modal-lg')">#SHIP_NUMBER#</td>
            <td>#AMOUNT#</td>
            <td>#AMOUNT2#</td>
            <td>#dateformat(RECORD_DATE,"dd/mm/yyyy")#</td>
        </cfoutput>
    </tbody>
</table>