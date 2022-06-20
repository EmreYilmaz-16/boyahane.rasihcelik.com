<cfscript>
WOStruct=structNew();
WOStruct['#attributes.fuseaction#']=StructNew();
if(attributes.event eq "list"){
    WOStruct['#attributes.fuseaction#']['list'] = structNew();
    WOStruct['#attributes.fuseaction#']['list']['window'] = 'normal';
    WOStruct['#attributes.fuseaction#']['list']['fuseaction'] = 'assetcare.form_search_accident';
    WOStruct['#attributes.fuseaction#']['list']['filePath'] = 'V16/assetcare/form/form_search_accident.cfm';
}
if(attributes.event eq "add"){
    WOStruct['#attributes.fuseaction#']['add']['window'] = 'normal';
    WOStruct['#attributes.fuseaction#']['add']['fuseaction'] = 'assetcare.form_add_accident';
    WOStruct['#attributes.fuseaction#']['add']['filePath'] = 'V16/assetcare/form/form_add_accident.cfm';
    WOStruct['#attributes.fuseaction#']['add']['queryPath'] = 'V16/assetcare/form/add_accident.cfm';
    WOStruct['#attributes.fuseaction#']['add']['nextEvent'] = '';
}
if(attributes.event eq "upd"){
    WOStruct['#attributes.fuseaction#']['upd'] = structNew();
    WOStruct['#attributes.fuseaction#']['upd']['window'] = 'popup';
    WOStruct['#attributes.fuseaction#']['upd']['fuseaction'] = 'assetcare.popup_upd_accident';
    WOStruct['#attributes.fuseaction#']['upd']['filePath'] = 'V16/assetcare/form/upd_accident.cfm';
    WOStruct['#attributes.fuseaction#']['upd']['queryPath'] = 'V16/assetcare/query/upd_accident.cfm';
    WOStruct['#attributes.fuseaction#']['upd']['nextEvent'] = '';
}
</cfscript>