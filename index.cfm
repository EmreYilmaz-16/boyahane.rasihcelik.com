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

<cfquery name="getttnnnm" datasource=#dsn#>
  SELECT * FROM BOYAHANE_MODULES WHERE ID=(SELECT MODULE_ID FROM BOYAHANE_SUB_MODULES WHERE ID=#ALSXASCXMVP.MODULE_ID#)
</cfquery>
<cfset path=ALSXASCXMVP.FILE_PATH>
<cfset title="#ALSXASCXMVP.HEAD#">
</cfif>
  <cfif isDefined("attributes.fuseaction") and not findNoCase("ajaxpage", attributes.fuseaction)>  <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"></cfif>
 <cfoutput>
    <title>#title#</title></cfoutput>
  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="/AdminLTE-3.1.0/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/AdminLTE-3.1.0/dist/css/adminlte.min.css">
  <cfif isDefined("attributes.fuseaction") and not findNoCase("ajaxpage", attributes.fuseaction)>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>  
    <script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.4.0/polyfill.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/exceljs/4.1.1/exceljs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.2/FileSaver.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.0.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.9/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.js" integrity="sha512-NOmoi96WK3LK/lQDDRJmrobxa+NMwVzHHAaLfxdy0DRHIBc6GZ44CRlYDmAKzg9j7tvq3z+FGRlJ4g+3QC2qXg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    
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
    
<!-- Bootstrap 4 -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<script src="/JS/jquery_ui/jquery-ui.js"></script>
<!-- AdminLTE App -->

 <!---       <script src="/JS/js_functions.js"></script>
    <script src="/JS/panel_spliter/jquery.slider.js"></script>
    
------>
    
    </cfif>
<link rel="stylesheet" href="prt_css.css">
<style>
*{
  font-size:.87rem !important;
}
</style>
</head>
<cfif isDefined("attributes.fuseaction") and !findNoCase('emptypopup', attributes.fuseaction)>
<body class="sidebar-mini layout-fixed">
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white  navbar-light " >
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
    <li class="nav-item dropdown">
        <a class="nav-link" onclick="$('.dr_down_message').toggle(300)"  href="#" aria-expanded="false">
          <i class="far fa-comments"></i>
          <span id="message_count_pill" class="badge badge-danger navbar-badge"></span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right dr_down_message" id="messageAreas">
          <a href="#" class="dropdown-item">
            <!-- Message Start -->
            <div class="media">
              <img src="/AdminLTE-3.1.0/dist/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  Brad Diesel
                  <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">Call me whenever you can...</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>
          <!-----
          <a href="#" class="dropdown-item">
            <!-- Message Start -->
            <div class="media">
              <img src="/AdminLTE-3.1.0/dist/img/user8-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  John Pierce
                  <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">I got your message bro</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>
          <a href="#" class="dropdown-item">
            <!-- Message Start -->
            <div class="media">
              <img src="/AdminLTE-3.1.0/dist/img/user3-128x128.jpg" alt="User Avatar" class="img-size-50 img-circle mr-3">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  Nora Silvester
                  <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>
                </h3>
                <p class="text-sm">The subject goes here</p>
                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>------>
          <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" onclick='openModal_partner("index.cfm?fuseaction=objects.emptypopup_ajaxpage_add_employee_shortcut&uri=<cfoutput>#CGI.HTTP_URL#</cfoutput>")' role="button">
          <i class="fas fa-bookmark"></i>
        </a>
      </li>
     <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="index.cfm?fuseaction=home.logout" role="button">
          <i class="fas fa-sign-out-alt"></i>
        </a>
      </li>
         <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
          <i class="fas fa-th-large"></i>
        </a>
      </li>
      
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary nav-compact nav-child-indent elevation-4">
    <!-- Brand Logo -->
    <a href="<CFOUTPUT>#REQUEST.SELF#?fuseaction=home.display_welcome</CFOUTPUT>" class="brand-link">
      <img src="/contents/images/paintcan.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">Partner Boyahane</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar" style="overflow-y: unset !important;">

      <div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <cfinclude  template="left_menu.cfm">
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
   
    <!-- /.content-header -->
</cfif>
    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
    <cfif isDefined("attributes.fuseaction")>
      <cfif isDefined("session.ep")>  
      <cfelse>
        <cfif attributes.fuseaction neq "home.emptypopup_login">
        <cflocation  url="index.cfm?fuseaction=home.emptypopup_login">
        </cfif>
      </cfif>
      <cfelse>
      <cflocation  url="index.cfm?fuseaction=home.display_welcome">
    </cfif>

<cfinclude  template="#path#">
<cfif isDefined("attributes.fuseaction") and listgetat(attributes.fuseaction,1,".") eq "dev">
<div class="card card-outline card-primary" style="
    bottom: 0;
    position: fixed;
">
 <div class="card-header">
    <h3 class="card-title">Sayfa Ara</h3>

    <div class="card-tools">
      <!-- This will cause the card to maximize when clicked -->
      <button type="button" class="btn btn-tool" data-card-widget="maximize"><i class="fas fa-expand"></i></button>
      <!-- This will cause the card to collapse when clicked -->
      <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button>
      <!-- This will cause the card to be removed when clicked -->
      <button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button>
    </div>
    <!-- /.card-tools -->
  </div>
  <!-- /.card-header -->
  <div class="card-body">  
        <div class="form-group">
            <div class="input-group">
                <input type="text" class="form-control" id="page_name1">
                <button onclick="sayfaAra()" type="button" class="btn btn-success">Ara</button>
            </div>
        </div>
        <div  id="search_res" class="list-group">
            
        </div>
    </div>
</div>
<script>

function sayfaAra(){
   $("#search_res").html("")
    var vv=document.getElementById("page_name1").value
    var pages=wrk_query("select * from BOYAHANE_PAGES where FULL_FUESEACTION LIKE '%"+vv+"%' OR HEAD LIKE '%"+vv+"%'")
    console.log(pages)
    for(let i=0;i<pages.HEAD.length;i++){
        var e=document.createElement("a")
        e.setAttribute("href","index.cfm?fuseaction=dev.upd_page&page_id="+pages.ID[i])
        e.innerText=pages.HEAD[i]
        e.setAttribute("class","list-group-item")
        $("#search_res").append(e)
    }
}

</script>
</cfif>
<cfif isDefined("attributes.fuseaction") and not findNoCase("ajaxpage", attributes.fuseaction)>
<script src="/AdminLTE-3.1.0/dist/js/adminlte.js"></script>
<script>
var bef=0;
var messageAreas=document.getElementById("messageAreas");
var message_count_pill=document.getElementById("message_count_pill");
var mesage_control_interval;
/*
	mesage_control_interval=setInterval(function(){
message_control(<cfoutput></cfoutput>)
	},3000)

function message_control(user_id){
   $("#messageAreas").html("");
  $.ajax({
    url:"/cfc/boyahane.cfc?method=getMessages&user_id="+user_id,
    method:"POST",
    success:function(retdat){
      console.log(retdat)
      var o=JSON.parse(retdat)
      console.log(o)
      message_count_pill.innerText=o.MESSAGE_COUNT;
      for(let i=0;i<o.MESSAGES.length;i++){
        var bj=o.MESSAGES[i];
        $("#messageAreas").append(mesajOlustur("/w3docs/hr/"+bj._PHOTO,bj._MESSAGE_FROM,bj._MESSAGE_TEXT,bj._MESSAGE_DATE))
      }
    }
  })
}*/
function mesajOlustur(photo_path, kimden, mesaj, tarih) {
	var a = document.createElement("a");
	a.setAttribute("class", "dropdown-item");
	var media_div = document.createElement("div");
	media_div.setAttribute("class", "media");
	var img = document.createElement("img")
	img.setAttribute("src", photo_path);
	img.setAttribute("class", "img-size-50 mr-3 img-circle")
	var media_body = document.createElement("div");
	media_body.setAttribute("class", "media-body");
	var h = document.createElement("h3");
	h.setAttribute("class", "dropdown-item-title")
	h.innerText = kimden;
	var p1 = document.createElement("p");
	p1.setAttribute("class", "text-sm")
	p1.innerText = mesaj;
	var p2 = document.createElement("p");
	p2.setAttribute("class", "text-sm text-muted");

	var i = document.createElement("i");
	i.setAttribute("class", "far fa-clock mr-1");
	p2.appendChild(i);
	p2.innerText += tarih;
	media_body.appendChild(h);
	media_body.appendChild(p1);
	media_body.appendChild(p2);
	media_div.appendChild(img);
	media_div.appendChild(media_body);
	a.appendChild(media_div);
	return a
}
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
/* pop upları sayfanın tam ortasında açar... pencere boyutları önceden belirleniyor..*/
function windowopen(theURL,winSize) { /*v3.0*/
//fonsiyon 3 parametrede alabiliyor 3. parametre de isim yollana bilir ozaman aynı pencere tekrar acilmaz
	if (winSize == 'page') 					{ myWidth=900 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'print_page') 		{ myWidth=750 ; myHeight=500 ; features = 'scrollbars=0, resizable=1, menubar=1' ; }
	else if (winSize == 'list') 			{ myWidth=800 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'medium') 			{ myWidth=800 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'small') 			{ myWidth=570 ; myHeight=350 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'date') 			{ myWidth=275 ; myHeight=190 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'project') 			{ myWidth=800 ; myHeight=620 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'large') 			{ myWidth=615 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'horizantal') 		{ myWidth=1600 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'list_horizantal')	{ myWidth=1100 ; myHeight=550 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'wide') 			{ myWidth=980 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'wide2') 			{ myWidth=1100 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'longpage') 		{ myWidth=1200 ; myHeight=500 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'page_horizantal') 	{ myWidth=800 ; myHeight=500 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'video') 			{ myWidth=480 ; myHeight=420 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
	else if (winSize == 'online_contact') 	{ myWidth=600 ; myHeight=500 ; features = 'scrollbars=0, resizable=0, menubar=0' ; } 
	else if (winSize == 'wwide') 			{ myWidth=1600 ; myHeight=860 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }  
	else if (winSize == 'long_menu') 		{ myWidth=200 ; myHeight=500 ; features = 'scrollbars=0, resizable=0' ; }
	else if (winSize == 'adminTv') 			{ myWidth=1040 ; myHeight=870 ; features = 'scrollbars=1, resizable=1, menubar=0' ; }
	else if (winSize == 'userTv') 			{ myWidth=565 ; myHeight=487 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
    else if (winSize == 'video_conference')	{ myWidth=740 ; myHeight=610 ; features = 'scrollbars=0, resizable=0, menubar=0' ; }
    else if (winSize == 'white_board')		{ myWidth=1000 ; myHeight=730 ; features = 'scrollbars=0, resizable=1, menubar=0' ; }
 	else if (winSize == 'wwide1') 			{ myWidth=1200 ; myHeight=700 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'norm_horizontal')	{ myWidth=950 ; myHeight=300 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'page_display')		{ myWidth=1100 ; myHeight=600 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else if (winSize == 'work') 			{ myWidth=950 ; myHeight=620 ; features = 'scrollbars=1, resizable=1, menubar=1' ; }
	else { myWidth=400 ; myHeight=400 ; features = 'scrollbars=0, resizable=0' ; }
	if(window.screen)
	{
		var myLeft = (screen.width-myWidth)/2;
		var myTop =  (screen.height-myHeight)/2;
		
		features+=(features!='')?',':''; 
		features+=',left='+myLeft+',top='+myTop; 
	}

	if (arguments[2]==null)
		window.open(theURL,'',features+((features!='')?',':'')+'width='+myWidth+',height='+myHeight); 
	else		
		window.open(theURL,arguments[2],features+((features!='')?',':'')+'width='+myWidth+',height='+myHeight);
}


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

function openModal_partner(url_p,siz){
   $.ajax({
            url: url_p,
            dataType: "html",
            success: function (retData,text_status,jqXHR) {
             // console.log(retData)
             // var resp=Jquery(jqXHR.responseText)
              //var respS=resp.filter("script");
              //Jquery.each(respS, function(idx,val){eval(val.text)})
              ModalOlustur(retData,siz)
             // wrk_query_handler(arr)
            }

        });
}
function ModalOlustur(html_data,scr){
var a=document.createElement("div")
    a.setAttribute("class","modal fade")
    var b=document.createElement("div")
    b.setAttribute("class","modal-dialog "+scr);    
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
   

</cfif>
    
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
    <aside class="control-sidebar control-sidebar-dark">    
    <div class="p-3">
      <h5>Kısayollar</h5>
    
      <cfquery name="getShortEmp" datasource="#dsn#">
      select * from BOYAHANE_SHORTCUTS_EMPLOYEE where EMPLOYEE_ID=#session.ep.USERID#
      </cfquery>
  
  
    <div class="list-group">
     <cfoutput>
      <cfloop query="getShortEmp">
        <a href="#SHORTCUT_URL#" class="list-group-item list-group-item-action">#SHORCUT_NAME#</a>           
      </cfloop>
      </cfoutput>
  

</div>
  </div>
<div class="p-3">
      <h5>Dev</h5>
      <div class="list-group">
       <a class="list-group-item list-group-item-action" href="index.cfm?fuseaction=dev.upd_page&page_id=<cfoutput>#ALSXASCXMVP.ID#</cfoutput>"><i class="fab fa-dev"></i>&nbsp;DevWo</a>
       <a class="list-group-item list-group-item-action" href="index.cfm?fuseaction=objects.form_add_print_files.cfm"><i class="fas fa-print"></i>&nbsp;Yazıcı Belgeleri</a>
        <a class="list-group-item list-group-item-action" href="index.cfm?fuseaction=object.sys_variables"><i class="fas fa-bong"></i>&nbsp;Variables</a>
      </div>
      
</div>      
  </aside>
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->

</body>
</html>
