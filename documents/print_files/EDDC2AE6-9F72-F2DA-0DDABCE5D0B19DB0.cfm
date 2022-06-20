
    <style>
        .cont-wrap {
            margin: 0 auto !important;
            width: 148mm;
            height: 180mm;
            border: 2px solid #393939;
        }

        body {
            margin: 0 auto;
             width: 148mm;
        }

        #hd-div, .hd-div {
            margin: 0 auto !important;
            width: 147mm;
            border-collapse: collapse;
        }

        .hd-div2 {
            margin-top: 2mm;
        }

        #oneleft {
            margin: 0 auto;
            width: 127mm;
            font-size: 9pt !important;
            border-collapse: collapse;
        }

        #oneright {
            width: 21mm;
            font-size: 9pt !important;
            border-collapse: collapse;
        }

        #ftr-div {
            width: 104mm;
            font-size: 9pt !important;
            border-collapse: collapse;
        }

        .logo {
            width: 34mm;
            padding: 1mm 0;
            height: 10mm;
        }

        #hd-div td, #oneleft td, .oneright {
            border: 1px solid #8d8d8d;
            font-size: 9pt !important;
        }

        .unvn {
            text-align: center;
        }

        .wrpone {
            display: flex;
            margin-top: 2mm;
        }

        .oneright {
            width: 21mm;
        }


        #oneleft4 {
            width: 100%;
            font-size: 9pt !important;
            border-collapse: collapse;
        }

            #oneleft4 td {
                border: 1px solid #8d8d8d;
            }



        .brd {
            border: 1px solid #8d8d8d;
        }

        .fn {
            height: 5mm;
        }

        #elLeft {
            width: 65mm;
            border-left: 1px solid #8d8d8d;
            font-size: 9pt;
            border-collapse: collapse;
            margin-right: 1mm;
        }

            #elLeft td {
                border: 1px solid #8d8d8d;
            }

        #elRght td {
            border: 1px solid #8d8d8d;
        }

        #elRght {
            width: 62mm;
            font-size: 9pt;
            border-collapse: collapse;
        }

        #elLeft2 {
            width: 77mm;
            margin-right: 1mm;
            font-size: 9pt;
            border-collapse: collapse;
            border: 1px solid #000;
            border-top: none;
            border-left: none;
            border-bottom: none;
        }

            #elLeft2 td {
                border: 1px solid #8d8d8d;
            }

            #elLeft2 .nbrd td {
                border: none !important;
            }

        #elRght2 td {
            border: 1px solid #8d8d8d;
        }

        #elRght2 .nbrd td {
            border: none !important;
        }

        #elRght2 {
            width: 70mm;
            font-size: 9pt;
            border-collapse: collapse;
            border: 1px solid #000;
            border-top: none;
            border-right: none;
            border-bottom: none;
        }

        .orm {
            text-align: center;
        }

        .nm {
            text-align: center;
            display: block;
            margin-top: 10%;
            font-weight: bold;
            font-size: 40pt;
            font-family: Arial;
        }

        .aln2 {
            text-align: right;
            padding-right: 10px;
        }

        .hd-div2 {
            border: 1px solid #8d8d8d;
            height: 10mm;
        }

        .twdiv {
            width: 104mm;
            border: 1px solid #8d8d8d;
            margin-top: 2mm;
        }

        .tddv2 {
            width: 104mm;
            border: 1px solid #8d8d8d;
            margin-top: 2mm;
        }

            .tddv2 td {
                border: 1px solid #8d8d8d;
            }

        .twdiv td {
            border: 1px solid #8d8d8d;
        }

        .tbldiv {
            border: 1px solid #8d8d8d;
            margin-top: 2mm;
        }

        .ftr-div {
            width: 104mm;
            border: 1px solid #8d8d8d;
            margin-top: 1mm;
        }

        #ort1 {
            width: 70mm;
            font-size: 9pt;
            border-collapse: collapse;
            border-top: none;
            border-right: none;
            border-left: none;
        }

        #ort2 {
            width: 49mm;
            font-size: 9pt;
            /*border-left: 1px solid #8d8d8d;
            border-right: 1px solid #8d8d8d;*/
            border-collapse: collapse;
        }

        #ort3 {
            width: 41mm;
            font-size: 9pt;
            border-collapse: collapse;
        }

        #ortA1 {
            width: 54mm;
            font-size: 9pt;
            border-collapse: collapse;
        }

        #ortA2 {
            width: 42mm;
            font-size: 8pt;
            /*border-left: 1px solid #8d8d8d;
            border-right: 1px solid #8d8d8d;*/ border-collapse: collapse;
        }

        #ortA3 {
            width: 51mm;
            font-size: 9pt;
            border-collapse: collapse;
        }

        .mntal {
            font-size: 11pt;
            font-family: Arial;
            font-weight: bold;
        }

        .ftrm {
            width: 104mm;
            border: 1px solid #8d8d8d;
            margin-top: 1mm;
        }

        #ftrL {
            height: 55mm;
            width: 104mm;
            margin-top: 1mm;
        }

        .srm {
            width: 19mm;
        }

        .tdow {
            display: flex;
            border: 1px solid #808080;
            margin-top: 1mm;
        }

        .mno {
            display: flex;
            width: 180mm;
            border: 1px solid #8d8d8d;
            border-top: none;
            border-left: none;
            border-right: none;
        }

        .ka {
            font-weight: 900;
            font-family: Arial;
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
        <cfquery name="GetPoID" datasource="#dsn3#">
            SELECT * FROM PRTOTM_PO_REL where BoruId=#attributes.action_id# 
        </cfquery>

    <div class="cont-wrap">
        <div class="hd-div">
            <table id="hd-div">
                <tbody>

                    <tr class="fn">

                        <td class="unvn" colspan="3"><h1 style="margin-top:3mm;">BORU İŞLEME İŞ EMRİ</h1></td>

                    </tr>
                </tbody>
            </table>
        </div>
        <div class="wrpone">
            <div class="oneleft">
                <table id="oneleft">
                    <tbody>
                        <tr style="height:12mm">
                            <td><b>Hafta No</b></td>
                            <td>
                                <cfoutput>
                                #Sorgu1.PLAN_DETAIL#
                                </cfoutput>                            
                            </td>
                            <td><b>ID No</b></td>


                            <td style="text-align:center">
                                <cf_workcube_barcode type="code128"  value="#Sorgu1.P_ORDER_NO#" show="1" width="20" height="20"><br>
                                <cfoutput>
                                    #Sorgu1.P_ORDER_NO#
                                </cfoutput>                            
                            </td>

                        </tr>
                        <tr style="height:12mm">
                            <td><b>Boru Tipi</b></td>
                            <td>
                                <cfoutput>
                                    #Sorgu2.MANUFACT_CODE#
                                </cfoutput>
                            </td>
                            <td><b>Boru Boyu</b></td>


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
                    </tbody>
                </table>
               

            </div>
            <div class="oneright">
                <table id="oneright">
                    <tbody>

                        <tr>
                            <td>
                                <span class="nm"><cfoutput>
                                #GetPoID.Id#
                                </cfoutput></span>
                            </td>

                        </tr>


                    </tbody>
                </table>
            </div>
        </div>
        <div class="tdow" style="">
            <table id="elLeft2">
                <tbody>
                    <tr style="height:8mm">
                        <td style="border-top:none;border-left:none;"><b>Müşteri Kodu</b></td>
                        <td style="border-top:none;">
						<cfoutput>
						#MusteriKodu#
						</cfoutput>
                        </td>

                    </tr>
                    <tr style="height:8mm">
                        <td style="border-top:none;border-left:none;"><b>Müşteri Referansı</b></td>
                        <td style="border-top:none;">
						<cfoutput>
						#Mref1#-
                        #Mref2#-
                        #Mref3#-
						</cfoutput>
                        </td>

                    </tr>

                </tbody>
            </table>
            <table id="elRght2">
                <tbody>
                    <tr style="height:8mm">
                        <td style="border-top:none;"><b>Amortisör Tipi</b></td>
                        <td style="border-top:none;border-right:none;">
                            <cfoutput>
                                #SORGU3.PRODUCT_CAT#
                            </cfoutput>
                        </td>

                    </tr>
                    <tr style="height:8mm">
                        <td style="border-top:none;"><b>Toplam Adet</b></td>
                        <td style="border-top:none;border-right:none;">
                            <cfoutput>
                            #ToplamAdet#
                            </cfoutput>
                        </td>

                    </tr>

                </tbody>
            </table>
        </div>
        <div class="hd-div2">
            <h3 style="margin-top:1mm;">BORU TALİMATLARI</h3>

        </div>
     
        <div class="tbldiv">
            <table id="oneleft4">
                <tbody>

                    <tr style="height:8mm">

                        <td class="aln" style="border-left:none;border-top:none;"><b></b></td>
                        <td class="aln" style="border-top:none;"><b>Ölçüm</b></td>
                        <td class="aln" style="border-top:none;"><b>Ölçüm</b></td>
                        <td class="aln" style="border-top:none;"><b>Ölçüm</b></td>
                        <td class="aln" style="border-top:none;"><b>Ölçüm</b></td>
                        <td class="aln" style="border-top:none;"><b>Ölçüm</b></td>
                        <td class="aln" style="border-right:none;border-top:none;"><b>Ölçüm</b></td>


                    </tr>
                    <tr style="height:8mm">

                        <td class="aln" style="border-left:none;">Boru Kesme</td>
                        <td class="aln "></td>
                        <td class="aln "></td>
                        <td class="aln"></td>
                        <td class="aln"></td>
                        <td class="aln"></td>
                        <td class="aln"></td>



                    </tr>
                    <tr style="height:8mm">

                        <td class="aln" style="border-left:none;">Boru Havşa</td>
                        <td class="aln"></td>
                        <td class="aln"></td>
                        <td class="aln"></td>
                        <td class="aln"></td>
                        <td class="aln"></td>
                        <td class="aln"></td>

                    </tr>
           
                    <tr style="height:8mm">

                        <td class="aln" style="border-left:none;border-bottom:none;">Ön Boğum</td>
                        <td class="aln" style="border-bottom:none;"></td>
                        <td class="aln" style="border-bottom:none;"></td>
                        <td class="aln" style="border-bottom:none;"></td>
                        <td class="aln" style="border-bottom:none;"></td>
                        <td class="aln" style="border-bottom:none;"></td>
                        <td class="aln" style="border-bottom:none;"></td>

                    </tr>
                </tbody>
            </table>
        </div>
    </div>
