<cfif isDefined("attributes.fuseaction") and not findNoCase("ajaxpage", attributes.fuseaction)>
<!DOCTYPE html>
<html lang="en">
<head>
</cfif>
<cfset path="">
<cfset title="">
    <cfif isDefined("attributes.fuseaction") and len(attributes.fuseaction)>
<cfquery name="ALSXASCXMVP" datasource="#dsn#">
    SELECT * FROM BOYAHANE_PAGES AS BP WHERE FULL_FUESEACTION='#attributes.fuseaction#'    
</cfquery>
<cfset path=ALSXASCXMVP.FILE_PATH>
<cfset title="#ALSXASCXMVP.HEAD#">
</cfif>
  <cfif isDefined("attributes.fuseaction") and not findNoCase("ajaxpage", attributes.fuseaction)>  <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"></cfif>
 <cfoutput>
    <title>#title#</title></cfoutput>
    
<!-----
    <link rel="stylesheet" href="https://cdn.metroui.org.ua/v4.3.2/css/metro-all.min.css">
    <link rel="stylesheet" href="https://cdn.metroui.org.ua/v4/css/metro.min.css">
    <link rel="stylesheet" href="https://cdn.metroui.org.ua/v4/css/metro-colors.min.css">
    <link rel="stylesheet" href="https://cdn.metroui.org.ua/v4/css/metro-rtl.min.css">
    <link rel="stylesheet" href="https://cdn.metroui.org.ua/v4/css/metro-icons.min.css">
    <script src="https://cdn.metroui.org.ua/v4.3.2/js/metro.min.js"></script>
----->
<cfif isDefined("attributes.fuseaction") and not findNoCase("ajaxpage", attributes.fuseaction)>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.4.0/polyfill.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/exceljs/4.1.1/exceljs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.2/FileSaver.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.0.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.9/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.js" integrity="sha512-NOmoi96WK3LK/lQDDRJmrobxa+NMwVzHHAaLfxdy0DRHIBc6GZ44CRlYDmAKzg9j7tvq3z+FGRlJ4g+3QC2qXg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cldrjs/0.4.4/cldr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cldrjs/0.4.4/cldr/event.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cldrjs/0.4.4/cldr/supplemental.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cldrjs/0.4.4/cldr/unresolved.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize/message.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize/number.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize/currency.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/globalize/1.1.1/globalize/date.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.4/css/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.2.4/css/dx.light.css" />
    <script src="https://cdn3.devexpress.com/jslib/20.2.4/js/dx.all.js"></script>
    
        <script src="/JS/js_functions.js"></script>
    <script src="/JS/panel_spliter/jquery.slider.js"></script>
    <script src="/JS/jquery_ui/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="prt_css.css">
    </cfif>
  <style>
    * {
        font-size: .9rem !important;
    }

    .icon {
        font-size: 14pt !important
    }

    .menum>.btn {
        width: 50px !important;
        height: 50px !important
    }

    .auto-emre,
    .auto_complete {
        overflow: auto;
        display: none;
        width: 100%;
        height: 100px;
        border: solid 1px #ced4da;
        position: absolute;
        background: white;
        top: 100%;
        color: #dc3545;
        border-radius: 5px;
        box-shadow: 1px 1px #999ca0;
        z-index:9999;
    }

    .auto_complete::-webkit-scrollbar {
        width: 5px;
        height: 5px
    }

    .auto_complete::-webkit-scrollbar-track {
        background: #f1f1f1;
    }

    .auto_complete::-webkit-scrollbar-thumb {
        background: #dc3545;

    }

    .auto_complete::-webkit-scrollbar-thumb:hover {
        background: #ac2b38;

    }
</style>
<cfif isDefined("attributes.fuseaction") and not findNoCase("ajaxpage", attributes.fuseaction)>
    <link rel="stylesheet" href="/JS/panel_spliter/style.css" />
