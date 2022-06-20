<cfquery name="getKumas" datasource="#dsn#">
    select * from catalyst_prod_1.STOCKS AS S WHERE S.PRODUCT_ID =#attributes.product_id#
</cfquery>
<cfquery name="getBrand" datasource="#dsn#">
    SELECT * FROM catalyst_prod_product.PRODUCT_BRANDS where BRAND_ID =#getKumas.BRAND_ID#
</cfquery>
<cfquery name="getCompany" datasource="#dsn#">
    SELECT * FROM COMPANY where COMPANY_ID =#getKumas.COMPANY_ID#
</cfquery>
<cfquery name="getINFOPLUS" datasource="#dsn#">
    SELECT * FROM catalyst_prod_1.PRODUCT_INFO_PLUS where PRODUCT_ID =#attributes.product_id#
</cfquery>

<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
        <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding: 0.5%;display: flex;justify-content: space-between">
        <span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Kumaş Detay</span>
        <cfoutput><span><a href="##"  onclick="windowopen('index.cfm?fuseaction=objects.emptypopup_print_files&module_id=10&action_id=#attributes.product_id#','page')"> <i style="font-size:14pt !important" class="fas fa-print fa-10x"></i></span></span></div></cfoutput>
<table class="table table-sm">
<cfoutput>
<tr>
    <td><input class="form-control" type="text" placeholder="ÜrünKodu" id="product_code" name="product_code" readonly value="#getKumas.PRODUCT_CODE#"> </td>
   <td colspan="3"><input type="text" class="form-control" value="#getBrand.brand_code# #getBrand.brand_name#"></td>
    
</tr>
<tr>
    <td colspan="4"><div style="display:flex"><input style="width:25%" type="text"  class="form-control" value="#getCompany.member_code#"><input type="text"  class="form-control" value="#getCompany.NICKNAME#"></div></td>
</tr>
<tr>
  <td>
        <div class="input-group ">
            <span class="input-group-text">En</span>
            <input type="text" class="form-control" name="en" value="#getINFOPLUS.PROPERTY1#">
        </div>
    </td>
       <td>
        <div class="input-group ">
            <span class="input-group-text">Tuşe</span>
            <input type="text" class="form-control" name="tuse" value="#getINFOPLUS.PROPERTY2#">
        </div>
    </td>
       <td>
        <div class="input-group ">
            <span class="input-group-text">Çekme</span>
            <input type="text" class="form-control" name="cekme" value="#getINFOPLUS.PROPERTY3#">
        </div>
    </td>
      <td>
        <div class="input-group ">
            <span class="input-group-text">İstenen Gramaj</span>
            <input type="text" class="form-control" name="gramaj" value="#getINFOPLUS.PROPERTY4#">
        </div>
    </td>
</tr>
<tr>
  <td>
        <div class="input-group ">
            <span class="input-group-text">Isı</span>
            <input type="text" class="form-control" name="isi" value="#getINFOPLUS.PROPERTY5#">
        </div>
    </td>
       <td>
        <div class="input-group ">
            <span class="input-group-text">Hız</span>
            <input type="text" class="form-control" name="hiz" value="#getINFOPLUS.PROPERTY6#">
        </div>
    </td>
        <td>
        <div class="input-group ">
            <span class="input-group-text">Besleme/Avans</span>
            <input type="text" class="form-control" name="besleme" value="#getINFOPLUS.PROPERTY7#">
        </div>
    </td>
    <td ><cf_get_product_cat on_select="KodOlustur()"></td>
</tr>
<tr>        
    <!--- <td><input class="form-control" type="text" placeholder="Kumaş Adı" id="product_name" name="product_name"> </td>---->
        
        <td colspan="2">
        <div class="input-group ">
            <span class="input-group-text">Kullanılan Kimyassal</span>
            <input type="text" class="form-control" name="kimyasal" value="#getINFOPLUS.PROPERTY8#">
        </div>
    </td>
        <td>
        <div class="input-group ">
            <span class="input-group-text">Birim Çarpan</span>
            <input type="text" class="form-control" name="bcarpan" value="#getINFOPLUS.PROPERTY9#">
        </div>
    </td>
       <td>
        <div class="input-group ">
            <span class="input-group-text">Muh Stok Kodu</span>
            <input type="text" class="form-control" name="mstokcode" value="#getINFOPLUS.PROPERTY10#">
        </div>
    </td>
</tr>
<!----<tr><td><cf_prt_buttons Add_Action="SaveData()" Add_Message="Kayıt Edilecek Onaylıyormusunuz"></td></tr>----->
</table>
</cfoutput>