let [minutes1, minutes2, seconds1, seconds2] = Array.from(
  document.querySelectorAll(".time .square")
);

function setTime(time) {
  var mind = time % (60 * 60);
  var minutes = Math.floor(mind / 60);

  var secd = mind % 60;
  var seconds = Math.ceil(secd);

  minutes = minutes.toString().split("");
  seconds = seconds.toString().split("");

  minutes2.innerHTML = minutes.length == 1 ? minutes[0] : minutes[1];
  // minutes1.innerHTML = minutes[1] == undefined ? "0" : minutes[1];
  minutes1.innerHTML = minutes.length > 1 ? minutes[0] : "0";

  seconds1.innerHTML = seconds.length > 1 ? seconds[0] : "0";
  // seconds1.innerHTML = seconds[0] == undefined ? "0" : seconds[0];
  seconds2.innerHTML = seconds.length == 1 ? seconds[0] : seconds[1];
}

window.addEventListener("message", (e) => {
  switch (e.data.action) {
    case "show":
      document.querySelector("body").style.display = "block";

      [minutes1, minutes2, seconds1, seconds2] = Array.from(
        document.querySelectorAll(".time .square")
      );
      break;
    case "hide":
      document.querySelector("body").style.display = "none";
      break;
    case "updateTime":
      setTime(e.data.time);
      break;
    case "updateText":
      if (e.data.canRevive == true) {
        document.querySelector(
          ".desc-text"
        ).innerHTML = `Задръж <span>(E)</span> за <span id="seconds-left">${e.data.secondsLeft}</span> секунди, за да се съживите за <span>$${e.data.cost}</span>`;
      } else {
        document.querySelector(".desc-text").innerHTML =
          "Вие сте в безсъзнание. Моля изчакайте докторите. Всичко ще бъде наред!";
      }
      break;
  }
});
