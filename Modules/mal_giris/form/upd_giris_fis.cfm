<cfquery name="getPeriods" datasource=#dsn#>
SELECT * FROM SETUP_PERIOD WHERE OUR_COMPANY_ID=1
</cfquery>

<cfquery name="getirs" datasource="#dsn#">
SELECT * FROM(
    <cfloop query="getPeriods">
    SELECT SIP.PROPERTY1 AS UCRET_DUR, <!-----OK----->
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
ST.IS_INVENTORY,
ST.PRODUCT_ID,
S.SHIP_ID,
S.PARTNER_ID,
S.RECORD_DATE,
#getPeriods.PERIOD_ID# as PERIOD
FROM #dsn#_#getPeriods.PERIOD_YEAR#_#getPeriods.OUR_COMPANY_ID#.SHIP_INFO_PLUS AS SIP
LEFT JOIN #dsn#_#getPeriods.PERIOD_YEAR#_#getPeriods.OUR_COMPANY_ID#.SHIP AS S ON SIP.SHIP_ID=S.SHIP_ID
LEFT JOIN #dsn#_#getPeriods.PERIOD_YEAR#_#getPeriods.OUR_COMPANY_ID#.SHIP_ROW AS SR ON  SR.SHIP_ID=S.SHIP_ID
LEFT JOIN #dsn3#.STOCKS AS ST ON SR.STOCK_ID=ST.STOCK_ID
LEFT JOIN #dsn#.COMPANY AS C ON C.COMPANY_ID=S.COMPANY_ID
LEFT JOIN #dsn3#.SETUP_PROD_RETURN_CATS AS PRTC ON PRTC.RETURN_CAT_ID=CONVERT(INT,SIP.PROPERTY4)
<cfif currentrow neq getPeriods.recordcount> UNION</cfif>
    </cfloop>
) AS TBL
WHERE 1=1 AND PERIOD=#attributes.period# AND SHIP_ID=#attributes.upd_id#
ORDER BY RECORD_DATE DESC
</cfquery>
<cfquery name="getReturnCats" datasource="#dsn#_1">
SELECT * FROM SETUP_PROD_RETURN_CATS ORDER BY RETURN_CAT
</cfquery>
<cfset attributes.company_id=getirs.COMPANY_ID>
<cfset attributes.company_name=getirs.NICKNAME>
<cfset attributes.company_code=getirs.MEMBER_CODE>
<cfset attributes.PARTNER_ID=getirs.PARTNER_ID>
<cfset attributes.PRODUCT_ID=getirs.PRODUCT_ID>
<cfset attributes.PRODUCT_NAME =getirs.PRODUCT_NAME>
<cfset attributes.STOCK_ID=getirs.STOCK_ID>
<cfset attributes.IS_INVENTORY=getirs.IS_INVENTORY>
<cfquery name="getRelOrder" datasource=#dsn3#>
SELECT * FROM ORDER_TO_SHIP_PRT WHERE SHIP_ID=#attributes.upd_id# and PERIOD_ID=#attributes.period#
</cfquery>


