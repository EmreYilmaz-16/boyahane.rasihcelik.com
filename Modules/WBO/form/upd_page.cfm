<cfquery name="getPage" datasource=#dsn#>
    SELECT * FROM BOYAHANE_PAGES WHERE ID=#attributes.page_id#
</cfquery>
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <cfoutput>
    <table class="table">
        <tr>
            <td>HEAD</td>
            <td><input class="form-control" type="text" name="head" value="#getPage.HEAD#"  required />   </td>
        </tr>
        <tr>
            <td>Dosya Yolu</td>
            <td><input class="form-control" type="text" name="file_path" value="#getPage.FILE_PATH#" required/></td>
        </tr>
        <tr>
            <td>Fuseaction</td>
            <td><input class="form-control" type="text" name="FULL_FUESEACTION" value="#getPage.FULL_FUESEACTION#" required/></td>
        </tr>
   <tr>
        <td>İcon</td>
        <td><input type="text" onchange="selectIc(this)" name="M_ICON" value="#getPage.M_ICON#" class="form-control" required /> </td>
        <td><i id="ic1" style="font-size:22pt !important" class="#getPage.M_ICON#"></i></td>
    </tr>
        <tr>
            <td>Menüde Göster</td>
            <td><input  type="checkbox" <cfif getPage.IS_MENU eq 1>checked</cfif> name="is_menu" data-role="checkbox" data-caption="Menüde Göster"></td>
        </tr>

    </table>
  
    <div class="form-group">
        
    </div>
    <input type="hidden" name="is_submit" value="1">
    <input type="hidden" name="page_id" value="<cfoutput>#attributes.page_id#</cfoutput>">
    <div class="form-group">
        <button class="btn btn-success">Submit data</button>
        <input <cfoutput>onclick="window.location.href='index.cfm?fuseaction=dev.list_pages&module_id=#getPage.module_id#'"</cfoutput> type="button" class="btn btn-danger"  onclick="window.location.href='index.cfm?fuseaction=dev.list_pages&module_id=#getPage.module_id#'" value="Cancel">
    </div>
    </cfoutput>
</cfform>

<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
<cfquery name="ins" datasource="#dsn#">
    UPDATE BOYAHANE_PAGES SET  HEAD='#attributes.head#',FILE_PATH='#attributes.file_path#',FULL_FUESEACTION='#attributes.FULL_FUESEACTION#',
    IS_MENU=<cfif isDefined("attributes.is_menu")>1<cfelse>0</cfif>,M_ICON='#attributes.M_ICON#'
    WHERE ID=#attributes.page_id#
</cfquery>
<cfoutput>

<script>
    window.location.href='index.cfm?fuseaction=dev.list_pages&module_id=#getPage.module_id#'
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
