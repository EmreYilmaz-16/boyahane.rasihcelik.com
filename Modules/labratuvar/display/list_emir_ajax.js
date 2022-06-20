var pidArr = new Array();
var sidArr = new Array();
function PartiEkle(p_order_id, stock_id, amount, nick_name, color, product_name, el) {
    $(el.parentElement.parentElement).remove();
    var tr = document.createElement("tr");
    var td1 = document.createElement("td");
    var i1 = document.createElement("input")
    var i2 = document.createElement("input")
    var i3 = document.createElement("input")
    i1.setAttribute("type", "hidden");
    i2.setAttribute("type", "hidden");
    i3.setAttribute("type", "hidden");
    i1.setAttribute("name", "p_order_id");
    i2.setAttribute("name", "StockId" + p_order_id);
    i3.setAttribute("name", "Amount" + p_order_id);
    i1.value = p_order_id;
    i2.value = stock_id;
    i3.value = amount;
    td1.innerText = nick_name + " - " + product_name;
    td1.appendChild(i1)
    td1.appendChild(i2)
    td1.appendChild(i3)
    var td2 = document.createElement("td");
    td2.innerText = color;
    var td3 = document.createElement("td");
    td3.innerText = product_name;
    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    var e = document.getElementById("partList");
    var sslen = sidArr.length
    if (sidArr.length == 0) {
        e.appendChild(tr);
        sidArr.push(stock_id);
    } else {
        for (let i = 0; i < sslen; i++) {
            if (sidArr[i] != stock_id) {
                var es = confirm("Sepetteki Ürünlerle Uyumsuz")
                if (es) {
                    e.appendChild(tr);
                    sidArr.push(stock_id);
                }
            } else {
                console.log(i)
                e.appendChild(tr);
                sidArr.push(stock_id);
            }
        }
    }

}