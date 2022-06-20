
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
S.SHIP_ID,
ST.PRODUCT_ID,
ST.IS_INVENTORY,
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

<div class="card">
<div class="card-header">Giriş Fişi Özet </div>
<div class="card-body">
<!---<div style="border-bottom:solid 3px #1ABC9C;resize:vertical;overflow:auto;margin-left:5px">
<h2 style="font-size: 20pt !important;margin-left: 20px"> Giriş Fişi Özet </h2>---->
<cfquery name="getReturnCats" datasource="#dsn#_1">
SELECT * FROM SETUP_PROD_RETURN_CATS ORDER BY RETURN_CAT
</cfquery>
<cfform name="frm1" action="#request.self#?fuseaction=mal_giris.emptypopup_add_fis_query">
<input type="hidden" name="rows_" value=" ,">
<input type="hidden" name="ct_process_type_57" id="ct_process_type_57" value="76">
<input type="hidden" name="ct_process_multi_type_57" id="ct_process_multi_type_57" value="">
<input type="hidden" name="ct_process_type_174" id="ct_process_type_174" value="76">
<input type="hidden" name="ct_process_multi_type_174" id="ct_process_multi_type_174" value="">
<input type="hidden" name="deliver_date_m" value="0">
<input type="hidden" name="deliver_date_h" value="00">

<cfoutput>
<input type="hidden" name="deliver_date_frm" value="#day(now())#/#month(now())#/#year(now())#">
</cfoutput>
<cfoutput query="getirs">
<cfset attributes.product_id=PRODUCT_ID>
<cfset attributes.product_name=PRODUCT_NAME>
<cfset attributes.STOCK_ID=STOCK_ID>
<cfset attributes.IS_INVENTORY=IS_INVENTORY>
    <table class="table table-sm table-borderless">
        <tr>
            <td>
                <label for="parti_kodu" class="form-label">Parti Kodu</label>
                <input class="form-control form-control-sm" id="parti_kodu" type="text" name="parti_kodu" value="#SHIP_NUMBER#" readonly>
            </td>
            <td>
                <label for="ref_no" class="form-label">Ref No</label>
                <input class="form-control form-control-sm" id="ref_no" type="text" name="ref_no" value="#SHIP_ID#"  readonly>
            </td>
            <td>
                <label for="date_1" class="form-label">Tarih</label>
                <input class="form-control form-control-sm" id="date_1" type="date" name="date_1" value="#dateformat(RECORD_DATE,'yyyy-mm-dd')#" readonly>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="date_1" class="form-label">Müşteri</label>
               <!----<cf_select_customer on_company_select="generatePartCode();getKumas()" frm_name="frm1" readonly="1">---->
                <div class="input-group">
                    <input style="flex: 0 0 auto;width: 15%;" class="form-control form-control-sm" type="text" id="company_code" name="company_code" value="#MEMBER_CODE#" readonly="">
                    <input oninput="getComp(this)" style="flex: 0 0 auto;width:75%" class="form-control form-control-sm" type="text" id="company_name"value="#NICKNAME#" name="company_name" autocomplete="off" readonly="">            
                    <button type="button" style="width: 10%;font-size: 14pt;padding: 0" onclick="SelectCustomer()" class="btn btn-sm btn-outline-success" disabled=""><i class="fas fa-users"></i></button>
                </div>
            </td>
            <td>
                <label for="evr_no" class="form-label">Evrak No</label>
                <input class="form-control form-control-sm" id="evr_no" type="text" value="#SHIP_REF_NO#" name="evr_no" readonly>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="order_no" class="form-label">Sipariş No</label>
                <input class="form-control form-control-sm" id="order_no" type="text"  value="#ORDER_NO#" name="order_no" readonly>
            </td>
            <td>
                <label for="ref_no" class="form-label">Evrak No 2</label>
                <input class="form-control form-control-sm" id="evr_no_2" type="text" value="#EVRAK_NO2#" name="evr_no_2" readonly>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table style="margin-top: 0;margin-bottom: 0;" class="table table-sm table-borderless">
                    <tr>
                        <td>
                            <label  for="metre" class="form-label">Metre</label>
                            <input onchange="generatePartCode()" class="form-control form-control-sm" id="metre" value="#AMOUNt2#" type="text" name="metre" readonly>
                        </td>
                        <td>
                            <label for="kilo_gram" class="form-label">Kg</label>
                            <input onchange="generatePartCode()"class="form-control form-control-sm" id="kilo_gram" value="#AMOUNT#" type="text" name="kilo_gram" readonly>
                        </td>
                        <td>
                            <label  for="top_ad" class="form-label">Top Ad.</label>
                            <input onchange="generatePartCode()" class="form-control form-control-sm" id="top_ad" value="#TOP_ADET#" type="text" name="top_ad" readonly>
                        </td>
                        <td>
                            <label for="h_gram" class="form-label">H.Gramaj</label>
                            <input class="form-control form-control-sm" id="h_gram" type="text"  value="#H_GRAM#" name="h_gram" readonly>
                        </td>
                        <td>
                            <label for="gr_mtul" class="form-label">Gr/Mtül</label>
                            <input class="form-control form-control-sm" id="gr_mtul" type="text" value="#GR_MTUL#" name="gr_mtul" readonly>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="aciklama" class="form-label">Açıklama</label>
                <textarea class="form-control" name="aciklama" id="aciklama" readonly>#SHIP_DETAIL#</textarea>
            </td>
            <td style="vertical-align: bottom;">
                <div>
                    <table style="margin-top: 0;margin-bottom: 0;" class="table table-sm table-borderless">
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" <cfif UCRET_DUR eq "1">checked</cfif>  type="radio" name="ucret_dur_" id="ucret_dur_on" disabled>
                                    <label class="form-check-label" for="ucret_dur">
                                        Ücretli
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" <cfif UCRET_DUR eq "0">checked</cfif> type="radio" name="ucret_dur" id="ucret_dur_off" disabled>
                                    <label class="form-check-label" for="ucret_dur">
                                        Ücretsiz
                                    </label>
                                </div>
                            </td>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" <cfif KUMAS_DUR eq "1">checked</cfif> type="radio" name="kum_dur" id="kum_dur_on" disabled>
                                    <label class="form-check-label" for="kum_dur">
                                        Ham
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" <cfif KUMAS_DUR eq "0">checked</cfif> type="radio" name="kum_dur" id="kum_dur_off"  disabled>
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
                <select class="form-select form-select-sm" id="iade_neden" name="iade_neden"
                    aria-label=".form-select-sm example" disabled>
                    <option value="">Seçiniz</option>
                    <cfloop query="getReturnCats">
                    <option <cfif getirs.IADE_NEDEN_ID eq RETURN_CAT_ID>selected</cfif>  value="#RETURN_CAT_ID#">#RETURN_CAT#</option>
                    </cfloop>

                </select>
            </td>
            <td>
                <label for="gr_mtul" class="form-label">Kumaş Cinsi</label>
                <cf_get_comp_kumas readonly="1">
            </td>
            <td style="vertical-align: bottom;">
                <div>
                    <button disabled class="btn btn-success btn-sm">Kaydet</button>
                    <button disabled class="btn btn-warning btn-sm">Güncelle</button>
                    <button disabled class="btn btn-danger btn-sm">Sil</button>
                </div>
            </td>
        </tr>
    </table>
    </cfoutput>
</cfform>
</div>
</div>