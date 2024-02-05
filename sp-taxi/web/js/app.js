let employed = false
var items = [];
var cards

window.addEventListener('message', function(event) {
    let item = event.data;
    if (item.type === "show") {
        if (item.status == true) {
            $('#requirements').html("");
            $("#main").fadeIn();
        } else {
            $('#requirements').html("");
            $("#main").fadeOut("fast");
        }
    } else if (item.type === "addrequirements") {
        $('#requirements').append (`
            <div class="item">
                <span>${item.data}</span>
            </div>
        `);
    } else if (item.type === "show_rent") {
        if (item.status == true) {
            $('#rentvehicle').fadeIn();
        } else {
            $('#rentvehicle').fadeOut();
        }
    } else if (item.type === "show_timer") {
        if (item.status == true) {
            $("#vehicletimer").fadeIn();
            $('#taximeter').fadeOut();
        } else {
            $('#taximeter').fadeIn();
            $("#vehicletimer").fadeOut();
        }
    } else if (item.type === "show_buy") {
        if (item.status == true) {
            $("#buy_company").fadeIn();
        } else {
            $("#buy_company").fadeOut("fast");
        }
    } else if (item.type === "show_orders") {
        if (item.status == true) {
            $.post(`https://${GetParentResourceName()}/get_cards`, JSON.stringify({}), function(items){
                Populate_Cards(items)
                cards = items
            });
            $("#bigtaxi_orders").fadeIn();
        } else {
            $("#bigtaxi_orders").fadeOut();
        }
    }
});

function button() {
    employed = !employed
    if (!employed) {
        buttontext.innerHTML = 'GET EMPLOYED'
        setTimeout(() => {
            $('#taximeter').fadeOut();
          }, 500);
    } else {
        buttontext.innerHTML = 'LEAVE'
    };
    
    $.post(`https://${GetParentResourceName()}/startjob`);
}

function button_rental() {
    $.post(`https://${GetParentResourceName()}/showrent`);
}

$(function(){
    $('#main').hide();
    $('#rentvehicle').hide();
    $('#vehicletimer').hide();
    $('#dbuy_company').hide();
    $('#buy_company').hide();
    $('#taximeter').hide();
    $('#bigtaxi_orders').hide();
    $('.wrapper').append (`
        <button onclick="button()" id="buttontext">GET EMPLOYED</button>
    `);
    $('.wrapper').append (`
        <button onclick="button_rental()">TRANSPORT RENTAL</button>
    `);

    window.addEventListener('message', function (event) {
        try {
            switch(event.data.action) {
                case 'jobdescription':
                    if (event.data.value != null) jobdescription.innerHTML = event.data.value;
                break;

                case 'button':
                    if (event.data.value != null) buttontext.innerHTML = event.data.value;
                break;

                case 'pricevehicle':
                    if (event.data.value != null) pricevehicle.innerHTML = '$' + event.data.value.toLocaleString();
                    if (event.data.value != null) price.innerHTML = '$' + event.data.value.toLocaleString();
                break;

                case 'price_company':
                    if (event.data.value != null) price_company.innerHTML = '$' + event.data.value.toLocaleString();
                break;

                case 'charactername':
                    if (event.data.value != null) charactername.innerHTML = event.data.value;
                break;

                case 'timer':
                    if (event.data.value != null) timer.innerHTML = event.data.value;
                break;

                case 'taximeter_earned':
                    taximeter_earned.innerHTML = '$' + event.data.value.toLocaleString();
                break;

                case 'taximeter_state':
                    taximeter_state.innerHTML = event.data.value;
                break;
            }
    } catch(err) {}
    });
    
    $(document).keyup(function(e) {
        if (e.key === "Escape") { 
            $("#main").fadeOut("fast");
            $("#rentvehicle").fadeOut("fast");
            $("#dbuy_company").fadeOut();
            $("#bigtaxi_orders").fadeOut();
            $.post(`https://${GetParentResourceName()}/close`);
        }
    });
    
    $('#cancel').on('click', function(){
        $('#rentvehicle').fadeOut();
        $.post(`https://${GetParentResourceName()}/close`);
    });

    $('#cancel_buy').on('click', function(){
        $('#dbuy_company').fadeOut();
        $.post(`https://${GetParentResourceName()}/close`);
    });

    $('#rent').on('click', function(){
        $('#rentvehicle').fadeOut();
        $.post(`https://${GetParentResourceName()}/rentvehicle`);
    });
    
    $('#buy').on('click', function(){
        $('#dbuy_company').fadeOut();
        $.post(`https://${GetParentResourceName()}/buy_company`);
    });
    
    $(`#button`).click(function(){
        $.post(`https://${GetParentResourceName()}/startjob`);
    });
    
    $('#buy_company').on('click', function(){
        $("#main").fadeOut("fast");
        $.post(`https://${GetParentResourceName()}/setprice`);
        $('#dbuy_company').fadeIn();
    });
    
    $(`#gov_orders`).click(function(){
        $.post(`https://${GetParentResourceName()}/start_gov_order`);
    });
})

Populate_Cards = function(items) {
    if (items !== null && items !== undefined && items !== "" && items.length > 0) {
        $("#cont").html("");
        var count = 0;

        $.each(items, function(i, item) {
            ++count;
            let itemHTML = `
                <tr class="card-${item.id}">
                    <td>${item.caller}</td>
                    <td>${item.distance}</td>
                    <td><button id="btn-${item.id}" class="btn-accept">ACCEPT THE ORDER</button></td>
                </tr>
            `
            $("#cont").append(itemHTML);
            $(`#btn-${item.id}`).on('click', function() {
                $('#bigtaxi_orders').fadeOut("fast");
                $.post(`https://${GetParentResourceName()}/action`, JSON.stringify({
                    action: "takeOrder",
                    value: item
                }));
                $('.card-' + item.id).fadeOut("fast");
                var callnumbersText = document.getElementById("free_orders_count").textContent;
                var callnumbersNumber = parseInt(callnumbersText);
                var newCallnumbersNumber = callnumbersNumber - 1;
                document.getElementById("free_orders_count").textContent = newCallnumbersNumber.toString();
            })
        })

        document.getElementById("free_orders_count").textContent = count || 0;
    }
}