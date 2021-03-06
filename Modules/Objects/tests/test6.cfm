


 <cffunction name="cfquery" returntype="any" output="false">
        <!--- 
            usage : my_query_name = cfquery(SQLString:required,Datasource:required(bos olabilir),dbtype:optional,is_select:optinal); 
            Select olmayan yerlerde is_select:false olarak verilmelidir
        --->
        <cfargument name="SQLString" type="string" required="true">
        <cfargument name="Datasource" type="string" required="true">
        <cfargument name="dbtype" type="string" required="no">
        <cfargument name="is_select" type="boolean" required="no" default="true">
        
        <cfif isdefined("arguments.dbtype") and len(arguments.dbtype)>
            <cfquery name="workcube_cf_query" dbtype="query">
                #preserveSingleQuotes(arguments.SQLString)#
            </cfquery>
        <cfelse>
            <cfquery name="workcube_cf_query" datasource="#arguments.Datasource#">
                #preserveSingleQuotes(arguments.SQLString)#
            </cfquery>
        </cfif>
        <cfif arguments.is_select>
            <cfreturn workcube_cf_query>
        <cfelse>
            <cfreturn true>
        </cfif>
    </cffunction>   
	 <cffunction name="writeTree_order" returntype="void">
            <cfargument name="spect_main_id">
            <cfargument name="old_amount">
            <cfscript>
                var i = 1;
				var sub_products = get_subs_order(spect_main_id);
				for (i=1; i lte listlen(sub_products,'█'); i = i+1)
				{
					_next_amount_ = ListGetAt(ListGetAt(sub_products,i,'█'),1,'§');//alt+987 = █ --//alt+789 = §
					_next_spect_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),2,'§');
					_next_stock_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),3,'§');
					_next_line_number_ = ListGetAt(ListGetAt(sub_products,i,'█'),4,'§');
					phantom_spec_main_id_list = listappend(phantom_spec_main_id_list,_next_spect_id_,',');
					phantom_stock_id_list = listappend(phantom_stock_id_list,_next_stock_id_,',');
					phantom_line_number_list = listappend(phantom_line_number_list,_next_line_number_,',');
					if(_next_spect_id_ gt 0)
					{
						'multipler_#_next_spect_id_#' = _next_amount_*old_amount;
						writeTree_order(_next_spect_id_,_next_amount_*old_amount);
					}
				 }
            </cfscript>
        </cffunction>

	      <cffunction name="get_subs_operation" returntype="any">
            <cfargument name="next_stock_id">
            <cfargument name="next_spec_id">
            <cfargument name="next_product_tree_id">
            <cfargument name="type">
     		<cfscript>
				if(type eq 0) where_parameter = 'PT.STOCK_ID = #next_stock_id#'; else where_parameter = 'RELATED_PRODUCT_TREE_ID = #next_product_tree_id#';							
				SQLStr = "
						SELECT
							PRODUCT_TREE_ID,
							AMOUNT,
							ISNULL(SPECT_MAIN_ID,0) SPECT_MAIN_ID,
							ISNULL(RELATED_ID,0) STOCK_ID,
							ISNULL(PT.OPERATION_TYPE_ID,0) OPERATION_TYPE_ID
						FROM
							PRODUCT_TREE PT
						WHERE
							#where_parameter#
						ORDER BY LINE_NUMBER ASC
					";
				query1 = cfquery(SQLString : SQLStr, Datasource : dsn3);
				stock_id_ary='';
				'type_#attributes.deep_level_op#' = type;
				for (str_i=1; str_i lte query1.recordcount; str_i = str_i+1)
				{
					stock_id_ary=listappend(stock_id_ary,query1.PRODUCT_TREE_ID[str_i],'█');
					stock_id_ary=listappend(stock_id_ary,query1.SPECT_MAIN_ID[str_i],'§');
					stock_id_ary=listappend(stock_id_ary,query1.STOCK_ID[str_i],'§');
					stock_id_ary=listappend(stock_id_ary,query1.AMOUNT[str_i],'§');
					stock_id_ary=listappend(stock_id_ary,query1.OPERATION_TYPE_ID[str_i],'§');
					stock_id_ary=listappend(stock_id_ary,attributes.deep_level_op,'§');
				}
			 </cfscript>
             <cfreturn stock_id_ary>
        </cffunction>	
		 	<cffunction name="get_subs_order" returntype="any" >
            <cfargument name="spect_id">
            <cfscript>
                SQLStr = "
                        SELECT
                            AMOUNT,
                            ISNULL(RELATED_MAIN_SPECT_ID,0) RELATED_MAIN_SPECT_ID,
                            ISNULL(STOCK_ID,0) STOCK_ID,
                            ISNULL(LINE_NUMBER, 0) LINE_NUMBER
                        FROM 
                            SPECT_MAIN_ROW SM
                        WHERE
                            SPECT_MAIN_ID = #arguments.spect_id#
                            AND IS_PHANTOM = 1
                    ";
                query1 = cfquery(SQLString : SQLStr, Datasource : dsn3);
                stock_id_ary='';
                for (str_i=1; str_i lte query1.recordcount; str_i = str_i+1)
                {
                    stock_id_ary=listappend(stock_id_ary,query1.AMOUNT[str_i],'█');
                    stock_id_ary=listappend(stock_id_ary,query1.RELATED_MAIN_SPECT_ID[str_i],'§');
                    stock_id_ary=listappend(stock_id_ary,query1.STOCK_ID[str_i],'§');
                    stock_id_ary=listappend(stock_id_ary,query1.LINE_NUMBER[str_i],'§');
                }
            </cfscript>
            <cfreturn stock_id_ary>
        </cffunction>
        	 <cffunction name="get_production_times" returntype="string" output="no">
        <cfargument name="station_id" type="boolean" default="1">
        <cfargument name="shift_id" type="boolean" default="1">
        <cfargument name="stock_id" type="boolean" default="1">
        <cfargument name="amount" type="boolean" default="1">
        <cfargument name="min_date" type="numeric" default="0">
        <cfargument name="setup_time_min" type="numeric" default="0">
        <cfargument name="production_type" type="boolean" default="0">
        <cfargument name="_now_" type="string" default="">
        <cfquery name="GET_STATION_CAPACITY" datasource="#DSN3#"><!--- Seçilen istasyona ve ürüne bağlı olarak istasyonumuzun o ürünü ne kadar zamanda ürettiği bilgileri --->
            SELECT 
                *
            FROM
                WORKSTATIONS_PRODUCTS WSP,
                WORKSTATIONS W
            WHERE
                W.STATION_ID=WSP.WS_ID AND 
                WSP.STOCK_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.stock_id#"> AND
                WS_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.station_id#">
        </cfquery>
        <cfif GET_STATION_CAPACITY.RECORDCOUNT>
            <cfset capacity = GET_STATION_CAPACITY.CAPACITY />
        <cfelse>
            <cfset capacity = 1 />
        </cfif>    
        <cfset amount = arguments.amount />
        <!--- İstasyon zamanlarında bazen hata oluyordu,onu engellemek için eklendi...Üretim zamanı 0,000001 gibi bi değer inifty oluyor ve 0 geldiği için çakıyordu --->
        <cfif capacity eq 0><cfset capacity =1 /></cfif>
        <cfset gerekli_uretim_zamani_dak = wrk_round((amount/capacity)*60,6) />
        <cfif arguments.setup_time_min gt 0><cfset gerekli_uretim_zamani_dak = arguments.setup_time_min + gerekli_uretim_zamani_dak /></cfif>
        <!--- <cfoutput><font color="FF0000">**********#arguments.min_date#************************ </font> </cfoutput> --->
        <cfif len(arguments._now_) and isdate(arguments._now_)>
            <cfset _now_ = arguments._now_ />
        <cfelse>
            <cfset _now_ = date_add('h',session.ep.TIME_ZONE,now()) />
        </cfif>
        <cfquery name="get_station_times" datasource="#dsn#">
            SELECT * FROM SETUP_SHIFTS WHERE IS_PRODUCTION = 1 AND FINISHDATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#"> AND SHIFT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.shift_id#">
        </cfquery>
        <cfif get_station_times.recordcount>
            <cfset calisma_start = (get_station_times.START_HOUR*60)+get_station_times.START_MIN />
            <cfset calisma_finish = (get_station_times.END_HOUR*60)+get_station_times.END_MIN />
        <cfelse>
            <cfset calisma_start = 01 />
            <cfset calisma_finish = 1439 />
        </cfif>
        <cfquery name="get_station_select" datasource="#dsn3#">
            SELECT DISTINCT
                DATEPART(hh,START_DATE)*60+DATEPART(n,START_DATE) AS START_TIME,
                DATEPART(M,START_DATE) AS START_MONT,
                DATEPART(D,START_DATE) AS START_DAY,
                DATEPART(hh,FINISH_DATE)*60+DATEPART(n,FINISH_DATE) AS FINISH_TIME,
                DATEPART(M,FINISH_DATE) AS FINISH_MONT,
                DATEPART(D,FINISH_DATE) AS FINISH_DAY,
                datediff(d,START_DATE,FINISH_DATE) AS FARK,
                START_DATE,FINISH_DATE	
            FROM 
                PRODUCTION_ORDERS 
            WHERE 
                STATION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.station_id#"> AND 
                (START_DATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#"> OR FINISH_DATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#">)
        UNION ALL
            SELECT
                DISTINCT
                DATEPART(hh,START_DATE)*60+DATEPART(n,START_DATE) AS START_TIME,
                DATEPART(M,START_DATE) AS START_MONT,
                DATEPART(D,START_DATE) AS START_DAY,
                DATEPART(hh,FINISH_DATE)*60+DATEPART(n,FINISH_DATE) AS FINISH_TIME,
                DATEPART(M,FINISH_DATE) AS FINISH_MONT,
                DATEPART(D,FINISH_DATE) AS FINISH_DAY,
                datediff(d,START_DATE,FINISH_DATE) AS FARK,
                START_DATE,FINISH_DATE	
            FROM 
                PRODUCTION_ORDERS_CASH
            WHERE 
                STATION_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.station_id#"> AND 
                (START_DATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#"> OR FINISH_DATE > <cfqueryparam cfsqltype="cf_sql_timestamp" value="#_now_#">)
            ORDER BY 
                START_DATE ASC,FINISH_DATE ASC
        </cfquery>
        <cfset full_days ='' />	<!---dolu olan günleri yani iş yüklemesi yapamıyacağım günleri belirliyoruz. --->
        <cfset production_type = arguments.production_type /><!--- 0 ise sürekli üretim 1 ise parçalı üretim yapacak  --->
        <!--- Üretimlerimizin içinden başlangıç ve bitiş saatlerini hesaplayarak çalışma saatlerimizi şekillendiriyoruz. --->
        <table cellpadding="1" cellspacing="1" border="1" width="100%" class="">
        <cfoutput query="get_station_select">
            <cfset p_start_day = DateFormat(START_DATE,'YYYYMMDD') />
            <cfset p_finish_day = DateFormat(FINISH_DATE,'YYYYMMDD') />
           <tr>
            <cfif FARK gt 0><!--- Başlangıç ve bitiş tarihleri aynı olmayan üretim emirleri gelsin sadece. --->
                <cfloop from="0" to="#FARK#" index="_days_">
                    <cfset new_days = DateFormat(date_add('D',_days_,START_DATE),'YYYYMMDD') />
                    <cfif not ListFind(full_days,new_days,',') and new_days gte DateFormat(_NOW_,'YYYYMMDD')><!--- DOLU GÜNLER İÇİNDE OLMAYAN GÜNLER GELSİN SADECE --->
                        <cfif not isdefined('empty_days#new_days#') OR(isdefined('empty_days#new_days#') and not len(Evaluate('empty_days#new_days#')))><cfset 'empty_days#new_days#' = '#calisma_start#-#calisma_finish#' /><!--- ----#new_days# ---></cfif>
                            <td>
                                <cfif new_days eq p_start_day><!--- Üretimin Başladığı Gün ise --->
                               <font color="33CC33">#new_days#[#START_TIME#]</font>
                                    <cfif START_TIME lte ListGetAt(Evaluate('empty_days#new_days#'),2,'-') and START_TIME gte ListGetAt(Evaluate('empty_days#new_days#'),1,'-')><!--- Üretim zamanımız çalışma saatleri arasında ise --->
                                       <cfset 'empty_days#new_days#' = '#ListGetAt(Evaluate('empty_days#new_days#'),1,'-')#-#START_TIME-1#' />
                                    </cfif>
                                <cfelseif new_days eq p_finish_day><!--- Üretimin Bittiği Gün ise --->
                                <font color="FF0000">bitiş=>#new_days#[#FINISH_TIME#]</font>
                                    <!--- <cfif ListLen(Evaluate('empty_days#new_days#'),'-') lt 2>#new_days#cccc#Evaluate('empty_days#new_days#')#aaaa<cfabort></cfif> --->
                                    <cfif FINISH_TIME lte ListGetAt(Evaluate('empty_days#new_days#'),2,'-') and FINISH_TIME gte ListGetAt(Evaluate('empty_days#new_days#'),1,'-')>
                                        <cfset 'empty_days#new_days#' = '#FINISH_TIME+1#-#ListGetAt(Evaluate('empty_days#new_days#'),2,'-')#' />
                                    <cfelseif  FINISH_TIME gte ListGetAt(Evaluate('empty_days#new_days#'),2,'-')><!--- eğer bitiş zamanı çalışma saatlerinin üzerinde ise,o zamanda o günüde dolu günler arasına alıyoruz. --->
                                        <cfset full_days =ListAppend(full_days,new_days,',') />#new_days#
                                    </cfif>
                                <cfelse><!--- Üretimin başlagıç ve bitiş tarihi arasında kalan günler ise bu günler zaten üretim ile dolu günler olduğu için direkt olarak kapatıyoruz. --->
                                    <cfset full_days =ListAppend(full_days,new_days,',') />#new_days#XX
                                </cfif>
                               <!--- ///[#Evaluate('empty_days#new_days#')#]// --->
                           </td>
                      </cfif>
                </cfloop>
            </cfif>
            </tr>
        </cfoutput>
        </table>
        <!--- bURDA İSE BAŞLANGIÇ VE BİTİŞ GÜNLERİ AYNI OLAN ÜRETİMLERİ ŞEKİLLENDİRİCEZ. --->
        <cfoutput query="get_station_select">
            <cfset p_start_day = DateFormat(START_DATE,'YYYYMMDD') />
            <cfif FARK eq 0 and not listfind(full_days,p_start_day,',') and p_start_day gte DateFormat(_NOW_,'YYYYMMDD')><!--- Başlama ve bitiş tarihi aynı olan günler yani 1 gün içinde başlayıp biten üretimlere bakıyoruz. --->
                    <cfif not isdefined('empty_days#p_start_day#') OR (isdefined('empty_days#p_start_day#') and not len(Evaluate('empty_days#p_start_day#')))><cfset 'empty_days#p_start_day#' = '#calisma_start#-#calisma_finish#'></cfif>
                    <!--- <cfset days_list = listdeleteduplicates(ListAppend(days_list,p_start_day,',')) /> --->
                    <cfif START_TIME lt calisma_start><cfset START_TIME = calisma_start /></cfif>
                    <cfif FINISH_TIME lt calisma_finish><cfset FINISH_TIME = calisma_finish /></cfif>
                    <cfloop list="#Evaluate('empty_days#p_start_day#')#" index="list_d">
                         <cfif ListLen(list_d,'-') neq 2>
                            <cfset saat_basi=list_d /><!--- Sadece hata vermesin diye eklendi daha sonra silinecek! --->
                            <cfset saat_sonu=list_d+60 />
                            <cfset list_d = '#saat_basi#-#saat_sonu#' />
                        <cfelse>
                            <cfset saat_basi=ListGetAt(list_d,1,'-') />
                            <cfset saat_sonu=ListGetAt(list_d,2,'-') /><!--- 11:00-13:00 --->
                        </cfif>
                        <cfif START_TIME gt saat_basi and START_TIME lt saat_sonu and FINISH_TIME lt saat_sonu><!--- ortadaysa 11:30-12--->
                            <cfset aaa='#ListGetAt(list_d,1,'-')#-#START_TIME-1#' />
                            <cfset bb='#FINISH_TIME+1#-#ListGetAt(list_d,2,'-')#' />
                            <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),aaa) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),bb) />
                          <!--- ##=>111111 : #aaa#--<!--- #bb# ---><br/> <!---  ---> --->
                         <cfelseif START_TIME lte saat_basi and FINISH_TIME gt saat_basi and FINISH_TIME lt saat_sonu><!--- 9-12 --->
                            <cfset ccc = '#FINISH_TIME+1#-#ListGetAt(list_d,2,'-')#' />
                           <cfif listlen(Evaluate('empty_days#p_start_day#')) and list_d gt 0 and listfind(Evaluate('empty_days#p_start_day#'),list_d) gt 0>
                                <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                                <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),ccc) />
                            </cfif>
                          <!---  2222222 :#START_TIME#---#FINISH_TIME#--*#ccc#<br/><!---  ---> --->
                         <cfelseif START_TIME lte saat_basi and FINISH_TIME gt saat_basi and FINISH_TIME gte saat_sonu> <!--- 9-14 --->
                            <cfif listlen(Evaluate('empty_days#p_start_day#')) and list_d gt 0 and listfind(Evaluate('empty_days#p_start_day#'),list_d) gt 0>
                                <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            </cfif>
                         <cfelseif START_TIME lte saat_basi and  FINISH_TIME gt saat_basi and FINISH_TIME lt saat_sonu><!--- 11-12 --->
                            <cfset ffff = '#FINISH_TIME+1#-#ListGetAt(list_d,2,'-')#' />
                            <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),ffff) />
                           <!--- 33333333 :#START_TIME#---#FINISH_TIME#--*#ffff#<br/><!---  ---> --->
                         <cfelseif START_TIME gt saat_basi and  START_TIME lt saat_sonu and FINISH_TIME gte saat_sonu><!--- 12-13,12-14 --->
                            <cfset dddd = '#saat_basi#-#START_TIME-1#' />
                            <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),dddd) />
                         <!---  44444444 :#START_TIME#---#FINISH_TIME#--*#dddd#<br/><!---   ---> --->
                        <cfelseif START_TIME gt saat_basi and START_TIME lte saat_sonu and FINISH_TIME gte saat_sonu>
                            <cfset eeee = '#ListGetAt(list_d,1,'-')#-#START_TIME-1#' />
                            <cfset 'empty_days#p_start_day#' = ListDeleteAt(Evaluate('empty_days#p_start_day#'),listfind(Evaluate('empty_days#p_start_day#'),list_d)) />
                            <cfset 'empty_days#p_start_day#' = ListAppend(Evaluate('empty_days#p_start_day#'),eeee) />
                          <!---  555555 : ******#list_d#********-------#eeee#<br/> --->
                        <cfelseif (START_TIME lte calisma_start and FINISH_TIME gte calisma_finish)><!--- 9-14 --->
                            <!--- kapandı: --->
                            <cfset full_days = ListAppend(full_days,p_start_day,',') />
                        </cfif>
                    </cfloop>
               <!---     #p_start_day#==>#Evaluate('empty_days#p_start_day#')#</font> <br/>
                  #p_start_day#==>[[#Evaluate('empty_days#p_start_day#')#]]<br/>
                    #Evaluate('empty_days#p_start_day#')#***#START_TIME#-#FINISH_TIME#<br/> --->
            </cfif>
        </cfoutput>
        <cfset uretim_birlesim_dakika = 0 />
        <cfoutput>
            <cfset songun = 365 /><!--- üretim verildikten sonra 1 yıl boyunca boş zamana bakıyoruz. --->
            <cfloop from="0" to="#songun#" index="_i_n_d_">
                <cfset crate_days = DateFormat(date_add('d',_i_n_d_,_NOW_),'YYYYMMDD') /><!--- ilk gün olarak bugünü alıyoruz. --->
                <cfif not listfind(full_days,crate_days,',')><!--- Yukarda belirlediğimiz dolu günlerin içinde değil ise --->           
                    <cfif not isdefined('empty_days#crate_days#') OR(isdefined('empty_days#crate_days#') and not len(Evaluate('empty_days#crate_days#')))><cfset 'empty_days#crate_days#' = '#calisma_start#-#calisma_finish#'><!--- tanımlanmamış boş kalmış günleri çalışma saatlerinin zamanlarını atıyoruz. ---></cfif>
                    <cfset last_empty_time = listlast(Evaluate('empty_days#crate_days#'),',') /><!---sonzaman=>günün son boş saatinin aralığı mesela [15:15-16:20],[17:00-19:30] saatleri boş zamanlar olsun,sondan ekleme yapmak için burda[17:00-19:30] luk kısmı getiriyor.  --->
                    <cfset next_day = DateFormat(date_add('d',_i_n_d_+1,now()),'YYYYMMDD') /><!--- bir sonraki günü belirliyoruz. --->
                    <cfif DateFormat(_NOW_,'YYYYMMDD') eq crate_days><!--- eğer bugüne bakılıyorsa  --->
                        <cfset now_minute = (ListGetAt(TimeFormat(_now_,'HH:MM'),1,':') * 60) + ListGetAt(TimeFormat(_now_,'HH:MM'),2,':') /><!--- şu anı dk olarak set ediyoruz. --->
                        <cfloop list="#Evaluate('empty_days#crate_days#')#" index="now_edit">
                            <!--- #now_minute#___#ListGetAt(now_edit,1,'-')#___#ListGetAt(now_edit,2,'-')# --->
                            <cfif now_minute gt ListGetAt(now_edit,1,'-') and now_minute lt ListGetAt(now_edit,2,'-')><!--- bugünün boş saatlerini şu andan sonra olacak şekilde düzenliyoruz. mesela şu anda saat 14:00 olsun,boş zaman [12:00-16:00] bu durumda bu boş zaman [14:00-16:00] arası oluyor. --->
                                 <cfset 'empty_days#crate_days#' = ListSetAt(Evaluate('empty_days#crate_days#'),ListFind(Evaluate('empty_days#crate_days#'),now_edit,','),"#now_minute#-#ListGetAt(now_edit,2,'-')#",',') />
                            <cfelseif now_minute gt ListGetAt(now_edit,1,'-') and now_minute gt ListGetAt(now_edit,2,'-')>
                                 <cfset full_days =ListAppend(full_days,crate_days,',') />
                            <cfelseif now_minute gt ListGetAt(now_edit,1,'-') and now_minute lt ListGetAt(now_edit,2,'-')>
                                 <cfif ListFind(full_days,crate_days,',') gt 0>
                                     <cfset full_days =ListDeleteAt(full_days,ListFind(full_days,crate_days,','),',') />
                                </cfif>
                                 <cfif ListFind(evaluate('empty_days#crate_days#'),now_edit,',')-1 gt 0>
                                     <cfset 'empty_days#crate_days#' =ListDeleteAt(evaluate('empty_days#crate_days#'),ListFind(evaluate('empty_days#crate_days#'),now_edit,',')-1,',') />
                                 </cfif>
                            <cfelseif now_minute lt ListGetAt(now_edit,1,'-') and now_minute lt ListGetAt(now_edit,2,'-')>
                                <cfif ListFind(full_days,crate_days,',') gt 0>
                                     <cfset full_days =ListDeleteAt(full_days,ListFind(full_days,crate_days,','),',') />
                                </cfif>
                                 <cfif ListFind(evaluate('empty_days#crate_days#'),now_edit,',')-1 gt 0>
                                     <cfset 'empty_days#crate_days#' =ListDeleteAt(evaluate('empty_days#crate_days#'),ListFind(evaluate('empty_days#crate_days#'),now_edit,',')-1,',') />
                                 </cfif>
                            </cfif>
                        </cfloop>
                    </cfif>#crate_days#==>#Evaluate('empty_days#crate_days#')#</font> <br/>
                    <cfif not listfind(full_days,crate_days,',')>
                    <cfif production_type eq 0><!--- continue üretim yapılıyor ise --->
                        <!--- #Evaluate('empty_days#crate_days#')#-- --->
                        <!--- #crate_days# #next_day#==> #Evaluate('empty_days#crate_days#')#==>sonzaman==> #last_empty_time# ==>birsonkgünbaş==>#next_first_empty_time# --->
                        <!--- <cfif ListLast(last_empty_time,'-') eq calisma_finish><!--- son boş zamanın bitiş saati istasyonun çalışma bitiş saatine eşitmi --->
                            <cfset last_time_diff = ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')>
                        <cfelse>    
                            <cfset last_time_diff = -1>
                        </cfif>bugünFarkı=>#last_time_diff# --->
                       <!---  <cfif ListFirst(next_first_empty_time,'-') eq calisma_start>
                            <cfset firs_time_diff =  ListLast(next_first_empty_time,'-')-ListFirst(next_first_empty_time,'-')>
                        <cfelse>    
                            <cfset firs_time_diff = -1>
                        </cfif>=>sonrakiGFark=>#firs_time_diff# --->
                        <!--- günler bazında --->
                        <!--- birgün boşluğuna girecek bir üretim ise boş olan zamanlar dönsün --->
                        <cfif gerekli_uretim_zamani_dak lte (calisma_finish-calisma_start)><!--- 1 gün içinde bitebilecek bir üretim ise günün içindeki boş zamanlara bakıyoruz. --->
                             <cfloop list="#Evaluate('empty_days#crate_days#')#" index="l_list">
                                <cfif ListGetAt(l_list,2,'-')-ListGetAt(l_list,1,'-') gte gerekli_uretim_zamani_dak>
                                    <cfset finded_production_start_day = crate_days />
                                    <cfset finded_production_finish_day = crate_days />
                                    <cfset finded_production_start_time = "#Int(ListGetAt(l_list,1,'-')/60)# : #ListGetAt(l_list,1,'-') mod 60#" />
                                    <cfset finded_production_finish_time = "#Int((ListGetAt(l_list,1,'-')+gerekli_uretim_zamani_dak)/60)# : #(ListGetAt(l_list,1,'-')+gerekli_uretim_zamani_dak) mod 60#" />
                                   <!---  bulundu!**#finded_production_start_day# -- #finded_production_start_time#-#finded_production_finish_time#<br/> --->
                                    <cfset finded_production_start_finish_times = "#finded_production_start_day#,#finded_production_start_time#,#finded_production_finish_day#,#finded_production_finish_time#" />
                                <cfreturn finded_production_start_finish_times>
                                    <cfexit method="exittemplate"><!--- uygun aralığı bulursa çıksın --->
                                </cfif>
                            </cfloop>
                        </cfif>
                        <!--- birbirni takip eden günlerde üretim. --->
                        <cfif not listfind(full_days,next_day,',')><!--- bir sonraki gün dolu günler arasında değilse  --->
                            <cfif not isdefined('empty_days#next_day#')><!--- bir sonraki günün başlagınç zamanını alıcaz mesela 09:15-12:20 --->
                                <cfset next_first_empty_time = '#calisma_start#-#calisma_finish#' />
                            <cfelse>
                                <cfset next_first_empty_time = ListFirst(Evaluate('empty_days#DateFormat(date_add('d',_i_n_d_+1,now()),'YYYYMMDD')#'),',') />
                            </cfif>
                        <cfelse> 
                            <cfset next_first_empty_time = -1 />
                        </cfif>
                        <cfif (not listfind(full_days,next_day,',')) and<!--- bulduğumuz bir sonraki gün dolu günler arasında değil ise --->
                               (ListLast(last_empty_time,'-') eq calisma_finish) and<!--- bugünün son boş zamanının bitiş saati calisma programının bitiş saati ile eşitmi --->
                               (ListFirst(next_first_empty_time,'-') eq calisma_start)<!--- bir sonraki gündeki boş zamanın başlangıç saati calisma programının başlamgıç saati ile eşitmi --->
                               >
                               <!--- <font color="0000FF">#Evaluate('empty_days#crate_days#')# uz:#ListLen(Evaluate('empty_days#crate_days#'),',')#</font> --->
                                <cfif ListLen(Evaluate('empty_days#crate_days#'),',') neq 1><!--- bir taneden fazla boş çalışma anı varsa eğer günümüzde yani =>[10:05-12:30],[13:13-15:00] böyle ise --->
                                    <cfset finded_production_start_time = "#Int(ListGetAt(last_empty_time,1,'-')/60)# : #ListGetAt(last_empty_time,1,'-') mod 60#" />
                                    <cfset finded_production_start_day = crate_days />
                                    <cfset uretim_birlesim_dakika = ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')+ListLast(next_first_empty_time,'-')-ListFirst(next_first_empty_time,'-') />
                                <cfelseif ListFirst(next_first_empty_time,'-') eq calisma_start and ListLast(next_first_empty_time,'-') eq calisma_finish><!--- bir sonraki gündeki boş zamanın başlangıç saati calisma programının başlamgıç saati ile eşitmi --->
                                    <cfset uretim_birlesim_dakika = uretim_birlesim_dakika + (ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')) />
                                <cfelse>
                                    <cfset uretim_birlesim_dakika = uretim_birlesim_dakika + (ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')) + ListLast(next_first_empty_time,'-')-ListFirst(next_first_empty_time,'-') />
                                </cfif>	  
                        <cfelse>
                                <cfset uretim_birlesim_dakika = 0 />
                        </cfif>
                        <!---bulunan zamanı karşılaştırıyoruz. --->
                        <cfif uretim_birlesim_dakika gte gerekli_uretim_zamani_dak>
                            <!--- <font color="66666"> --->
                                <cfif not isdefined('finded_production_start_day')>
                                    <cfset finded_production_start_day = crate_days />
                                    <cfset finded_production_start_time = "#Int(ListGetAt(last_empty_time,1,'-')/60)# : #ListGetAt(last_empty_time,1,'-') mod 60#" />
                                </cfif>
                                <cfset _fark_ = uretim_birlesim_dakika-gerekli_uretim_zamani_dak />
                                <cfset finded_production_finish_day = next_day />
                                <cfset finded_production_finish_time =" #Int((ListGetAt(next_first_empty_time,2,'-') - _fark_)/60)# : #(ListGetAt(next_first_empty_time,2,'-') - _fark_) mod 60#" />
                           <!---  #finded_production_start_day#__#finded_production_start_time#-----#finded_production_finish_day# : #finded_production_finish_time#
                            BULUNDU!!!!!!!!!!!!!!!!!!</font> --->
                            <cfset finded_production_start_finish_times = "#finded_production_start_day#,#finded_production_start_time#,#finded_production_finish_day#,#finded_production_finish_time#" />
                            <cfreturn finded_production_start_finish_times>
                            <cfexit method="exittemplate">
                        </cfif>
                    <cfelse><!--- Parçalı Üretim yapılıyorsa --->
                          <cfif uretim_birlesim_dakika eq 0><!--- ilk günümüz belli oluyor.--->
                                <cfset finded_production_start_day = crate_days /><cfif listlen(Evaluate('empty_days#finded_production_start_day#'),'-') lt 2>DOLU GÜNLER =>#full_days#---#finded_production_start_day#=>#Evaluate('empty_days#finded_production_start_day#')#--</cfif>
                                <cfset finded_production_start_time = "#Int(ListFirst(Evaluate('empty_days#finded_production_start_day#'),'-')/60)# : #ListFirst(Evaluate('empty_days#finded_production_start_day#'),'-') mod 60#" />
                          </cfif>
                           <font color="FF0000">#Evaluate('empty_days#crate_days#')#</font><br/>
                          <cfloop list="#Evaluate('empty_days#crate_days#')#" index="new_indx">
                                <cfset uretim_birlesim_dakika = uretim_birlesim_dakika + (ListGetAt(new_indx,2,'-')-ListGetAt(new_indx,1,'-')) />
                                <cfif uretim_birlesim_dakika gte gerekli_uretim_zamani_dak>
                                    <cfset finded_production_finish_day = crate_days /><!--- üretimin dolduğu anı buluyoruz. --->
                                    <cfset onceki_uretim_birlesim_dakika = uretim_birlesim_dakika-(ListGetAt(new_indx,2,'-')-ListGetAt(new_indx,1,'-')) />
                                    <cfset fark = gerekli_uretim_zamani_dak-onceki_uretim_birlesim_dakika />
                                    <cfset finded_production_finish_time =" #Int(((ListGetAt(new_indx,1,'-')+fark))/60)# : #((ListGetAt(new_indx,1,'-')+fark)) mod 60#" />
                                    <cfset finded_production_start_finish_times = "#finded_production_start_day#,#finded_production_start_time#,#finded_production_finish_day#,#finded_production_finish_time#" />
                               <cfreturn finded_production_start_finish_times>
                                    <cfexit method="exittemplate">
                                </cfif>
                          </cfloop>
                    </cfif>
                    </cfif>
                    <!--- bu satırlar silinmesin bunlar test yaparken gerekli oluyor. 
                   <font color="red">#ListLast(last_empty_time,'-')-ListFirst(last_empty_time,'-')#<!--- +#ListLast(next_first_empty_time,'-')-ListFirst(next_first_empty_time,'-')# --->==>[[[#uretim_birlesim_dakika#]]]</font>--->
                </cfif>
            </cfloop>
        </cfoutput>
    </cffunction>
      <cffunction name="wrk_round" returntype="string" output="false">
        <cfargument name="number" required="true">
        <cfargument name="decimal_count" required="no" default="2">
        <cfargument name="kontrol_float" required="no" default="0"><!--- ürün ağacında çok ufak değerler girildiğinde E- formatında yazılanlar bozulmasın diye eklendi SM20101007 --->
        <cfscript>
            if (not len(arguments.number)) return '';
            if(arguments.kontrol_float eq 0)
            {
                if (arguments.number contains 'E') arguments.number = ReplaceNoCase(NumberFormat(arguments.number), ',', '', 'all');
            }
            else
            {
                if (arguments.number contains 'E') 
                {
                    first_value = listgetat(arguments.number,1,'E-');
                    first_value = ReplaceNoCase(first_value,',','.');
                    last_value = ReplaceNoCase(listgetat(arguments.number,2,'E-'),'0','','all');
                    //if(last_value gt 5) last_value = 5;
                    for(kk_float=1;kk_float lte last_value;kk_float=kk_float+1)
                    {
                        zero_info = ReplaceNoCase(first_value,'.','');
                        first_value = '0.#zero_info#';
                    }
                    arguments.number = first_value;
                            first_value = listgetat(arguments.number,1,'.');
                arguments.number = "#first_value#.#Left(listgetat(arguments.number,2,'.'),8)#";
                    if(arguments.number lt 0.00000001) arguments.number = 0;
                    return arguments.number;
                }
            }
            if (arguments.number contains '-'){
                negativeFlag = 1;
                arguments.number = ReplaceNoCase(arguments.number, '-', '', 'all');}
            else negativeFlag = 0;
            if(not isnumeric(arguments.decimal_count)) arguments.decimal_count= 2;	
            if(Find('.', arguments.number))
            {
                tam = listfirst(arguments.number,'.');
                onda =listlast(arguments.number,'.');
                if(onda neq 0 and arguments.decimal_count eq 0) //yuvarlama sayısı sıfırsa noktadan sonraki ilk rakama gore tam kısımda yuvarlama yapılır
                {
                    if(Mid(onda, 1,1) gte 5) // yuvarlama 
                        tam= tam+1;	
                }
                else if(onda neq 0 and len(onda) gt arguments.decimal_count)
                {
                    if(Mid(onda,arguments.decimal_count+1,1) gte 5) // yuvarlama
                    {
                        onda = Mid(onda,1,arguments.decimal_count);
                        textFormat_new = "0.#onda#";
                        textFormat_new = textFormat_new+1/(10^arguments.decimal_count);
                        
                        decimal_place_holder = '_.';
                        for(decimal_index=1;decimal_index<=arguments.decimal_count;++decimal_index)
                            decimal_place_holder = '#decimal_place_holder#_';
                        textFormat_new = LSNumberFormat(textFormat_new,decimal_place_holder);
                            
                        if(listlen(textFormat_new,'.') eq 2)
                        {
                            tam = tam + listfirst(textFormat_new,'.');
                            onda =listlast(textFormat_new,'.');
                        }
                        else
                        {
                            tam = tam + listfirst(textFormat_new,'.');
                            onda = '';
                        }
                    }
                    else
                        onda= Mid(onda,1,arguments.decimal_count);
                }
            }
            else
            {
                tam = arguments.number;
                onda = '';
            }
            textFormat='';
            if(len(onda) and onda neq 0 and arguments.decimal_count neq 0)
                textFormat = "#tam#.#onda#";
            else
                textFormat = "#tam#";
            if (negativeFlag) textFormat =  "-#textFormat#";
            return textFormat;
        </cfscript>
    </cffunction>
	   <cffunction name="writeTree_operation" returntype="void">
            <cfargument name="next_stock_id">
            <cfargument name="next_spec_id">
            <cfargument name="next_product_tree_id">
            <cfargument name="type">
     		<cfscript>
				var i = 1;
				var sub_products = get_subs_operation(next_stock_id,next_spec_id,next_product_tree_id,type);
				attributes.deep_level_op = attributes.deep_level_op + 1;
				for (i=1; i lte listlen(sub_products,'█'); i = i+1)
				{
					_next_product_tree_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),1,'§');//alt+987 = █ --//alt+789 = §
					_next_spect_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),2,'§');
					_next_stock_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),3,'§');
					_next_amount_ = ListGetAt(ListGetAt(sub_products,i,'█'),4,'§');
					_next_operation_id_ = ListGetAt(ListGetAt(sub_products,i,'█'),5,'§');
					_next_deep_level_ = ListGetAt(ListGetAt(sub_products,i,'█'),6,'§');
					product_tree_id_list = listappend(product_tree_id_list,_next_product_tree_id_,',');
					operation_type_id_list = listappend(operation_type_id_list,_next_operation_id_,',');
					amount_list = listappend(amount_list,_next_amount_,',');
					"deep_level_#_next_operation_id_#" = _next_deep_level_;
					deep_level_list = listappend(deep_level_list,_next_deep_level_,',');
					if(_next_operation_id_ gt 0) type_=3;else type_=0;
		
					if(attributes.deep_level_op lt 40)
					{
						writeTree_operation(_next_stock_id_,_next_spect_id_,_next_product_tree_id_,type_);
					}
				 }
			 </cfscript>
        </cffunction>
