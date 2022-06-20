
<cfquery name="getP" datasource=#dsn#>
    select PERIOD_YEAR,OUR_COMPANY_ID from catalyst_prod.SETUP_PERIOD where PERIOD_ID=#attributes.period_id#
</cfquery>
<cfset Dyear=getP.PERIOD_YEAR>
<cfset Comp=getP.OUR_COMPANY_ID>
<cfquery name="getShip" datasource="#dsn#_#Dyear#_#Comp#">
    SELECT C.NICKNAME,C.COMPANY_ID,S.SHIP_NUMBER,S.COMPANY_ID FROM SHIP S LEFT JOIN #DSN#.COMPANY AS C ON C.COMPANY_ID=S.COMPANY_ID WHERE S.SHIP_ID =#attributes.ship_id#
</cfquery>
<cfquery name="isHvOrder" datasource="#dsn#_1">
    SELECT COUNT(*) AS C FROM catalyst_prod_1.ORDER_TO_SHIP_PRT AS OTSP WHERE SHIP_ID=#attributes.ship_id# AND PERIOD_ID=#attributes.period_id#
</cfquery>
<cfquery name="getShipRow" datasource="#dsn#">
    SELECT * FROM #dsn#_#Dyear#_#Comp#.SHIP_ROW WHERE SHIP_ID =#attributes.ship_id#
</cfquery>

