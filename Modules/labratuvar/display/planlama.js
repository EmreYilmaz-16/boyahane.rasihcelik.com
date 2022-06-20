function Togler(el) {
    var eex = document.getElementById('view');
    if (durum == 1) {

        //.style.width = '30%';
        $(el.parentElement.parentElement.parentElement).animate({ width: "30%" }, 500);
        $(eex).animate({ width: "70%" }, 500);
        $('#innerAreaPlan').show(500)
        durum = 0;

    } else {
        $(el.parentElement.parentElement.parentElement).animate({ width: "4%" }, 500);
        $(eex).animate({ width: "96%" }, 500);
        $('#innerAreaPlan').hide(500)
        durum = 1;
    }
}
function expand(el) {
    var eex = document.getElementById('view');
    if (durum2 == 1) {

        //.style.width = '30%';
        $(el.parentElement.parentElement.parentElement).animate({ width: "96%" }, 500);
        $(eex).animate({ width: "4%" }, 500);
        $('#innerAreaPlan').show(500)
        durum2 = 0;        
    } else {
        $(el.parentElement.parentElement.parentElement).animate({ width: "4%" }, 500);
        $(eex).animate({ width: "96%" }, 500);
        $('#innerAreaPlan').hide(500)
        durum2 = 1;
    }
}
function AlertVer(){
    alert("Partner Tıklama")
}

var contextMenuItems = [
    {
        text: 'Share',
        items: [
            { text: 'Facebook',onItemClick:AlertVer },
            { text: 'Twitter' }]
    },
    { text: 'Download' },
    { text: 'Comment' },
    { text: 'Favorite' }
];
document.body.addEventListener('contextmenu',function(e){
    updateContextMenu(false, contextMenuItems, e, 'item', onItemClick(e));
    e.preventDefault();
    })
    