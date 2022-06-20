<script>
var durum=1;
var durum2=1;</script>
<div style="display:flex">
<div style="width:4%;height:100vh">
<div style="border-bottom:solid 2px #dc3545;padding-bottom:5px"> 
    <div style="float:right">
        <a  onclick="expand(this)"style="margin-right:10px">
            <i class="fas fa-expand-arrows-alt text-danger"></i>
        </a>
        <a id="tx1" onclick="Togler(this)">
            <i style="font-weight:bold"  class="fas fa-chevron-right text-danger"></i>
        </a>
    </div>
    <div style="font-weight:bolder;clear:both" class="text-danger">İş Listesi</div>
</div>

<cfinclude  template="is_listesi.cfm">
</div>
            <div id="view" style="width:96%">
              <cfinclude  template="scheduler.cfm">
            </div>
    </div>


<script>
<cfinclude  template="planlama.js">
</script>
<div id="context_planlama"></div>   