<cfdump  var="#attributes#">
<cfparam name="attributes.connect_type" default="1">
<cfparam name="attributes.is_submit" default="0">
<cfset gui=listgetat(createUUID(),1,"-")>
<div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%">
        <div style="box-shadow:1px 1px 20px 0px #c4c7ca;padding:0.5%"><span style="text-shadow: 2px 1px 2px #93beff" class="text-primary fs-3">Birleştir</span></div>
<cfif attributes.connect_type eq 1>
    <cfform method="post" action="#request.self#?fuseaction=#attributes.fuseaction#">
        <cfset op_data_1=deserializeJSON(attributes.operation_data)[1][1]>        
        <cfset op_data_2=deserializeJSON(attributes.operation_data)[2][1]>
        <cfif op_data_1.OPERATION_TYPE_ID  neq op_data_2.OPERATION_TYPE_ID>
            <div class="alert alert-warning"><code style="font-size:14pt !important"><i class="fas fa-exclamation-triangle"></i> Sadece Aynı Operasyonları Birleştirebilirsiniz !</code></div>
            <cfabort>
        </cfif>
        <cfquery name="getOP" datasource="#dsn3#">
            SELECT O_MINUTE FROM OPERATION_TYPES WHERE OPERATION_TYPE_ID=#op_data_1.OPERATION_TYPE_ID#
        </cfquery>
        <cfquery name="getLot" datasource="#dsn3#">
            select PRODUCTION_LOT_NO,PRODUCTION_LOT_NUMBER from GENERAL_PAPERS WHERE PRODUCTION_LOT_NUMBER IS NOT NULL
        </cfquery>
        <cfquery name="getOpI" datasource="#dsn3#">
            SELECT S.STOCK_CODE,SP.SPECT_MAIN_ID,S.PRODUCT_CATID,S.PROPERTY,PT.* FROM catalyst_prod_1.PRODUCT_TREE AS PT 
            LEFT JOIN catalyst_prod_1.STOCKS AS S ON S.STOCK_ID=PT.STOCK_ID
            LEFT JOIN SPECT_MAIN as SP ON SP.STOCK_ID=PT.STOCK_ID
            WHERE OPERATION_TYPE_ID=#op_data_1.OPERATION_TYPE_ID# AND S.PRODUCT_CATID=1510
        </cfquery>    
        <cfoutput>        
            <input type="hidden" value='#attributes.operation_data#' name="operation_data">
            <input type="hidden" value="#dateformat(now(),'yyyy-mm-dd')#" name="DELIVER_DATE_1">
            <input type="hidden" value="" name="DETAIL">
            <input type="hidden" value="#dateformat(now(),'yyyy-mm-dd')#" name="FINISH_DATE_1">
            <input type="hidden" value="00" name="FINISH_H_1">
            <input type="hidden" value="00" name="FINISH_M_1">
            <input type="hidden" name="IS_LINE_NUMBER_1" value="0">
            <input type="hidden" name="IS_OPERATOR_DISPLAY_1" value="1">
            <input type="hidden" name="IS_STAGE" value="4">
            <input type="hidden" name="IS_TIME_CALCULATION_1" name="0">
            <input type="hidden" name="LOT_NO" value="#getLot.PRODUCTION_LOT_NO#-#getLot.PRODUCTION_LOT_NUMBER+1#">
            <input type="hidden" name="ORDER_ID_1" value="">
            <input type="hidden" name="ORDER_ROW_ID_1" value="">
            <input type="hidden" name="PROCESS_STAGE" value="59">
            <input type="hidden" name="PRODUCTION_ROW_COUNT_1" value="0">
            <cfset Tmount=op_data_1.P_AMOUNT+op_data_2.P_AMOUNT>
            <input type="hidden" name="PRODUCT_AMOUNT_1_0" value="#Tmount#">
            <input type="hidden" name="PRODUCT_VALUES_1_0" value="#getOpI.STOCK_ID#,0,0,0,#getOpI.SPECT_MAIN_ID#">
            <input type="hidden" name="PROJECT_ID_1" value="">
            <input type="hidden" name="SHOW_LOT_NO_COUNTER" value="0">
            <input type="hidden" name="START_DATE_1" value="#dateformat(now(),'yyyy-mm-dd')#">
            <input type="hidden" name="START_H_1" value="00">
            <input type="hidden" name="START_M_1" value="00">
            <input type="hidden" name="STOCK_RESERVED" value="1">
            <input type="hidden" name="station_id_1_0" value="">
            <input type="hidden" name="is_submit" value="1">
        </cfoutput>
        <div style="text-align:center" class="alert alert-warning"><code><cfoutput>#op_data_1.OPERATION_TYPE# ile #op_data_2.OPERATION_TYPE#</cfoutput> Birleşecektir <i class="fas fa-exclamation-triangle"></i></code>
            <br><button style="margin-right:10px;margin-top:10px" class="btn btn-outline-success" type="submit">Evet</button><button style="margin-top:10px" class="btn btn-outline-danger" type="button">Hayır</button>
        </div>
    </cfform>
