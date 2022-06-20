<style>
.inner_o{
    border:solid 1px;
    margin-top:5px;
    margin-left:10px;
    min-height:20px;
}
#Div_1,#Div_2{
    width:50%;
    border:solid 1px;
    margin-left:10px;
     height: 100vh;
}
*{
    font-size:8pt !important;
}


</style>
<div class="row">
<div class="col">   
<table class="table">
<tr><td colspan="4">
        <input type="text" class="form-control form-control-sm" id="txt_keyword" placeholder="Ürün/Operasyon"></td></tr>
        <tr><td>
        <button class="btn btn-danger form-control" onclick="Clear()">Clear</button></td>
        <td><button class="btn btn-primary form-control" onclick="RenkGrubu(1)">Renk Grubu</button></td>
        <td><button class="btn btn-secondary form-control"onclick="RenkGrubu(2)">Yeni Grup</button></td>
        <td><button class="btn btn-success form-control"onclick="KayitEt()">Renk Kaydet</button></td>
        </tr>
        </table>
    </div>
    <div class="col">
    <table class="table"> 
    <tr><td>Kartela Tarihi</td><td>
        <input type="date" class="form-control form-control-sm" id="txt_kartela_tarihi"></td>
        <td>Renk Adı</td><td> <input type="text" id="product_name" class="form-control form-control-sm" ></td></tr><td>Müşteri</td><td>       
        <cf_select_customer frm_name="forum1" on_company_select="getKumas()" readonly="0"></td>
        <td>Kumaş Cinsi</td><td>
        <cf_get_comp_kumas frm_name="forum1" on_company_select="bos()" readonly="0"></td></tr>
        </table>
    </div>
</div>

<div style="clear:both"></div>



<cfform name="forum1">
<div style="display:flex">
<div id="Div_1" class="connected_2"></div>
<div id="Div_2" class="connected_2"><ul data-id='0' class='ul_obj connected inner_o list-group ' data-tree_id='0'></ul></div>
</div>
</cfform>

<script>
    <cfinclude  template="TreeFunc.js">
</script>
<script>
function bos(){}
</script>