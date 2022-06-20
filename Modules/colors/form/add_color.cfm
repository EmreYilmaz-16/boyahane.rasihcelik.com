<cfparam  name="attributes.company_id" default="">
<cfparam  name="attributes.PARTNER_ID" default="">
<cfparam  name="attributes.COMPANY_CODE" default="">
<cfparam  name="attributes.COMPANY_NAME" default="">
<cfparam  name="attributes.PRODUCT_ID" default="">
<cfparam  name="attributes.PRODUCT_NAME" default="">
<cfparam  name="attributes.STOCK_ID" default="">
<cfparam  name="attributes.IS_INVENTORY" default="">
<div class="row">
<div  class="col" id="dv1">
<div class="row">
  <div class="col">
    <button class="btn btn-primary" onclick="OpenOperationPopup()">Operasyon</button>
    <button class="btn btn-success" onclick="Renk_Kaydet()">Renk Kaydet</button>
    <button class="btn btn-warning" onclick="CoppyCollor()">Renk Kopyala</button>
  </div>
</div>
<div class="row">
  <div class="col">
  <table class="table table-sm table-borderless">
  <tr>
  <td>K.Tarihi</td>
  <td><input type="date" name="cart_date" class="form-control form-control-sm" id="cart_date"></td>
  <td><div style="display:flex">Kartela
  
  <input type="text" name="cartlea" class="form-control form-control-sm" id="cartlea">
  <div class="form-check form-switch">
  <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" value="1" >
  <label class="form-check-label" for="flexSwitchCheckDefault">Hazır</label>
</div></div></td>
  </tr>
  <tr>
  <td colspan="2">
  <table class="table table-sm table-borderless">
  <tr>
  <td>R.Tonu<input type="text" style="width:60px" id="Rtone" class="form-control form-control-sm"></td>
  <td>Boya C<input type="text" style="width:60px" class="form-control form-control-sm" id="paint_degree"></td>
  <td>Flote<input type="text" style="width:60px" class="form-control form-control-sm" id="flote"></td>
  </tr>
  </table>
  </td>
  </tr>
  </table>
  
  </div>
</div>
</div>
<div class="col">
<form name="forum1">
<cf_select_customer frm_name="forum1" on_company_select="getKumas()" readonly="0">
<cf_get_comp_kumas frm_name="forum1" on_company_select="bos()" readonly="0">
<div style="display:flex">
    <input style="width:17%" type="text" name="renk_code" id="color_code" placeholder="R.Kodu" class="form-control form-control-sm">
    <input type="text" name="renk_name" id="color_name" placeholder="Renk Adı" class="form-control form-control-sm">
</div>
<input type="text" class="form-control form-control-sm" placeholder="Açıklama" id="information">
</form>
</div>
</div>
<div class="row">
<div style="height:100vh" class="col" id="CurrentTree"></div>
</div>

<div class="modal fade" id="exampleModalScrollable" tabindex="-1" aria-labelledby="exampleModalScrollableTitle" style="display: none;" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalScrollableTitle">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="table">
        <tr>
            <td>
                <input type="text" class="form-control form-control-sm" onkeydown="keypp(this,event)" id="Modkeyword" placeholder="Keyword">
            </td>
            <td>
            <button class="btn btn-succes btn-sm" onclick="SearchProd()">Ara</button>
            </td>
        </tr>
        </table>
        <div id="Div_1">        
        </div>
      </div>

    </div>
  </div>
</div>

<div class="modal fade" id="exampleModalScrollable_1" tabindex="-1" aria-labelledby="exampleModalScrollableTitle" style="display: none;" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalScrollableTitle">Renk Ekle</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <table class="table">
        <tr>
            <td>
                <input type="text" onkeydown="keypps(this,event)" class="form-control form-control-sm" id="Prokeyword" placeholder="Keyword">
                <input type="hidden" id="tx_1">
                <input type="hidden" id="rowx_1">
            </td>
            <td>
            <button class="btn btn-succes btn-sm"  onclick="SearchProd_2()">Ara</button>
            </td>
        </tr>
        </table>
        <div id="Div_1_PROD"></div>
      </div>

    </div>
  </div>
</div>

<script>
    <cfinclude  template="agac_func.js">
</script>

