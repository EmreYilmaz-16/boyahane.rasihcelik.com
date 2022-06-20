<cfparam  name="attributes.company_id" default="">
<cfparam  name="attributes.PARTNER_ID" default="">
<cfparam  name="attributes.COMPANY_CODE" default="">
<cfparam  name="attributes.COMPANY_NAME" default="">
<cfparam  name="attributes.PRODUCT_ID" default="">
<cfparam  name="attributes.PRODUCT_NAME" default="">
<cfparam  name="attributes.STOCK_ID" default="">
<cfparam  name="attributes.IS_INVENTORY" default="">
<cfform name="frm1">
<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
        <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%"><span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Kumaş Ekle</span></div>
<table class="table table-sm">
<tr>
    <td><input class="form-control" type="text" placeholder="ÜrünKodu" id="product_code" name="product_code" readonly> </td>
   <td colspan="3"><cf_get_brands></td>
    
</tr>
<tr>
    <td colspan="4"><cf_select_customer frm_name="frm1" on_company_select=""></td>
</tr>
<tr>
  <td>
        <div class="input-group ">
            <span class="input-group-text">En</span>
            <input type="text" class="form-control" name="en">
        </div>
    </td>
       <td>
        <div class="input-group ">
            <span class="input-group-text">Tuşe</span>
            <input type="text" class="form-control" name="tuse">
        </div>
    </td>
       <td>
        <div class="input-group ">
            <span class="input-group-text">Çekme</span>
            <input type="text" class="form-control" name="cekme">
        </div>
    </td>
      <td>
        <div class="input-group ">
            <span class="input-group-text">İstenen Gramaj</span>
            <input type="text" class="form-control" name="gramaj">
        </div>
    </td>
</tr>
<tr>
  <td>
        <div class="input-group ">
            <span class="input-group-text">Isı</span>
            <input type="text" class="form-control" name="isi">
        </div>
    </td>
       <td>
        <div class="input-group ">
            <span class="input-group-text">Hız</span>
            <input type="text" class="form-control" name="hiz">
        </div>
    </td>
        <td>
        <div class="input-group ">
            <span class="input-group-text">Besleme/Avans</span>
            <input type="text" class="form-control" name="besleme">
        </div>
    </td>
    <td ><cf_get_product_cat on_select="KodOlustur()"></td>
</tr>
<tr>        
    <!--- <td><input class="form-control" type="text" placeholder="Kumaş Adı" id="product_name" name="product_name"> </td>---->
        
        <td colspan="2">
        <div class="input-group ">
            <span class="input-group-text">Kullanılan Kimyassal</span>
            <input type="text" class="form-control" name="kimyasal">
        </div>
    </td>
        <td>
        <div class="input-group ">
            <span class="input-group-text">Birim Çarpan</span>
            <input type="text" class="form-control" name="bcarpan">
        </div>
    </td>
       <td>
        <div class="input-group ">
            <span class="input-group-text">Muh Stok Kodu</span>
            <input type="text" class="form-control" name="mstokcode">
        </div>
    </td>
</tr>
<tr><td colspan="2"><cf_prt_buttons Add_Action="SaveData()" Add_Message="Kayıt Edilecek Onaylıyormusunuz"></td></tr>
</table>
</cfform>
<script>
var UrunKodu=document.getElementsByName("product_code")[0].value
var BrandId=document.getElementsByName("brand_id")[0].value
var BrandName=document.getElementsByName("brand")[0].value
var CompanyId=document.getElementsByName("company_id")[0].value
var CompanyCode=document.getElementsByName("company_code")[0].value
var CompanyName=document.getElementsByName("company_name")[0].value
var En=document.getElementsByName("en")[0].value
var Tuse=document.getElementsByName("tuse")[0].value
var Cekme=document.getElementsByName("cekme")[0].value
var Gramaj=document.getElementsByName("gramaj")[0].value
var Isi=document.getElementsByName("isi")[0].value
var Hiz=document.getElementsByName("hiz")[0].value
var Besleme=document.getElementsByName("besleme")[0].value
var Hiearchy=document.getElementsByName("HIERARCHY")[0].value
var Product_Cat=document.getElementsByName("PRODUCT_CAT")[0].value
var CatId=document.getElementsByName("PRODUCT_CATID")[0].value
var Kimyasal=document.getElementsByName("kimyasal")[0].value
var BirimCarpan=document.getElementsByName("bcarpan")[0].value
var MuhStockCode=document.getElementsByName("mstokcode")[0].value

function KodOlustur(){
    readForm()

    var RES=wrk_query("select PRODUCT_NO+1 AS PRODUCT_NO from catalyst_prod_product.PRODUCT_NO")
    console.log(RES.PRODUCT_NO[0])
    var Kod=Hiearchy+"."+RES.PRODUCT_NO[0];
    $("#product_code").val(Kod)
    console.log(Kod)
}
function SaveData(){
readForm()
var E=new Object();
E.UrunKodu=UrunKodu;
E.BrandId=BrandId;
E.BrandName=BrandName;
E.CompanyId=CompanyId;
E.CompanyCode=CompanyCode;
E.CompanyName=CompanyName;
E.En=En;
E.Tuse=Tuse;
E.Cekme=Cekme;
E.Gramaj=Gramaj;
E.Isi=Isi;
E.Hiz=Hiz;
E.Besleme=Besleme;
E.Hiearchy=Hiearchy;
E.Product_Cat=Product_Cat;
E.CatId=CatId;
E.Kimyasal=Kimyasal;
E.BirimCarpan=BirimCarpan;
E.MuhStockCode=MuhStockCode;
jQuery.ajax({
          url: "/cfc/boyahane.cfc?method=saveProduct",         
          data: JSON.stringify(E),
          dataType: "json",
          beforeSend: function(x) {
            if (x && x.overrideMimeType) {
              x.overrideMimeType("application/j-son;charset=UTF-8");
            }
          },
          success: function(result) {
 	     //Write your code here
          }
});

}
function readForm(){
    UrunKodu=document.getElementsByName("product_code")[0].value
 BrandId=document.getElementsByName("brand_id")[0].value
 BrandName=document.getElementsByName("brand")[0].value
 CompanyId=document.getElementsByName("company_id")[0].value
 CompanyCode=document.getElementsByName("company_code")[0].value
 CompanyName=document.getElementsByName("company_name")[0].value
 En=document.getElementsByName("en")[0].value
 Tuse=document.getElementsByName("tuse")[0].value
 Cekme=document.getElementsByName("cekme")[0].value
 Gramaj=document.getElementsByName("gramaj")[0].value
 Isi=document.getElementsByName("isi")[0].value
 Hiz=document.getElementsByName("hiz")[0].value
 Besleme=document.getElementsByName("besleme")[0].value
 Hiearchy=document.getElementsByName("HIERARCHY")[0].value
 Product_Cat=document.getElementsByName("PRODUCT_CAT")[0].value
 CatId=document.getElementsByName("PRODUCT_CATID")[0].value
 Kimyasal=document.getElementsByName("kimyasal")[0].value
 BirimCarpan=document.getElementsByName("bcarpan")[0].value
 MuhStockCode=document.getElementsByName("mstokcode")[0].value
}
</script>

</div>