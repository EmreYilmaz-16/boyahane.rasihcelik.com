<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <table>
    <tr>
    <td>Modül Adı</td>
    <td> <input class="form-control" type="text" name="head" required />    </td>
    </tr>
     <td>İcon</td>
    <td> <input class="form-control" onchange="selectIc(this)" type="text" name="M_ICON" />    </td>
    <td><i id="ic1" style="font-size:22pt !important" ></i></td>
    </tr>
    <tr><td>Menüde Göster</td><td>  <input type="checkbox" name="is_menu" data-role="checkbox" data-caption="Menüde Göster"></td></tr>
    </table>
    <input type="hidden" name="is_submit" value="1">
    
    <div class="form-group">
        <button class="btn btn-success">Submit data</button>
        <input type="button" class="btn btn-danger" value="Cancel">
    </div>
</cfform>
<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
<cfquery name="ins" datasource="#dsn#">
INSERT INTO catalyst_prod.BOYAHANE_MODULES (MODULE,IS_MENU,M_ICON) 
    VALUES ('#attributes.head#',<cfif isDefined("attributes.is_menu")>1<cfelse>0</cfif>,'#attributes.M_ICON#')
</cfquery>
<script>
    window.location.href='index.cfm?fuseaction=dev.list_main_modules'
</script>
</cfif>
<script>
function selectIc(elem){
var icelem =document.getElementById("ic1")
var cls=elem.value
console.log(cls)
var ars=elem.value.split(" ")
if(ars.length>1){
    icelem.classList.forEach(function(cls){
icelem.classList.remove(cls)
})
for(let i=0;i<ars.length;i++){
    icelem.classList.add(ars[i]) 
}}
}
</script>
