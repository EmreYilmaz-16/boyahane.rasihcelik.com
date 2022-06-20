<style>
    .aralik {
        height: 3mm;
    }

    td {
        height: 8mm;
    }

    th {
        text-align: left
    }

    table {
        font-family: Arial, Helvetica, sans-serif;
        border-collapse: collapse;
        font-size: medium;

    }

    div {
        font-family: Arial, Helvetica, sans-serif;

    }

    .lubas4 {
        width: 37mm
    }

    .lubas2 {
        width: 74mm
    }
    .lubas1{
        width: 148mm
    }
    .lubasfull{
        width: 100%
    }
    .lubashalf{
        width: 50%;
    }
    .baslik{
        font-weight: bold;
    }
    .ort{
        text-align: center;
    }
    h1,
    h2,
    h3,
    h4,
    h5,
    h6 {
        margin-bottom: 0
    }
</style>
<cfquery name="Sorgu1" datasource="#dsn3#">
SELECT EMAP.PLAN_DETAIL,PO.P_ORDER_NO  FROM #dsn3#.PRODUCTION_ORDERS AS PO,
#dsn3#.EZGI_MASTER_ALT_PLAN AS EMAP,
#dsn3#.EZGI_MASTER_PLAN_RELATIONS AS EMAR
WHERE
PO.P_ORDER_ID=EMAR.P_ORDER_ID
AND EMAR.MASTER_ALT_PLAN_ID=EMAP.MASTER_ALT_PLAN_ID
AND PO.P_ORDER_ID=#attributes.action_id#
</cfquery>
<cfquery name="Sorgu2" datasource="#dsn3#">
SELECT PR.MANUFACT_CODE,POS.PRODUCT_ID,POS.AMOUNT,PO.STOCK_ID,PO.PO_RELATED_ID,PO.QUANTITY,(select P.PRODUCT_NAME from #dsn1#.STOCKS as S ,#dsn1#.PRODUCT as P where S.STOCK_ID=PO.STOCK_ID and S.PRODUCT_ID=P.PRODUCT_ID) AS KODE
FROM #dsn3#.PRODUCTION_ORDERS_STOCKS AS POS
,#dsn1#.PRODUCT AS PR
,#dsn3#.PRODUCTION_ORDERS AS PO
WHERE POS.P_ORDER_ID=#attributes.action_id# AND PR.PRODUCT_ID=POS.PRODUCT_ID AND POS.P_ORDER_ID=PO.P_ORDER_ID
</cfquery>
<cfquery name="AraSorgu" datasource="#dsn3#">
select PO_RELATED_ID FROM #DSN3#.PRODUCTION_ORDERS WHERE P_ORDER_ID=#Sorgu2.PO_RELATED_ID#
</cfquery>
<cfquery name="SORGU3" datasource="#dsn3#">
select PO.PO_RELATED_ID,PC.PRODUCT_CAT,PR.PRODUCT_CODE,PR.PRODUCT_NAME,(select PROPERTY10 from #DSN3#.PRODUCT_INFO_PLUS WHERE PRODUCT_ID=PR.PRODUCT_ID) AS TALIMAT from
#dsn3#.PRODUCTION_ORDERS as PO,
#dsn1#.STOCKS AS S,
#DSN1#.PRODUCT AS PR,
#DSN1#.PRODUCT_CAT AS PC
where P_ORDER_ID=#AraSorgu.PO_RELATED_ID#
AND PO.STOCK_ID=S.STOCK_ID
AND S.PRODUCT_ID=PR.PRODUCT_ID
AND PR.PRODUCT_CATID=PC.PRODUCT_CATID
</cfquery>
	<cfset MRef1=""><cfset MRef2=""><cfset MRef3=""><cfset EAMKOD=""><cfset STROKKOD=""><cfset F1Deger=""><cfset MusteriKodu="">
	<cfset DenemeGas=SORGU3.PRODUCT_NAME>
	<cfset U3=FindNoCase("GAS",DenemeGas)>
	<cfif U3 gt 0>
	<cfset MusteriReferansi12=mid(DenemeGas,1,U3-1)>
	<cfset MusteriKodu=Listgetat(MusteriReferansi12,1,'-')>
	<cfif listLen(MusteriReferansi12,"-") eq 1>
		bir eleman
	</cfif>
	<cfif listLen(MusteriReferansi12,"-") eq 2>
		<cfset MRef1=listGetAt(MusteriReferansi12, 2,"-")>
	</cfif>
	<cfif listLen(MusteriReferansi12,"-") eq 3>
		<cfset MRef1=listGetAt(MusteriReferansi12, 2,"-")>
		<cfset MRef2=listGetAt(MusteriReferansi12, 3,"-")>
	</cfif>
	<cfelse>
	<cfset MRef1="ELS">
	<cfset MRef2="ELS">
	<cfset MRef3="ELS">
	<cfset MusteriKodu="ELS">
	</cfif>
<cfquery name="GetE_AltPlan" datasource="#dsn3#">
select * 
from 
EZGI_MASTER_PLAN_RELATIONS as emar
Where  emar.P_ORDER_ID=#attributes.action_id#
</cfquery>
<cfquery name="GetE_AltPlan2" datasource="#dsn3#">
    SELECT SUM(PO.QUANTITY) as TOTALSSE
        ,PO.STOCK_ID
    FROM #dsn3#.EZGI_MASTER_PLAN_RELATIONS AS Emar
        ,#dsn3#.PRODUCTION_ORDERS_STOCKS AS POS
        ,#dsn3#.PRODUCTION_ORDERS AS PO
    WHERE Emar.MASTER_ALT_PLAN_ID = #GetE_AltPlan.MASTER_ALT_PLAN_ID#
        AND Emar.P_ORDER_ID = POS.P_ORDER_ID
        AND PO.P_ORDER_ID = POS.P_ORDER_ID
        AND Emar.P_ORDER_ID = PO.P_ORDER_ID
    GROUP BY PO.STOCK_ID
    HAVING PO.STOCK_ID = #Sorgu2.STOCK_ID#
</cfquery>
    <cfdump var="Ok3">
<cfset ToplamAdet= GetE_AltPlan2.TOTALSSE>
<cfset BoruUzun=0>
<cfif listLen(SORGU2.KODE,"-") gt 1>
    <cfset BorKode=listGetAt(SORGU2.KODE, 1,"-")>
    <cfset BoruUzun=listGetAt(BorKode, 4,".")>
<cfelse>
    <cfset BorKode=SORGU2.KODE>
    <cfset BoruUzun=listGetAt(BorKode, 4,".")>
</cfif>
<!---
<cfdump var="#SORGU3#">
<cfdump var="#BorKode#">
<cfdump var="#BoruUzun#">

<cfdump var="#GetE_AltPlan#">
<cfdump var="#GetE_AltPlan2#">

<cfdump var="#SORGU3#">--->
<div style="width:148mm;height: 210mm; border:solid 3px blueviolet">
<table border="1" style="width: 100%">
    <tr>
        <td style="text-align: center">
            <h2>BORU İŞLEME İŞ EMRİ</h2>
        </td>
    </tr>
</table>
<div class="aralik"></div>
<table class="lubasfull" border="1">
    <tr>
        <td class="lubas4 baslik">
            Hafta No
        </td>
        <td class="lubas4">
		<cfoutput>
		#Sorgu1.PLAN_DETAIL#
		</cfoutput>
		</td>
        <td class="lubas4 baslik">
            Id No:
        </td>
        <td class="lubas4">
			<cf_workcube_barcode type="code128"  value="#Sorgu1.P_ORDER_NO#" show="1" width="20" height="20"><br>
			<cfoutput>
				#Sorgu1.P_ORDER_NO#
			</cfoutput>
        </td>
    </tr>
</table>
<div class="aralik"></div>
<table class="lubasfull" border="0">
    <tr>
        <td valign="top" class="lubas2">
            <table border="1" class="lubasfull">
                <tr>
                    <td class="lubas4 baslik">
                        Boru Tipi
                    </td>
                    <td class="lubas4">
						<cfoutput>
							#Sorgu2.MANUFACT_CODE#
						</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td class="baslik">
                        Boru Boyu
                    </td>
                    <td>
						<cfoutput>
                            <cfset U=len(BoruUzun)>					
                            <cfif left(BoruUzun,1) eq "0">
                                <cfset BoruUzun=right(BoruUzun, U-1)>
                                <cfif left(BoruUzun,1) eq "0">
                                    <cfset U=len(BoruUzun)>	
                                    <cfset BoruUzun=right(BoruUzun, U-1)>
                                </cfif>
                            </cfif>
                            #BoruUzun#
						</cfoutput>
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table class="lubasfull"  border="1">
                <tr>
                    <td class="lubas4 baslik">
                        Müşteri Kodu
                    </td>
                    <td class="lubas4">
						<cfoutput>
						#MusteriKodu#
						</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td class="baslik">
                        Müşteri Referansı
                    </td>
                    <td>
						<cfoutput>
						#Mref1#-
                        #Mref2#-
                        #Mref3#-
						</cfoutput>
                    </td>
                </tr>
                <tr>
                    <td class="baslik">
                        Adet
                    </td>
                    <td>
						<cfoutput>
						#Sorgu2.QUANTITY#
						</cfoutput>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div class="aralik"></div>
<table class="lubas1" border="1">
    <tr>
        <td class="lubas2 baslik">
            Amortisör Tipi
        </td>
        <td class="lubas2">
		<cfoutput>
			#SORGU3.PRODUCT_CAT#
		</cfoutput>
        </td>
    </tr>
</table>
<div class="aralik"></div>
<div style="width: 100%;height: 20mm;border: solid 1px black">
<span style="font-weight: bold">Boru Talimat:</span><cfoutput>#SORGU3.TALIMAT#</cfoutput>
</div>
<div class="aralik"></div>
<table border="1" class="lubasfull">
    <tr>
        <td class="lubas2 baslik">Toplam Adet</td>
        <td class="lubas2">
        <h5>
        <cfoutput>
        #ToplamAdet#
        </cfoutput>
        </h5>
        </td>
    </tr>
</table>
<div class="aralik"></div>
<table border="1" class="lubasfull">
    <tr>
        <td></td>
        <td  class="baslik ort">Ölçüm 1</td>
        <td class="baslik ort">Ölçüm 2</td>
        <td class="baslik ort">Ölçüm 3</td>
        <td class="baslik ort">Ölçüm 4</td>
        <td class="baslik ort">Ölçüm 5</td>
        <td class="baslik ort">Ölçüm 6</td>
        <td class="baslik ort">Ölçüm 7</td>
    </tr>
    <tr>
        <td class="baslik">Boru Kesme</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td class="baslik" >Boru Havşa</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td class="baslik">Ön Boğum</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
</table>
</div>