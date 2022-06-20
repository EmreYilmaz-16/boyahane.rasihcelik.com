<cfparam  name="attributes.is_submit" default="0">
<cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#" name="frm_1">
    <cf_search_box title="Müşteri Seç" is_detail="0" is_collapsible="1">
        <table class="table compact">
            <tr>
                <td>
                <div class="form-group">
                
                <input type="text" class="form-control form-control-sm" placeholder="Müşteri Kodu/Adı"
                name="customer_code" />
                </div>
                </td>
                               <td>
                <div class="form-group">
                
                <input type="text" class="form-control form-control-sm" placeholder="Vergi No"
                name="tax_no" />
                </div>
                </td>
                                              <td>
                <div class="form-group">
                
                <input type="text" class="form-control form-control-sm" value="20" placeholder="Vergi No"
                name="max_rows" />
                </div>
                </td>
                     </td>
                                              <td>
                <input type="hidden" name="is_submit" value="1">
             <cfoutput>
                <input type="hidden" name="frm_name" value="#attributes.frm_name#">
                <input type="hidden" name="id_area" value="#attributes.id_area#">
                <input type="hidden" name="name_area" value="#attributes.name_area#">
                <input type="hidden" name="code_area" value="#attributes.code_area#">
                <input type="hidden" name="onselect" value="#attributes.onselect#">
            </cfoutput>
               <button type="submit" class="btn btn-success btn-sm"><i class="fa fa-search" aria-hidden="true"></i>&nbsp;Ara</button>
                
                </td>
            </tr>
        </table>

</cf_search_box>
</cfform>
<cfif attributes.is_submit eq 1>
    <cfquery name="getCustomer" datasource="#dsn#">
        SELECT * FROM COMPANY WHERE 1=1 
        <cfif len(attributes.customer_code)>
        AND(
            FULLNAME LIKE '%#attributes.customer_code#%' 
            or 
            OZEL_KOD LIKE '%#attributes.customer_code#%'
        ) </cfif>
    </cfquery>
    <table class="table table-sm table-striped">
    <cfoutput query="getCustomer">
        <tr>
            <td>#currentrow#</td>
            <td>#MEMBER_CODE#</td>
            <td><a href="javascript:;" onclick="sec('#attributes.frm_name#','#attributes.id_area#','#attributes.name_area#','#attributes.code_area#','#COMPANY_ID#','#NICKNAME#','#MEMBER_CODE#')">#NICKNAME#</a></td>
            
        </tr>
    </cfoutput>
    </table>
</cfif>

<script>
  function  sec(frm_name,id_area,name_area,code_area,company_id,company_name,company_code){        
        var frm=window.opener.document.forms[frm_name]
        frm.elements[id_area].value=company_id;
        frm.elements[name_area].value=company_name;
        frm.elements[code_area].value=company_code;
        <cfoutput>
        <cfloop list='#attributes.onselect#' item='i'>window.opener.#i#</cfloop></cfoutput>
        this.close()
        //frm.elements[b]
    }
</script>