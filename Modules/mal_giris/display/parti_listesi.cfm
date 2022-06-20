<style>

</style>
<div class="row">
    <div class="col-6">        
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Giriş Listesi</h3>
                <div class="card-tools">
                   <button type="button" onclick="windowopen('index.cfm?fuseaction=mal_giris.emptypopup_add_giris_fis','page')" class="btn btn-tool" data-card-widget="" title="Add">
                        <i class="fas fa-plus"></i>
                    </button>
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                    
                    <button type="button" class="btn btn-tool" data-card-widget="maximize"><i class="fas fa-expand"></i></button>
                </div>
            </div>
            <div class="card-body">
         <cfinclude  template="../includes/giris_listesi.cfm">
            </div>
        </div>        
        <!----<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
            <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
                <span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Giriş Listesi</span>
                <span></span>
            </div>
            <cfinclude  template="../includes/giris_listesi.cfm">
        </div>---->
    </div>
    <div class="col-6">
   <div class="card">
            <div class="card-header">
                <h3 class="card-title">Parti Listesi</h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                   <button type="button" class="btn btn-tool" data-card-widget="maximize"><i class="fas fa-expand"></i></button>
                </div>
            </div>
            <div class="card-body">
         <cfinclude  template="../includes/parti_listesi.cfm">
            </div>
    
       <!--- <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
            <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
                <span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Parti Listesi</span>
            </div>
            
        </div>--->
    </div>
</div>
  
  
    <!-----<div id="panelContainer">
        <div class="panel one">
            <div class="content">
                    <cfinclude  template="../includes/giris_listesi.cfm">
                <div id="carbon-block" style="margin:30px auto"></div>
                <div style="margin:30px auto"></div>
            </div>
        </div>
        <div class="panel two">            
            <div class="content">
            <cfinclude  template="../includes/giris_ozet.cfm">

                 <cfinclude  template="../includes/parti_listesi.cfm">
      
            </div>
            <span class="slider"></span>
        </div>
    </div>----->
    <script>
    function getSummary_malgiris(rows){
        var ship_id=rows.selectedRowsData[0].SHIP_ID
        var period_id=rows.selectedRowsData[0].PERIOD_ID
        changeDat(ship_id,period_id)
        ReUp(ship_id,period_id)
        $.ajax({
              url: "/cfc/boyahane.cfc?method=checkLogin&ships_id=" + ship_id,
               success: function (retDat) {  
                var arr = JSON.parse(retDat);
                  // console.log(arr)
                   $("#parti_kodu").val(arr[0].SHIP_NUMBER);
                   $("#evr_no_2").val(arr[0].EVRAK_NO2);
                   $("#evr_no").val(arr[0].SHIP_REF_NO);
                   //var eeeee=document.getElementById("prtgir");
                  // eeeee.setAttribute("onclick","windowopen('index.cfm?fuseaction=objects.emptypopup_print_files&module_id=2&action_id="+ship_id+"&iid="+period_id+"','page')")
                   $("#date_1").val(arr[0].RECORD_DATE);
                   $("#company_code").val(arr[0].MEMBER_CODE);
                   $("#company_name").val(arr[0].NICKNAME);
                   $("#order_no").val(arr[0].ORDER_NO);
                   $("#metre").val(arr[0].AMOUNT2);
                   $("#kilo_gram").val(arr[0].AMOUNT);
                 //  $("#top_ad").val(arr[0].TOP_ADET);
                   $("#h_gram").val(arr[0].H_GRAM);
                   $("#gr_mtul").val(arr[0].GR_MTUL);
                   $("#aciklama").val(arr[0].SHIP_DETAIL);
                   if(arr[0].UCRET_DUR =="on"){$("#ucret_dur_on").prop("checked", true);
                   }else{$("#ucret_dur_off").prop("checked", true);}
                   if(arr[0].KUMAS_DUR =="on"){$("#kum_dur_on").prop("checked", true);
                   }else{$("#kum_dur_off").prop("checked", true);}                   
                   if(arr[0].IADE_NEDEN.length){
                       $("#iade_neden").val(arr[0].IADE_NEDEN_ID)
                   }
                   $("#kumas").val(arr[0].PRODUCT_CODE_2+" "+arr[0].NAME_PRODUCT)
                 }
               
               })
    }
    
    </script>

<script src="/JS/panel_spliter/jquery.slider.js"></script>
    

    <!-------------------windowopen('index.cfm?fuseaction=objects.emptypopup_print_files&module_id=2&action_id=','page')'--------------->