<cfform name="frm1" action="#request.self#?fuseaction=mal_giris.emptypopup_upd_giris_fis_query">
<input type="hidden" name="rows_" value=" ,">
<input type="hidden" name="ct_process_type_57" id="ct_process_type_57" value="76">
<input type="hidden" name="ct_process_multi_type_57" id="ct_process_multi_type_57" value="">
<input type="hidden" name="ct_process_type_174" id="ct_process_type_174" value="76">
<input type="hidden" name="ct_process_multi_type_174" id="ct_process_multi_type_174" value="">

    <cfoutput>
    <input type="hidden" name="upd_id" id="upd_id" value="#attributes.upd_id#">
    <input type="hidden" name="ACTIVE_PERIOD" id="ACTIVE_PERIOD" value="#attributes.period#">
    <table class="table table-sm table-borderless">
        <tr>
            <td>
                <label for="parti_kodu" class="form-label">Parti Kodu</label>
                <input class="form-control form-control-sm" id="parti_kodu" type="text" name="parti_kodu" readonly value="#getirs.SHIP_NUMBER#">
            </td>
            <td>
                <label for="ref_no" class="form-label">Ref No</label>
                <input class="form-control form-control-sm" id="ref_no" type="text" name="ref_no" readonly value="#getirs.SHIP_ID#">
            </td>
            <td>
                <label for="date_1" class="form-label">Tarih</label>
                <input class="form-control form-control-sm" id="date_1" type="date" name="date_1" value="#dateformat(getirs.record_date,"yyyy-mm-dd")#" <cfif getRelOrder.recordcount gte 1>readonly</cfif>>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="date_1" class="form-label">Müşteri</label>
                
               <cf_select_customer on_company_select="generatePartCode();getKumas()" frm_name="frm1" readonly="<cfif getRelOrder.recordcount gte 1>0</cfif>">

            </td>
            <td>
                <label for="evr_no" class="form-label">Evrak No</label>
                <input class="form-control form-control-sm" id="evr_no" type="text" name="evr_no" value="#getirs.SHIP_REF_NO#">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="order_no" class="form-label">Sipariş No</label>
                <input class="form-control form-control-sm" id="order_no" type="text" name="order_no" value="#getirs.ORDER_NO#">
            </td>
            <td>
                <label for="ref_no" class="form-label">Evrak No 2</label>
                <input class="form-control form-control-sm" id="evr_no" type="text" name="evr_no2" value="#getirs.EVRAK_NO2#">
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table style="margin-top: 0;margin-bottom: 0;" class="table table-sm table-borderless">
                    <tr>
                        <td>
                            <label  for="metre" class="form-label">Metre</label>
                            <input onchange="generatePartCode()" class="form-control form-control-sm" id="metre" type="text" name="metre" value="#getirs.AMOUNT2#" <cfif getRelOrder.recordcount gte 1>readonly</cfif>>
                        </td>
                        <td>
                            <label for="kilo_gram" class="form-label">Kg</label>
                            <input onchange="generatePartCode()"class="form-control form-control-sm" id="kilo_gram" type="text" name="kilo_gram" value="#getirs.AMOUNT#" <cfif getRelOrder.recordcount gte 1>readonly</cfif>>
                        </td>
                        <td>
                            <label  for="top_ad" class="form-label">Top Ad.</label>
                        <!---   <input type="text"  onchange="generatePartCode()" class="form-control form-control-sm" id="top_ad" name="top_ad" value="#getirs.TOP_ADET#" <cfif getRelOrder.recordcount gte 1>readonly</cfif>>                            ---->
                        <input type="text" name="top_adedi" onchange="generatePartCode()" id="top_adedi" class="form-control form-control-sm" value="#getirs.TOP_ADET#" <cfif getRelOrder.recordcount gte 1>readonly</cfif>>
                        </td>
                        <td>
                            <label for="h_gram" class="form-label">H.Gramaj</label>
                            <input class="form-control form-control-sm" id="h_gram" type="text" name="h_gram" value="#getirs.H_GRAM#" <cfif getRelOrder.recordcount gte 1>readonly</cfif>>
                        </td>
                        <td>
                            <label for="gr_mtul" class="form-label">Gr/Mtül</label>
                            <input class="form-control form-control-sm" id="gr_mtul" type="text" name="gr_mtul" value="#getirs.GR_MTUL#" <cfif getRelOrder.recordcount gte 1>readonly</cfif>>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="aciklama" class="form-label">Açıklama</label>
                <textarea class="form-control" name="aciklama" id="aciklama">#getirs.SHIP_DETAIL#</textarea>
            </td>
            <td style="vertical-align: bottom;">
                <div>
                    <table style="margin-top: 0;margin-bottom: 0;" class="table table-sm table-borderless">
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" <cfif getirs.UCRET_DUR eq 1>checked</cfif> type="radio" name="ucret_dur" id="ucret_dur" value="1" <cfif getRelOrder.recordcount gte 1><cfif getirs.UCRET_DUR eq 0>disabled="true"</cfif></cfif>>
                                    <label class="form-check-label" for="ucret_dur">
                                        Ücretli
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" <cfif getirs.UCRET_DUR eq 0>checked</cfif> type="radio" name="ucret_dur" id="ucret_dur" value="0" <cfif getRelOrder.recordcount gte 1><cfif getirs.UCRET_DUR eq 1>disabled="true"</cfif></cfif>>
                                    <label class="form-check-label" for="ucret_dur">
                                        Ücretsiz
                                    </label>
                                </div>
                            </td>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="kum_dur" id="kum_dur" <cfif getirs.KUMAS_DUR eq 1>checked</cfif> value="1" <cfif getRelOrder.recordcount gte 1><cfif getirs.KUMAS_DUR eq 0>disabled="true"</cfif></cfif> >
                                    <label class="form-check-label" for="kum_dur">
                                        Ham
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="kum_dur" id="kum_dur" <cfif getirs.KUMAS_DUR eq 0>checked</cfif> value="0" <cfif getRelOrder.recordcount gte 1><cfif getirs.KUMAS_DUR eq 1>disabled="true"</cfif></cfif>>
                                    <label class="form-check-label" for="kum_dur">
                                        Boyalı
                                    </label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <label for="iade_neden" class="form-label">İade Nedeni</label>
                <select class="form-control form-control-sm" id="iade_neden" name="iade_neden"
                    aria-label=".form-select-sm example" <cfif getRelOrder.recordcount gte 1>readonly</cfif>>
                    <option value="">Seçiniz</option>
                    <cfloop query="getReturnCats">
                    <option <cfif getirs.IADE_NEDEN_ID eq  RETURN_CAT_ID> selected </cfif>value="#RETURN_CAT_ID#">#RETURN_CAT#</option>
                    </cfloop>

                </select>
            </td>
            <td>
                <label for="gr_mtul" class="form-label">Kumaş Cinsi</label>
                <cf_get_comp_kumas>
            </td>
            <td style="vertical-align: bottom;">
                <div>                  
                    <button type="submit" class="btn btn-warning btn-sm">Güncelle</button>
                    <button type="button" class="btn btn-danger btn-sm">Sil</button>
                </div>
            </td>
        </tr>
    </table>
    </cfoutput>
</cfform>
<script>
function generatePartCode(){
   $("#parti_kodu").val("");
   var metre=$("#metre").val();
   var compcode=$("#company_code").val();
   var top=$("#top_adedi").val();
    $("#parti_kodu").val(compcode+"-"+metre+"-"+top);
    MtulHes();
}
function MtulHes(){
    var metre=$("#metre").val();
    var kg=$("#kilo_gram").val();
    var mtul=(parseFloat(kg)/parseFloat(metre))*1000;
    $("#gr_mtul").val(mtul.toFixed( 2 ))
}

</script>