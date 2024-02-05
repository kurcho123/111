window.addEventListener("DOMContentLoaded", () => {
  if (window.nuiHandoverData.umloginscreen == "steam") {
    let getJson = JSON.parse(window.nuiHandoverData.json).response.players[0];
    $(".steamid").html(getJson.personaname);
  }
});

var myAudio = document.getElementById("music");
myAudio.volume = 0.2;
var isPaused = false;

$(window).on("message", function ({ originalEvent: e }) {
  switch (e.data.eventName) {
    case "loadProgress":
      $(".progress-value").css(
        "width",
        (e.data.loadFraction * 100).toFixed(0) + "%"
      );
      break;
  }
});

$(window).keypress(function (event) {
  let key = event.keyCode ? event.keyCode : event.which;

  if (key == 32) {
    isPaused == false ? myAudio.pause() : myAudio.play();
    isPaused = !isPaused;
  }
});