</head>
<body>
</cfif>
<div class="container-fluid">
<cfif isDefined("session.ep")>
<cfif isDefined("attributes.fuseaction") and !findNoCase('emptypopup', attributes.fuseaction)>
<cfquery name="Q1" datasource="#dsn#">SELECT * FROM BOYAHANE_MODULES where IS_MENU=1</cfquery>

<cfset aaaaaaaaaaa44444="0,">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.cfm?fuseaction=">Boyahane</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
    <cfloop query="Q1">
    
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink<cfoutput>#ID#</cfoutput>" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <cfoutput>
            <i class="#M_ICON#"></i>&nbsp;#MODULE#
            </cfoutput>
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink<cfoutput>#ID#</cfoutput>">
           <cfquery name="Q2" datasource=#dsn#>SELECT * FROM BOYAHANE_SUB_MODULES where MODULE_ID=#Q1.ID#</cfquery>
           
            <cfloop query="Q2">
           <cfif Q2.RECORDCOUNT> <cfset aaaaaaaaaaa44444 = "#aaaaaaaaaaa44444#,#Q2.ID#"></cfif>
              <cfif isDefined("session.ep.USER_LEVEL") and listFind(session.ep.USER_LEVEL, WRK_MODULE_NO)>  <li><a class="dropdown-item" data-id="<cfoutput>#Q2.ID#</cfoutput>" href="#"><cfoutput><i class="#M_ICON#"></i>&nbsp;#Q2.MODULE#</cfoutput></a></li></cfif>
            </cfloop>                      
          </ul>
        </li>
    </cfloop>
    
       <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false"><i class="fas fa-calendar-alt"></i>&nbsp;Dönem Değiştir</a>
    <ul class="dropdown-menu">
    <cfquery name="getDonems" datasource="#dsn#">
    select PERIOD ,PERIOD_YEAR,PERIOD_ID from catalyst_prod.SETUP_PERIOD where OUR_COMPANY_ID=1
    </cfquery>
    <cfoutput query="getDonems">
    <li><a class="dropdown-item" href="index.cfm?fuseaction=settings.change_period&PERIOD_YEAR=#PERIOD_YEAR#&PERIOD_ID=#PERIOD_ID#&PAGE=#attributes.fuseaction#"><i class="fas fa-sync"></i>&nbsp;#PERIOD#</a></li>
    </cfoutput>
      
     
    </ul>
  </li>
  <li class="nav-item"><a class="nav-link" href="index.cfm?fuseaction=logout"><i class="fas fa-sign-out-alt"></i>&nbsp;Çıkış</a></li>
      </ul>
    </div>
  </div>
  
</nav>

<div id="mndiv" style="display: none;z-index: 999;position: absolute;background: white;border: 1px solid rgba(0,0,0,.15);width: 100%;padding: 10px;border-radius: 5px;">
<cfquery name="Q3" datasource=#dsn#> SELECT * FROM BOYAHANE_PAGES where 1=1 AND IS_MENU =1 and MODULE_ID IN(#replace(aaaaaaaaaaa44444, ",,", ",")#)</cfquery> 

<cfloop query="Q3">
<cfquery name="isPerm" datasource="#dsn#">
   SELECT * FROM catalyst_prod.USER_GROUP_OBJECT WHERE OBJECT_NAME='#Q3.FULL_FUESEACTION#' AND USER_GROUP_ID=#session.ep.POWER_USER# AND LIST_OBJECT<>0
</cfquery>

<cfif isPerm.recordcount eq 0>
<button class="btn btn-outline-secondary mbutton mbuton_<cfoutput>#Q3.MODULE_ID#</cfoutput>" 
data-href="<cfoutput>index.cfm?fuseaction=#Q3.FULL_FUESEACTION#</cfoutput>" 
style="display:none" 
id="btn_<cfoutput>#Q3.MODULE_ID#</cfoutput>">
<cfoutput><i class="#Q3.M_ICON#"></i>&nbsp;#HEAD#</cfoutput></button>
</cfif>
</cfloop>
</div>
</cfif>

