<div style="width:25%">
<div class="card">
  <div class="card-header bg-danger text-light">
        Yetkiler
  </div>
  <div class="card-body">
    <div class="list-group">
        <a href="index.cfm?fuseaction=settings.form_add_user_group" class="list-group-item list-group-item-action" aria-current="true">
        <i class="fal fa-badge-check"></i> Yetki Grupları
        </a>
    </div>
  </div>
</div>
</div>
<form name="frm1">
<button onclick="openModal_partner('index.cfm?fuseaction=objects.emptypopup_ajaxpage_list_customer&FRM_NAME=frm1')">Müşteri Seç</button>
</form>
<!-----
 <cfquery name="Q1" datasource="#dsn#">SELECT * FROM BOYAHANE_MODULES where IS_MENU=1</cfquery>
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">      
        <cfloop query="Q1"><cfquery name="Q2" datasource=#dsn#>SELECT * FROM BOYAHANE_SUB_MODULES where MODULE_ID=#Q1.ID#</cfquery>
        
          <li class="nav-item">
            <a href="#" class="nav-link active">
              <i class="nav-icon <cfoutput>#M_ICON#</cfoutput>"></i>
              <p>
                <cfoutput>#MODULE#</cfoutput>
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <cfloop query="q2">
              <cfquery name="Q3" datasource=#dsn#> SELECT * FROM BOYAHANE_PAGES where 1=1 AND IS_MENU =1 and MODULE_ID=#Q2.ID#</cfquery>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="<cfoutput>#q2.M_ICON#</cfoutput> nav-icon"></i>
                    <p><cfoutput>#Q2.MODULE#</cfoutput><i class="right fas fa-angle-left"></i></p>
                </a>
                            <ul class="nav nav-treeview">
              <cfloop query="q3">
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="<cfoutput>#q3.M_ICON#</cfoutput> nav-icon"></i>
                    <p><cfoutput>#Q3.HEAD#</cfoutput></p>
                </a>
              </li>
             </cfloop>          
            </ul>
              </li>
             </cfloop>          
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Simple Link
                <span class="right badge badge-danger">New</span>
              </p>
            </a>
          </li>
        </cfloop>  
        </ul>




    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
  
          <li class="nav-item menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Starter Pages
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="#" class="nav-link active">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Active Page</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Inactive Page</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Simple Link
                <span class="right badge badge-danger">New</span>
              </p>
            </a>
          </li>
        </ul>


<cfquery name="Q1" datasource="#dsn#">SELECT * FROM BOYAHANE_MODULES where IS_MENU=1</cfquery>
<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
<cfoutput>
  <cfloop query="Q1">
<li class="nav-item menu-open"> 
   <a href="##" class="nav-link active"> <i class="nav-icon #M_ICON#"></i><p>#MODULE#<i class="right fas fa-angle-left"></i></p></a>
    <cfquery name="Q2" datasource=#dsn#>SELECT * FROM BOYAHANE_SUB_MODULES where MODULE_ID=#Q1.ID#</cfquery>
    <ul class="nav nav-treeview">
    <cfloop query="Q2">
    <li class="nav-item menu-open">
      <a href="##" class="nav-link"><i class="nav-icon #q2.M_ICON#"></i><p>#Q2.MODULE#<i class="right fas fa-angle-left"></i></p></a>
      <cfquery name="Q3" datasource=#dsn#> SELECT * FROM BOYAHANE_PAGES where 1=1 AND IS_MENU =1 and MODULE_ID=#Q2.ID#</cfquery> 
      <ul class="nav nav-treeview">
      <cfloop query="q3">
       <li class="nav-item"> <a href="##" class="nav-link"><p>#q3.HEAD#</p></a></li>
      </cfloop>
      </ul>
    </li>
    </cfloop> 
    </ul>
</li>       
  </cfloop>
</cfoutput>
</ul>----->
<!----------------
     <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Starter Pages
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="#" class="nav-link active">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Active Page</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Inactive Page</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Simple Link
                <span class="right badge badge-danger">New</span>
              </p>
            </a>
          </li>
        </ul>
----->        