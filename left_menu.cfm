   
   <cfquery name="Q1" datasource="#dsn#">SELECT * FROM BOYAHANE_MODULES where IS_MENU=1</cfquery>
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">      
        <cfloop query="Q1"><cfquery name="Q2" datasource=#dsn#>SELECT * FROM BOYAHANE_SUB_MODULES where MODULE_ID=#Q1.ID#</cfquery>
        
          <li class="nav-item <cfif isdefined('getttnnnm.ID')and Q1.ID eq getttnnnm.ID>menu-open</cfif>">
            <a href="#" class="nav-link">
              <i class="nav-icon <cfoutput>#M_ICON#</cfoutput>"></i>
              <p>
                <cfoutput>#MODULE#</cfoutput>
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <cfloop query="q2">
              <cfquery name="Q3" datasource=#dsn#> SELECT * FROM BOYAHANE_PAGES where 1=1 AND IS_MENU =1 and MODULE_ID=#Q2.ID#</cfquery>
              <li class="nav-item <cfif isdefined('ALSXASCXMVP.MODULE_ID')and ALSXASCXMVP.MODULE_ID eq q2.ID>menu-open</cfif>">
                <a href="#" class="nav-link">
                  <i class="<cfoutput>#q2.M_ICON#</cfoutput> nav-icon"></i>
                    <p><cfoutput>#Q2.MODULE#</cfoutput><i class="right fas fa-angle-left"></i></p>
                </a>
                            <ul class="nav nav-treeview">
              <cfloop query="q3">
              <li class="nav-item  ">
                <a href="<cfoutput>#request.self#?fuseaction=#q3.FULL_FUESEACTION#</cfoutput>" class="nav-link <cfif attributes.fuseaction eq q3.FULL_FUESEACTION>active</cfif>">
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
        </cfloop>  
        </ul>