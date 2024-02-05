const open = (data) => {
  $('#corner1').show();
  $('#corner2').show();
  $('#corner3').show();
  $('#corner4').show();
  $('#battery').show();
  $('#dot').show();
  $('#date').text(data.date);
  $('#record').text("REC");
}

const close = () => {
  $('#corner1').hide();
  $('#corner2').hide();
  $('#corner3').hide();
  $('#corner4').hide();
  $('#battery').hide();
  $('#dot').hide();
  $('#date').text('');
  $('#rec').text('');
}

window.addEventListener('message', function(event) {

    if (event.data.type == "copy") {
        let temp = document.createElement('textarea');
        let selection = document.getSelection();
        console.log(event.data.copy)

        temp.textContent = event.data.copy;
        document.body.appendChild(temp);

        selection.removeAllRanges();
        temp.select();
        document.execCommand('copy');

        selection.removeAllRanges();
        document.body.removeChild(temp);
    } else if (event.data.type == "open") {
        open();
    } else if (event.data.type == "close") {
        close();
    }
});