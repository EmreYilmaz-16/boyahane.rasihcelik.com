

<cfquery name="getParty" datasource="#dsn#">
    SELECT * FROM catalyst_prod_1.ORDERS WHERE ORDER_ID=(SELECT ORDER_ID FROM catalyst_prod_1.ORDER_ROW WHERE ORDER_ROW_ID=#attributes.action_id# )
</cfquery>
<cfquery name="getPartyR" datasource="#dsn#">
    SELECT * FROM catalyst_prod_1.ORDER_ROW  WHERE ORDER_ROW_ID=#attributes.action_id# 
</cfquery>
<cfquery name="getPartyINF" datasource="#dsn#">
select * from catalyst_prod_1.ORDER_TO_SHIP_PRT where ORDER_ID=#getParty.ORDER_ID#
</cfquery>
<cfquery name="getInfoPlus" datasource="#dsn#">
SELECT * FROM catalyst_prod_1.ORDER_INFO_PLUS where  ORDER_ID=#getParty.ORDER_ID#
</cfquery>

<cfquery name="getPer" datasource="#dsn#">
    SELECT PERIOD_YEAR,OUR_COMPANY_ID FROM SETUP_PERIOD WHERE PERIOD_ID=#getPartyINF.PERIOD_ID#
</cfquery>

<cfquery name="getShiprow" datasource="#dsn#">
    SELECT * FROM #DSN#_#getPer.PERIOD_YEAR#_#getPer.OUR_COMPANY_ID#.SHIP_ROW WHERE SHIP_ID=#getPartyINF.SHIP_ID#
</cfquery>

<cfset dsn3="#dsn#_#getPer.OUR_COMPANY_ID#">
<cfquery name="getCom"datasource="#dsn#">
SELECT * FROM COMPANY WHERE COMPANY_ID=#getParty.COMPANY_ID#
</cfquery>

<div style="width:105mm;border:solid 1px">
<cfoutput>
<table class="table">
<tr >
<td colspan="2" style="font-size:14pt!important;text-align:center">Parti Refakat Kartı</td>
</tr>
<tr><td colspan=""><div style="text-align:center"><cf_partner_barcode type="code128" value="#getParty.ORDER_HEAD#" show="1" width="20" height="50"><br><div style="text-align:center">#getParty.ORDER_HEAD#</div></div></td><td></td></tr>
<tr>
<td style="width:30%">Müşteri</td>
<td>#getCom.NICKNAME#</td>
</tr>
<tr>
<td>Kumaş Tipi</td>

<td>#getShiprow.NAME_PRODUCT#</td>

</tr>
<tr>
<td>Parti Miktari</td>
<td>#getPartyR.QUANTITY#/#getShiprow.AMOUNT#</td>
</tr>

</table>

</cfoutput>
</div>