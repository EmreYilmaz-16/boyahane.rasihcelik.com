

<cfquery name="getPer" datasource="#dsn#">
    SELECT PERIOD_YEAR,OUR_COMPANY_ID FROM SETUP_PERIOD WHERE PERIOD_ID=#attributes.iid#
</cfquery>

<cfset new_dsn2="#dsn#_#getPer.PERIOD_YEAR#_#getPer.OUR_COMPANY_ID#">
<cfquery name="getShip" datasource="#dsn#">
    SELECT * FROM #DSN#_#getPer.PERIOD_YEAR#_#getPer.OUR_COMPANY_ID#.SHIP WHERE SHIP_ID=#attributes.action_id#
</cfquery>
<cfquery name="getShiprow" datasource="#dsn#">
    SELECT * FROM #DSN#_#getPer.PERIOD_YEAR#_#getPer.OUR_COMPANY_ID#.SHIP_ROW WHERE SHIP_ID=#attributes.action_id#
</cfquery>
<cfquery name="getShipInfo" datasource="#dsn#">
    SELECT PROPERTY3 AS EVRAK_NO,PROPERTY5 AS GRMTUL,PROPERTY6 AS TOPS,PROPERTY7 AS HGRAM,PROPERTY1 AS UCRET, PROPERTY2 AS HAM,PROPERTY8 AS SIPNO  FROM #DSN#_#getPer.PERIOD_YEAR#_#getPer.OUR_COMPANY_ID#.SHIP_INFO_PLUS WHERE SHIP_ID=#attributes.action_id#
</cfquery>
<cfquery name="getCom"datasource="#dsn#">
SELECT * FROM COMPANY WHERE COMPANY_ID=#getShip.COMPANY_ID#
</cfquery>
<div style="width:148mm;border:solid 1px">
<cfoutput>
<table class="table table-sm">
<tr >
<td colspan="4" style="font-size:14pt!important;text-align:center;font-weight:bold">Kumaş Giriş Kartı</td>
</tr>
<tr><td colspan="2"><div style="text-align:center"><cf_partner_barcode type="code128" value="#getShip.SHIP_NUMBER#" show="1" width="20" height="50"><br><div style="text-align:center">#getShip.SHIP_NUMBER#</div></div></td><td colspan="2"></td></tr>
<tr>
<td style="width:30%"><b>Müşteri</b></td>
<td colspan="3">#getCom.NICKNAME#</td>
</tr>
<tr>
<td><b>Kumaş Tipi</b></td>

<td colspan="3">#getShiprow.NAME_PRODUCT#</td>

</tr>
<tr>
<td><b>Giriş Miktari</b></td>
<td>#getShiprow.AMOUNT# KG </td>
<td>#getShiprow.AMOUNT2# M </td>
<td>#getShipInfo.TOPS# TOP </td>
</tr>
<tr><td><b>Ucret :</b><cfif getShipInfo.ucret eq "on">Ücretli<cfelse>Ücretsiz</cfif></td><td colspan="3"><b>Boya :</b><cfif getShipInfo.HAM eq "on">Ham<cfelse>Boyalı</cfif></td> </tr>
<tr>
<td><b>Sipariş No:</b>#getShipInfo.SIPNO#</td>
<td><b>Evrak No:</b>#getShip.REF_NO#</td>
<td><b>Evrak No 2:</b>#getShipInfo.EVRAK_NO#</td>
<td><b>Giriş Tarihi:</b>#dateformat(getShip.SHIP_DATE,"dd/mm/yyy")#</td>
</tr>
</table>

</cfoutput>
</div>