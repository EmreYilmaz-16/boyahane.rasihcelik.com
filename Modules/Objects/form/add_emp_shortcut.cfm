


<div class="card card-secondary">
  <div class="card-header">
    <h3 class="card-title">Kısayol Ekle</h3>
  </div>
  <!-- /.card-header -->
  <div class="card-body">
    <cfform method="post" id="frm1">
<input type="text" name="bookmark" class="form-control form-control-sm" placeholder="Kısayol Adı" id="bookmark">
<input type="hidden" name="bookmark_url" placeholder="Kısayol Adı" id="bookmark_url" value="<cfoutput>#attributes.uri#</cfoutput>">
<div class="custom-control custom-checkbox">
    <input  class="custom-control-input custom-control-input-danger" type="checkbox" name="is_new_page" id="is_new_page" >
    <label for="is_new_page" class="custom-control-label">Yeni Sekmede Açılsın mı ?</label>
</div>
<br>
<button onclick="saveBookMark()" type="button" class="btn btn-sm btn-success">Kaydet</button>
</cfform> 
  </div>
  <!-- /.card-body -->
</div>

<script>
    function saveBookMark(){
        var data_form_p=$("#frm1").serialize();
        console.log(data_form_p)
        $.ajax({
            url:"/cfc/boyahane.cfc?method=save_bookmark",
            data:data_form_p,
            success:function(ret_dat){

            }
        })
    }
</script>