<cfif isDefined("attributes.fuseaction") and 1 eq 1 >
    
    <cfif len(attributes.fuseaction)>
        <cfif attributes.fuseaction eq "logout">
            <cfinclude  template="/modules/home/display/logout.cfm">
        <cfelse>
            <cfinclude  template="#path#">
        </cfif>        
    <cfelse>
        <cfinclude  template="/modules/home/display/welcome.cfm">
    </cfif>
</cfif>
<cfelse>
    <cfinclude  template="/modules/home/display/login.cfm">
</cfif>    
   

<cfif isDefined("attributes.fuseaction") and not findNoCase("ajaxpage", attributes.fuseaction)>

<script>
var bef=0;
$(".dropdown-item").click(function(){
var as =$(this).data("id") ;
$(".mbutton").hide()
$("#mndiv").show(10)
bef=as;
$(".mbuton_"+bef).toggle()
})
$(".mbutton").click(function(){
var as =$(this).data("href") ;
if(as.search("emptypopup") == -1){
window.location.href=as;}else{
    windowopen(as,'page')
}
})
$(".cls_close").click(function(){
$(this).parent().parent().hide()
})


function wrk_query(q,ds="dsn"){
    var qa=encodeURIComponent(q)
   var jqXHR = $.ajax({
            url: "/cfc/boyahane.cfc?method=wrk_query&query_=" + qa+"&datas="+ds,
            success: function (retData) {
                var arr = JSON.parse(retData);
             // wrk_query_handler(arr)
            },async: false

        });
        return JSON.parse(jqXHR.responseText);
}
function wrk_query_handler(data){    
    return data
}

function openModal_partner(url_p){
   $.ajax({
            url: url_p,
            dataType: "html",
            success: function (retData,text_status,jqXHR) {
             // console.log(retData)
             // var resp=Jquery(jqXHR.responseText)
              //var respS=resp.filter("script");
              //Jquery.each(respS, function(idx,val){eval(val.text)})
              ModalOlustur(retData)
             // wrk_query_handler(arr)
            }

        });
}
function ModalOlustur(html_data,scr){
var a=document.createElement("div")
    a.setAttribute("class","modal fade")
    var b=document.createElement("div")
    b.setAttribute("class","modal-dialog modal-xl");    
    var c= document.createElement("div")
    c.setAttribute("class","modal-content")
    $(c).html(html_data);
b.appendChild(c)    
a.appendChild(b)

var myModal = new bootstrap.Modal(a, {
  keyboard: false
})
myModal.show()
 var xx = a.getElementsByTagName("script");
                    var sca=document.createElement("script");
                    
                    for(let i=0;i<xx.length;i++){
                      //  console.log(xx[i].innerText)
                        //document.append(xx[i].innerText)
                        sca.innerHTML+=xx[i].innerText;
                    }
                    document.body.appendChild(sca);
                    $(a).on('hide.bs.modal', function (e) {
                    console.log(e)
                    })
                    $(a).on('hidden.bs.modal', function (e) {
                    a.remove();
                    sca.remove();
                    })
}

</script>
   
