<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
    <table class="table">
        <tr>
            <td>HEAD</td>
            <td><input class="form-control" type="text" name="head" value=""  required />   </td>
        </tr>
        <tr>
            <td>Dosya Yolu</td>
            <td><input class="form-control" type="text" name="file_path" value="" required/></td>
        </tr>
        <tr>
            <td>Fuseaction</td>
            <td><input class="form-control" type="text" name="FULL_FUESEACTION" value="" required/></td>
        </tr>
   <tr>
        <td>İcon</td>
        <td><input type="text" onchange="selectIc(this)" name="M_ICON" value="" class="form-control" required /> </td>
        <td><i id="ic1" style="font-size:22pt !important" class=""></i></td>
    </tr>
        <tr>
            <td>Menüde Göster</td>
            <td><input  type="checkbox"  name="is_menu" data-role="checkbox" data-caption="Menüde Göster"></td>
        </tr>

    </table>
    <input type="hidden" name="is_submit" value="1">
    <input type="hidden" name="module_id" value="<cfoutput>#attributes.module_id#</cfoutput>">
    <div class="form-group">
        <button class="btn btn-success">Submit data</button>
        <input type="button" onclick="window.location.href='index.cfm?fuseaction=dev.list_pages&module_id=#attributes.module_id#'" class="btn btn-danger" value="Cancel">
    </div>
</cfform>

<cfif isDefined("attributes.is_submit") and attributes.is_submit eq 1>
<cfquery name="ins" datasource="#dsn#">
INSERT INTO catalyst_prod.BOYAHANE_PAGES (HEAD,IS_MENU,MODULE_ID,FULL_FUESEACTION,FILE_PATH,M_ICON) 
VALUES ('#attributes.head#',<cfif isDefined("attributes.is_menu")>1<cfelse>0</cfif>,#attributes.module_id#,'#attributes.FULL_FUESEACTION#','#attributes.file_path#','#attributes.M_ICON#')
</cfquery>
<cfoutput>

<script>
    window.location.href='index.cfm?fuseaction=dev.list_pages&module_id=#attributes.module_id#'
</script>
</cfoutput>
</cfif>