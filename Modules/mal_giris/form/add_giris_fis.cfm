<cfset attributes.company_id="">
<cfset attributes.company_name="">
<cfset attributes.company_code="">
<cfset attributes.PARTNER_ID="">
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
    <table class="table table-sm table-borderless">
        <tr>
            <td>
                <label for="parti_kodu" class="form-label">Parti Kodu</label>
                <input class="form-control form-control-sm" id="parti_kodu" type="text" name="parti_kodu" readonly>
            </td>
            <td>
                <label for="ref_no" class="form-label">Ref No</label>
                <input class="form-control form-control-sm" id="ref_no" type="text" name="ref_no" readonly>
            </td>
            <td>
                <label for="date_1" class="form-label">Tarih</label>
                <input class="form-control form-control-sm" id="date_1" type="date" name="date_1">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="date_1" class="form-label">Müşteri</label>
               <cf_select_customer on_company_select="generatePartCode();,getKumas();" frm_name="frm1">

            </td>
            <td>
                <label for="evr_no" class="form-label">Evrak No</label>
                <input class="form-control form-control-sm" id="evr_no" type="text" name="evr_no">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="order_no" class="form-label">Sipariş No</label>
                <input class="form-control form-control-sm" id="order_no" type="text" name="order_no">
            </td>
            <td>
                <label for="ref_no" class="form-label">Evrak No 2</label>
                <input class="form-control form-control-sm" id="evr_no_2" type="text" name="evr_no_2">
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table style="margin-top: 0;margin-bottom: 0;" class="table table-sm table-borderless">
                    <tr>
                        <td style="width:10%">
                            <label  for="metre" class="form-label">Metre</label>
                            <input onchange="generatePartCode()" class="form-control form-control-sm" id="metre" type="text" name="metre">
                        </td>
                        <td style="width:10%">
                            <label for="kilo_gram" class="form-label">Kg</label>
                            <input onchange="generatePartCode()"class="form-control form-control-sm" id="kilo_gram" type="text" name="kilo_gram">
                        </td>
                        <td style="width:10%">
                            <label  for="top_ada" class="form-label">Top Ad.</label>
                            <input type="text" onchange="generatePartCode()" class="form-control form-control-sm" id="top_adedi"  name="top_adedi">
                        </td>
                        <td style="width:10%">
                            <label for="h_gram" class="form-label">H.Gramaj</label>
                            <input class="form-control form-control-sm" id="h_gram" type="text" name="h_gram">
                        </td>
                        <td style="width:10%">
                            <label for="gr_mtul" class="form-label">Gr/Mtül</label>
                            <input class="form-control form-control-sm" id="gr_mtul" type="text" name="gr_mtul">
                        </td>
                        <td style="width:50%"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="aciklama" class="form-label">Açıklama</label>
                <textarea class="form-control" name="aciklama" id="aciklama"></textarea>
            </td>
            <td style="vertical-align: bottom;">
                <div>
                    <table style="margin-top: 0;margin-bottom: 0;" class="table table-sm table-borderless">
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="ucret_dur" id="ucret_dur" value="1">
                                    <label class="form-check-label" for="ucret_dur">
                                        Ücretli
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="ucret_dur" id="ucret_dur" value="0">
                                    <label class="form-check-label" for="ucret_dur">
                                        Ücretsiz
                                    </label>
                                </div>
                            </td>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="kum_dur" id="kum_dur" value="1">
                                    <label class="form-check-label" for="kum_dur">
                                        Ham
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="kum_dur" id="kum_dur" value="0">
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
                    aria-label=".form-select-sm example">
                    <option value="">Seçiniz</option>
                    <cfoutput query="getReturnCats">
                    <option value="#RETURN_CAT_ID#">#RETURN_CAT#</option>
                    </cfoutput>

                </select>
            </td>
            <td>
                <label for="gr_mtul" class="form-label">Kumaş Cinsi</label>
                <cfparam  name="attributes.product_id" default="">
                <cfparam  name="attributes.PRODUCT_NAME" default="">
                <cfparam  name="attributes.STOCK_ID" default="">
                <cfparam  name="attributes.IS_INVENTORY" default="">
                <cf_get_comp_kumas>
            </td>
            <td style="vertical-align: bottom;">
                <div>
                    <button class="btn btn-success btn-sm">Kaydet</button>
                    <button class="btn btn-warning btn-sm">Güncelle</button>
                    <button class="btn btn-danger btn-sm">Sil</button>
                </div>
            </td>
        </tr>
    </table>
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