<form  method="post" id="frmn_1" action="<cfoutput>#request.self#?fuseaction=mal_giris.emptypopup_add_party_query</cfoutput> "enctype="multipart/form-data">
    <cfoutput>
    <input type="hidden" name="company_id" value="#getShip.COMPANY_ID#">
    <input type="hidden" name="peryodid" value="#attributes.period_id#">
    <input type="hidden" name="sipoid" value="#attributes.ship_id#">
    <table class="table">
        <tr>
            <td colspan="2"><span style="font-weight:bold">Müşteri :</span> #getShip.NICKNAME#</td>
        </tr>
        <tr>
            <td style="width:75%">
                <table class="table table-sm table-borderless">

                    <tr>
                        <td>
                            <label for="parti_kodu" class="form-label">Parti Kodu</label>
                            <input class="form-control form-control-sm" value="#getShip.SHIP_NUMBER#-P#isHvOrder.C+1#" id="parti_kodu" type="text" name="parti_kodu"
                                readonly>
                        </td>
                        <td>
                            <label for="parti_kodu" class="form-label">Durum</label>
                            <input class="form-control form-control-sm" id="status" type="text" name="order_stage"
                                readonly>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="parti_kodu" class="form-label">Müşteri Renk</label>
                            <input class="form-control form-control-sm" id="color_m" type="text" name="PRODUCT_NAME2">
                        </td>
                        <td>
                            <label for="parti_kodu" class="form-label">Kartela Tarihi</label>
                            <input class="form-control form-control-sm" id="cart_d" type="date" name="cart_d">
                        </td>
                        <td>
                            <label for="parti_kodu" class="form-label">Kartela</label>
                            <input class="form-control form-control-sm" id="cart" type="text" name="cart">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <table style="width:100%">
                                <tr>
                                    <td style="width:10%"> <label for="parti_kodu" class="form-label">Metre</label>
                                        <input class="form-control form-control-sm" id="metre" type="text"
                                            name="metre">
                                    </td>
                                    <td style="width:10%"> <label for="parti_kodu" class="form-label">Kg</label>
                                        <input class="form-control form-control-sm" id="kg" type="text"
                                            name="kg">
                                    </td>
                                    <td style="width:10%"> <label for="parti_kodu" class="form-label">Top</label>
                                        <input class="form-control form-control-sm" id="top" type="text"
                                            name="top">
                                    </td>
                                    <td> <label for="parti_kodu" class="form-label">Kumaş Cinsi</label>
                                        <input class="form-control form-control-sm" value="#getShipRow.NAME_PRODUCT#" id="kumas_cins" type="text"
                                            name="kumas_cins">
                                               <input value="#getShipRow.STOCK_ID#" id="kumas_cins" type="hidden"
                                            name="kumas_cins_id">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <table style="width:100%">
                                <tr>
                                    <td style="width:30%"> <label for="parti_kodu" class="form-label">Kumaş Tipi</label>
                                        <input class="form-control form-control-sm" id="kumas_tip" type="text"
                                            name="kumas_tip">
                                    </td>
                                    <td style="width:10%"> <label for="parti_kodu" class="form-label">En</label>
                                        <input class="form-control form-control-sm" id="en" type="text"
                                            name="en">
                                    </td>
                                    <td style="width:30%"> <label for="parti_kodu" class="form-label">Tuşe</label>
                                        <input class="form-control form-control-sm" id="tuse" type="text"
                                            name="tuse">
                                    </td>
                                    <td> <label for="parti_kodu" class="form-label">Çekme</label>
                                        <input class="form-control form-control-sm" id="cekme" type="text"
                                            name="cekme">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <table style="width:100%">
                                <tr>
                                    <td style="width:15%"> <label for="parti_kodu" class="form-label">İstenen
                                            Gramaj</label>
                                        <input class="form-control form-control-sm" id="istenen_gr" type="text"
                                            name="istenen_gr">
                                    </td>
                                    <td style="width:15%"> <label for="parti_kodu" class="form-label">Sarım
                                            Şekli</label>
                                        <input class="form-control form-control-sm" id="sarim" type="text"
                                            name="sarim">
                                    </td>
                                    <td style="width:15%"> <label for="parti_kodu" class="form-label">Ambalaj</label>
                                        <input class="form-control form-control-sm" id="ambalaj" type="text"
                                            name="ambalaj">
                                    </td>
                                    <td rowspan="2" valign="top"> <label for="parti_kodu" class="form-label">Kalite
                                            Kontrol
                                            Açıklama</label>
                                        <textarea rows="5" class="form-control form-control-sm" id="kk_aciklama"
                                            type="text" name="kk_aciklama"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:10%"> <label for="parti_kodu" class="form-label">Isı</label>
                                        <input class="form-control form-control-sm" id="heat" type="text"
                                            name="heat">
                                    </td>
                                    <td style="width:10%"> <label for="parti_kodu" class="form-label">Hız</label>
                                        <input class="form-control form-control-sm" id="speed" type="text"
                                            name="speed">
                                    </td>
                                    <td style="width:10%"> <label for="parti_kodu" class="form-label">Besleme
                                            Ayarı</label>
                                        <input class="form-control form-control-sm" id="backfeed" type="text"
                                            name="backfeed">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"> <label for="parti_kodu" class="form-label">Kullanılan Kimyassal</label>
                            <input class="form-control form-control-sm" id="chemical" type="text" name="chemical">
                        </td>
                        <td> <label for="parti_kodu" class="form-label">Batch No:</label>
                            <input class="form-control form-control-sm" id="batch" type="text" name="batch">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <label for="parti_kodu" class="form-label">Açıklama
                                Açıklama</label>
                            <textarea rows="3" class="form-control form-control-sm" id="descr" type="text"
                                name="descr"></textarea>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
                <div>
                    <table>
                        <tr>
                            <th>Ek İşlemler</th>
                        </tr>
                      <!---  <cfquery name="getEkislem" datasource="#dsn#_1">
                            SELECT * FROM STOCKS WHERE COMPANY_ID=#getShip.COMPANY_ID#
                           AND PRODUCT_DETAIL2='Ek İşlem'
                        </cfquery>
                        <CFLOOP query="getEkislem">
                        <tr>
                            <td>
                                <label><input class="chk" name="ex_stok" value="#STOCK_ID#" data-id="dx_#STOCK_ID#" type="checkbox">&nbsp;#PRODUCT_NAME#</label>
                            </td>
                        </tr>
                        </CFLOOP>---->
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <div id="dx_ek" style="display: block;">

    </div>
    <div style="display: block;width: 200px;">
        <input type="text" class="form-control form-control-sm" id="tx_1" name="dt_1">
        <input type="hidden" name="prop_id">
        <button class="btn btn-sm btn-outline-primary" id="btn_1">Ekle</button>
    </div>
    </cfoutput>
</form>
    <script>
        $(".chk").on("change", function () {
            console.log(this)
        })
        $("#btn_1").click(function () {
            //console.log(this.parent)
            var e=document.getElementById("tx_1");
            var v=e.value;
            var o="<input type='text' value='"+v+"'>"
            var divElem=document.getElementById("dx_ek");
            divElem.innerHTML+=o;

        })
    </script>