</div>
<cfif attributes.is_submit eq 1>
    <cfif 1 eq 0><div class="alert alert-warning"><code style="font-size:14pt !important"><i class="fas fa-exclamation-triangle"></i> Sadece Aynı Operasyonları Birleştirebilirsiniz !</code></div><cfabort></cfif>    
    <cfquery name="getop1Res" datasource="#dsn3#">
            SELECT SUM(AMOUNT) AS AMOUNT,STOCK_ID,POR_STOCK_ID FROM catalyst_prod_1.PRODUCTION_ORDERS_STOCKS 
            WHERE STOCK_ID IN (SELECT RELATED_ID FROM catalyst_prod_1.PRODUCT_TREE WHERE STOCK_ID=#op_data_1.STOCK_ID#  
            AND DETAIL LIKE '%#getOpI.STOCK_ID#%') AND P_ORDER_ID IN(#op_data_1.P_ORDER_ID#) AND PRTOTM_DETAIL LIKE '%#getOpI.STOCK_ID#%' GROUP BY STOCK_ID,POR_STOCK_ID
    </cfquery>
    <cfquery name="getop2Res" datasource="#dsn3#">
            SELECT SUM(AMOUNT)  AS AMOUNT,STOCK_ID,POR_STOCK_ID FROM catalyst_prod_1.PRODUCTION_ORDERS_STOCKS 
            WHERE STOCK_ID IN (SELECT RELATED_ID FROM catalyst_prod_1.PRODUCT_TREE WHERE STOCK_ID=#op_data_2.STOCK_ID#  
            AND DETAIL LIKE '%#getOpI.STOCK_ID#%') AND P_ORDER_ID IN(#op_data_2.P_ORDER_ID#) AND PRTOTM_DETAIL LIKE '%#getOpI.STOCK_ID#%' GROUP BY STOCK_ID,POR_STOCK_ID
    </cfquery>
    <cfquery name="getSarfs" datasource="#dsn3#">
        SELECT S.STOCK_CODE,S.STOCK_ID FROM PRODUCT_TREE AS PT 
        LEFT JOIN STOCKS AS S ON S.STOCK_ID=PT.RELATED_ID
        WHERE PT.STOCK_ID=#getOpI.STOCK_ID#
    </cfquery>           
    <cfloop query="getop1Res">

        <cfquery name="tempIns" datasource="#dsn3#">
            EXEC DEL_INSERT_TEMP #POR_STOCK_ID#,#STOCK_ID#,#AMOUNT#,#op_data_1.P_OPERATION_ID#
        </cfquery>
    </cfloop>
    <cfloop query="getop2Res">
        <cfquery name="tempIns" datasource="#dsn3#">
            EXEC DEL_INSERT_TEMP #POR_STOCK_ID#,#STOCK_ID#,#AMOUNT#,#op_data_2.P_OPERATION_ID#
        </cfquery>
    </cfloop>
    <cfquery name="getT" datasource="#dsn3#">
        SELECT sum(amount) as TOTAL_AMOUNT,STOCK_ID FROM TEMP_PARTNER_FOR_BOYAHANE GROUP BY STOCK_ID
    </cfquery>

<cfinclude  template="/Modules/labratuvar/query/add_production_ordel_all.cfm">

<cfquery name="insertBirlesen" datasource="#dsn3#">
    INSERT INTO BOYAHANE_BIRLESEN (P_ORDER_ID,ORDER_ID,OPERATION_TYPE_ID) VALUES(#PARTNER_P_ORDER_ID#,#op_data_1.P_ORDER_ID#,#op_data_1.OPERATION_TYPE_ID#)
</cfquery>
<cfquery name="insertBirlesen" datasource="#dsn3#">
    INSERT INTO BOYAHANE_BIRLESEN (P_ORDER_ID,ORDER_ID,OPERATION_TYPE_ID) VALUES(#PARTNER_P_ORDER_ID#,#op_data_2.P_ORDER_ID#,#op_data_1.OPERATION_TYPE_ID#)
</cfquery>
<cfquery name="del_new_Sarf" datasource="#dsn3#">
    DELETE FROM PRODUCTION_ORDERS_STOCKS WHERE P_ORDER_ID=#PARTNER_P_ORDER_ID#
</cfquery>
<cfquery name="addSRow" datasource="#dsn3#">
SELECT 
#PARTNER_P_ORDER_ID# AS P_ORDER_ID
,S.PRODUCT_ID
,TPFFB.STOCK_ID
,SUM(AMOUNT) AS AMOUNT	
	,2 AS TYPE
	,S.PRODUCT_UNIT_ID
	,GETDATE() AS RECORD_DATE
	,#session.ep.USERID# AS RECORD_EMP
	,'185.51.36.99' AS RECORD_IP
	,0 AS IS_PHANTOM
	,0 AS IS_SEVK
	,0 AS IS_PROPERTY
	,0 AS IS_FREE_AMOUNT
	,0 AS FIRE_AMOUNT
	,0 AS FIRE_RATE
	,0 AS LINE_NUMBER
FROM TEMP_PARTNER_FOR_BOYAHANE AS TPFFB
LEFT JOIN STOCKS AS S ON S.STOCK_ID = TPFFB.STOCK_ID
WHERE S.STOCK_ID NOT IN (
		SELECT STOCK_ID
		FROM PRODUCTION_ORDERS_STOCKS
		WHERE P_ORDER_ID = #PARTNER_P_ORDER_ID#
		)
GROUP BY TPFFB.STOCK_ID
	,S.PRODUCT_UNIT_ID
	,S.PRODUCT_ID
</cfquery>
<cfloop query="addSRow">
<cfscript>
insertSarf(addSRow.STOCK_ID,PARTNER_P_ORDER_ID,addSRow.PRODUCT_ID,addSRow.PRODUCT_UNIT_ID,addSRow.AMOUNT);
</cfscript>
</cfloop>


<cfquery NAME="CLEAR_TEMP" DATASOURCE="#DSN3#">
    TRUNCATE TABLE TEMP_PARTNER_FOR_BOYAHANE
</cfquery>
</cfif>
<cfelseif attributes.connect_type eq 2>
</cfif>
   <cffunction name="insertSarf">
        <cfargument name="Stock_ID">
        <cfargument name="P_ORDERID">
        <cfargument name="PRODUCT_ID">
        <cfargument name="Unit_Id">
        <cfargument name="Amount">
        <cfset wrk_id_new_sarf = 'WRK#round(rand()*65)##dateformat(now(),'YYYYMMDD')##timeformat(now(),'HHmmssL')##session.ep.userid##round(rand()*100)#U#arguments.P_ORDERID#S#arguments.Stock_ID#'>
        <cfstoredproc procedure="ADD_PRODUCTION_ORDERS_STOCKS" datasource="#dsn3#">
            <cfprocparam cfsqltype="cf_sql_integer" value="#arguments.P_ORDERID#">
            <cfprocparam cfsqltype="cf_sql_integer" value="#arguments.PRODUCT_ID#">
            <cfprocparam cfsqltype="cf_sql_integer" value="#arguments.Stock_ID#">            
            <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">            
            <cfprocparam cfsqltype="cf_sql_float" value="#arguments.Amount#">
            <cfprocparam cfsqltype="cf_sql_integer" value="2">
            <cfprocparam cfsqltype="cf_sql_integer" value="#arguments.Unit_Id#">
            <cfprocparam cfsqltype="cf_sql_integer" value="#session.ep.userid#">
            <cfprocparam cfsqltype="cf_sql_timestamp" value="#now()#">
            <cfprocparam cfsqltype="cf_sql_varchar" value="#CGI.REMOTE_ADDR#">
            <cfprocparam cfsqltype="cf_sql_bit" value="0">
            <cfprocparam cfsqltype="cf_sql_bit" value="0">
            <cfprocparam cfsqltype="cf_sql_integer" value="0">
            <cfprocparam cfsqltype="cf_sql_bit" value="0">
            <cfprocparam cfsqltype="cf_sql_float" value="0">
            <cfprocparam cfsqltype="cf_sql_float" value="0">
            <cfprocparam cfsqltype="cf_sql_integer" value="NULL" null="yes">
            <cfprocparam cfsqltype="cf_sql_bit" value="1">
            <cfprocparam cfsqltype="cf_sql_varchar" value="#wrk_id_new_sarf#">
            <cfprocparam cfsqltype="cf_sql_integer" value="0">
        </cfstoredproc>
    </cffunction>