</body>
</html>
</cfif>
<!--------------
$(".nnelem").click(function(){
   var as =$(this).data("id") ;
   var asm =$(this).data("main") ;
    if (!$(".ascf").is(":visible")) {
                $(".ascf").hide()
            }
            console.log(as)

            $("#" + asm).show(500);
            $("#" + as).toggle(500)
//console.log($(this)).parent()
})
<ul class="v-menu">
    <cfquery name="ASXMVXPCX" datasource="#dsn#">SELECT * FROM BOYAHANE_MODULES</cfquery>
    <cfoutput>   
        <cfloop query="ASXMVXPCX">        
            <cfquery name="ASXMVXPCXK" datasource=#dsn#>SELECT * FROM BOYAHANE_SUB_MODULES where MODULE_ID=#ASXMVXPCX.ID#</cfquery>
            <cfif ASXMVXPCXK.recordcount>
                <li>
                    <a href="##" ><span class="mif-#M_ICON# icon"></span>#MODULE#</a>
                    <ul class="v-menu" data-role="dropdown">
                       <cfloop query="ASXMVXPCXK">
                            <cfquery name="ASXMVXPCXKS" datasource=#dsn#>SELECT * FROM BOYAHANE_PAGES where MODULE_ID=#ASXMVXPCXK.ID# AND IS_MENU =1</cfquery>
                            <cfif ASXMVXPCXKS.recordcount>
                                <li>
                                    <a href="##" ><span class="mif-#M_ICON# icon"></span> #ASXMVXPCXK.MODULE#</a>
                                    <ul class="v-menu" data-role="dropdown">
                                        <cfloop query="ASXMVXPCXKS">
                                             <li><a href="index.cfm?fuseaction=#ASXMVXPCXKS.FULL_FUESEACTION#"><span class="mif-#ASXMVXPCXKS.M_ICON# icon"></span>#ASXMVXPCXKS.HEAD#</a></li>
                                        </cfloop>
                                    </ul>
                                </li>
                            <cfelse>
                                <li><a href="##"><span class="mif-#ASXMVXPCXK.M_ICON# icon"></span> #ASXMVXPCXK.MODULE#</a></li>
                            </cfif>
                       </cfloop>
                    </ul>
                </li>
            <cfelse>
             <li><a href="##"><span class="mif-#ASXMVXPCX.M_ICON# icon"></span> #ASXMVXPCX.MODULE#</a></li>
            </cfif>

        </cfloop>
    </cfoutput>
    
   
</ul>
   
</aside>

<div class="shifted-content h-100 p-ab">
    <div class="app-bar pos-absolute bg-red z-1" data-role="appbar">
        <button class="app-bar-item c-pointer" id="sidebar-toggle-3">
            <span class="mif-menu fg-white"></span>
        </button>
    </div>

    <div class="h-100 p-4"></cfif>
   <cfif len(path)>
<cfinclude  template="/#path#">
</cfif>
 <cfif !findNoCase('emptypopup', attributes.fuseaction)>   </div>
</div></cfif>


<script src="/JS/js_functions.js"></script>
    
</body>
</html>


<!---------------
  <cfquery name="getMainMod" datasource="#dsn#">SELECT * FROM BOYAHANE_MODULES</cfquery>
        <cfoutput>    
            <cfloop query="getMainMod">        
                <cfquery name="getSub" datasource=#dsn#>SELECT * FROM BOYAHANE_SUB_MODULES where MODULE_ID=#getMainMod.ID#</cfquery>   
                <cfif getSub.recordcount>
                    <li class="stick-left">
                        <a class="dropdown-toggle"><span class="mif-tree icon"></span>#getMainMod.MODULE#</a>
                        <ul class="d-menu" data-role="dropdown" style="display: none;">
                            <cfloop query="getSub">
                                <cfquery name="getpages" datasource=#dsn#>SELECT * FROM BOYAHANE_PAGES where MODULE_ID=#getSub.ID#</cfquery>
                                <cfif 1 eq 0>
                                    <li class="stick-left">
                                        <a class="dropdown-toggle"><span class="mif-tree icon"></span>#getSub.MODULE#</a>
                                        <ul class="d-menu" data-role="dropdown" style="display: none;">
                                            <cfloop query="getpages">
                                                <li><a href="index.cfm?fuseaction=#getpages.fuseaction#">#getpages.HEAD#</a></li>
                                            </cfloop>
                                        </ul>
                                    </li>
                                <cfelse>
                                    <li><a ><span class="mif-vpn-lock icon"></span> #getsub.MODULE#</a></li>
                                </cfif>
                            </cfloop>
                        </ul>
                    </li>
                <cfelse>
                    <li><a href="##"><span class="mif-home icon"></span>#getMainMod.MODULE#</a></li>
                </cfif>        
            </cfloop>
        </cfoutput>     -------------->---------------->