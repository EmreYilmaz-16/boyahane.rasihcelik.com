<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
        <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%"><span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Markalar</span></div>
<cfquery name="getBrand" datasource="#dsn#">
    select BRAND_ID,BRAND_CODE,BRAND_NAME from catalyst_prod_product.PRODUCT_BRANDS WHERE 1 = 1 
    <cfif isDefined("attributes.keyword") and len(attributes.keyword)>
        AND (
            BRAND_NAME LIKE '%#attributes.keyword#%' or 
            BRAND_CODE LIKE '%#attributes.keyword#%' 
        )
    </cfif>
</cfquery>
<table class="table">
<cfoutput query="getBrand">
<tr><td><a href="javascript://" onclick="setBrand('#BRAND_ID#','#BRAND_CODE#','#BRAND_NAME#',this)">#BRAND_CODE#</a></td><td>#BRAND_NAME#</td></tr>
</cfoutput>
</table>
<script>
var main_el="";
function setBrand(ID,CODE,NAME,elem){
    $("#brand").val(CODE+" "+NAME);
    $("#brand_id").val(ID);
   // main_el=elem;
    var ellll=elem.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement
    var mym=bootstrap.Modal.getInstance(ellll) 
    mym.hide();

}
</script>
</div>