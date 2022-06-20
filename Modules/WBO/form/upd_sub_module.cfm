<cfquery name=getMModule datasource="#dsn#">
    SELECT * FROM BOYAHANE_SUB_MODULES WHERE ID=#attributes.module_id#
</cfquery>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
   <cfoutput>
   <table>
    <tr>
        <td>
        Modül Adı
        </td>
        <td>
         <input type="text" class="form-control" name="head" value="#getMModule.MODULE#" required />
        </td>
    </tr>
    <tr>
        <td>İcon</td>
        <td> <input onchange="selectIc(this)" class="form-control" type="text" name="M_ICON" value="#getMModule.M_ICON#" required />    </td>
        <td><i id="ic1" style="font-size:22pt !important" class="#getMModule.M_ICON#"></i></td>
    </tr>
    <tr><td>Menüde Göster</td><td><input type="checkbox" <cfif getMModule.IS_MENU eq 1>checked</cfif> name="is_menu" data-role="checkbox" data-caption="Menüde Göster"></td></tr>
   </table> 
    <input type="hidden" name="is_submit" value="1">
     <input type="hidden" name="module_id" value="#attributes.module_id#">
    <div class="form-group">
        <button  class="btn btn-success">Submit data</button>
        <input onclick="window.location.href='index.cfm?fuseaction=dev.list_sub_modules&module_id=#getMModule.module_id#'" type="button" class="btn btn-danger" value="Cancel">
    </div>
    </cfoutput>
</cfform>
<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
<cfquery name="ins" datasource="#dsn#">
    UPDATE BOYAHANE_SUB_MODULES SET MODULE='#attributes.head#',IS_MENU =<cfif isDefined("attributes.is_menu")>1<cfelse>0</cfif>,M_ICON='#attributes.M_ICON#' where ID=#attributes.module_id#
</cfquery>
<cfoutput>

<script>
    window.location.href='index.cfm?fuseaction=dev.list_sub_modules&module_id=#getMModule.module_id#'
</script>
</cfoutput>
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
