<div style="border-bottom:solid 3px #1ABC9C;resize:vertical;overflow:auto;margin-left:5px">
<h2 style="font-size: 20pt !important;margin-left: 20px"> Giriş Fişi Özet </h2>
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
                <input class="form-control form-control-sm" id="date_1" type="text" name="date_1" readonly>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="date_1" class="form-label">Müşteri</label>
               <cf_select_customer on_company_select="generatePartCode();getKumas()" frm_name="frm1" readonly="1">

            </td>
            <td>
                <label for="evr_no" class="form-label">Evrak No</label>
                <input class="form-control form-control-sm" id="evr_no" type="text" name="evr_no" readonly>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="order_no" class="form-label">Sipariş No</label>
                <input class="form-control form-control-sm" id="order_no" type="text" name="order_no" readonly>
            </td>
            <td>
                <label for="ref_no" class="form-label">Evrak No 2</label>
                <input class="form-control form-control-sm" id="evr_no_2" type="text" name="evr_no_2" readonly>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table style="margin-top: 0;margin-bottom: 0;" class="table table-sm table-borderless">
                    <tr>
                        <td>
                            <label  for="metre" class="form-label">Metre</label>
                            <input onchange="generatePartCode()" class="form-control form-control-sm" id="metre" type="text" name="metre" readonly>
                        </td>
                        <td>
                            <label for="kilo_gram" class="form-label">Kg</label>
                            <input onchange="generatePartCode()"class="form-control form-control-sm" id="kilo_gram" type="text" name="kilo_gram" readonly>
                        </td>
                        <td>
                            <label  for="top_ad" class="form-label">Top Ad.</label>
                            <input onchange="generatePartCode()" class="form-control form-control-sm" id="top_ad" type="text" name="top_ad" readonly>
                        </td>
                        <td>
                            <label for="h_gram" class="form-label">H.Gramaj</label>
                            <input class="form-control form-control-sm" id="h_gram" type="text" name="h_gram" readonly>
                        </td>
                        <td>
                            <label for="gr_mtul" class="form-label">Gr/Mtül</label>
                            <input class="form-control form-control-sm" id="gr_mtul" type="text" name="gr_mtul" readonly>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <label for="aciklama" class="form-label">Açıklama</label>
                <textarea class="form-control" name="aciklama" id="aciklama" readonly></textarea>
            </td>
            <td style="vertical-align: bottom;">
                <div>
                    <table style="margin-top: 0;margin-bottom: 0;" class="table table-sm table-borderless">
                        <tr>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="ucret_dur_" id="ucret_dur_on" disabled>
                                    <label class="form-check-label" for="ucret_dur">
                                        Ücretli
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="ucret_dur" id="ucret_dur_off" disabled>
                                    <label class="form-check-label" for="ucret_dur">
                                        Ücretsiz
                                    </label>
                                </div>
                            </td>
                            <td>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="kum_dur" id="kum_dur_on" disabled>
                                    <label class="form-check-label" for="kum_dur">
                                        Ham
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="kum_dur" id="kum_dur_off"  disabled>
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
                    <cfoutput query="getReturnCats">
                    <option value="#RETURN_CAT_ID#">#RETURN_CAT#</option>
                    </cfoutput>

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
</cfform>
</div>
