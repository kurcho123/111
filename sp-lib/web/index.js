$(function() {
    window.addEventListener('message', function(event) {
        var type = event.data.type;
        var data = event.data;
        if (type === 'showUI') {
           showTextUi(data)
        } else if (type === 'hideUI') {
           hideTextUi()
        } else if (type == 'showNotify') {
           showNotify(event.data.data)
        } else if(type == 'NotifyV2'){
            Notify(event.data.data)
        }
    });
});

var notifyCount = 0;

showTextUi = function(data) {
    let notify = `
    <div class="textuiContainer">
        <h1>${data.string}</h1>
    </div>`;

    // .textuiContainer'ı ekleyin
    $(".text").html(notify);

    // .textuiContainer elementini seçin
    let container = $('.textuiContainer');

    // Sağdan gelen animasyon
    container.css("right", "-300px");
    container.animate({ "right": "2vh" }, 350);
};

hideTextUi = function() {
    const notifyElement = $('.textuiContainer');

    // Sola kayarak kaybolan animasyon
    notifyElement.animate({ "right": "-300px" }, 350, function() {
        $(this).remove();
    });
}

showNotify = function(data) {
    notifyCount++;

    var color = '#fff';
    var type = 'info';
    var time = 3;
    var icon = 'circle-info'

    if(data.type == 'error'){
        color = '#FE4E4E';
        title = data.type;
        icon = 'circle-exclamation'
    } else if (data.type == 'success'){
        color = '#8CE75B';
        icon = 'circle-check'
        title = data.type
    } else if (data.type == 'info'){
        color = '#42D3E7';
        icon = 'circle-info'
        title = data.type
    }

    if (data.color){
        color = data.color  
    };

    if(data.time){
        time = data.time
    }

    let notify = `
    <div id="notify-${notifyCount}" class="NotifyContainer w3-animate-right">
        <div class="NotifyContent">
            <h3>
                <i class="fa-light fa-${icon}" style="color: ${color};"></i>
            </h3>
            <h4>${data.title}</h4>
            <p>${data.text}</p>
        </div>
    </div>`;

    $(".NotifyPart").append(notify);
    $(`#notify-${notifyCount}`).css("right", "-300px");
    $(`#notify-${notifyCount}`).animate({ "right": "0" }, 350);

    const notificationSound = document.getElementById("notificationSound");
    notificationSound.play();

    const notifyElement = $(`#notify-${notifyCount}`);
    const timeoutId = setTimeout(function() {
        notifyElement.animate({ "right": "-300px" }, 350, function() {
            $(this).remove();
        });
    }, 1000 * time);

    notifyElement.find(".closeButton").on("click", function() {
        clearTimeout(timeoutId);
        notifyElement.animate({ "right": "-300px" }, 350, function() {
            $(this).remove();
        });
    });

    const notifyContainers = $(".NotifyContainer");
    $(".NotifyPart").empty(); // Önce tüm bildirimleri temizle

    for (let i = notifyContainers.length - 1; i >= 0; i--) {
        $(".NotifyPart").append(notifyContainers[i]);
    }
}
