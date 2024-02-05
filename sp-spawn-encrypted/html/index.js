$(document).ready(function () {
  $(".container").hide();
  $(".select-character-type").hide();
  $(".info-box").hide();
  var current;
  var pos;
  var lastpos;
  var apartPos;

  window.addEventListener("message", function (event) {
    var data = event.data;
    if (data.type === "spawn") {
      lastpos = data.lastpos;
      apartPos = data.apartment.coords;
      $(".container").show();
      createButtons(data.data);
    } else if (data.type === "personamenu") {
      $(".select-character-type").css("display", "flex");
    } else if (data.type === "close") {
      $(".container").hide();
      $("#info").hide();
    }
  });

  function createButtons(data) {
    var len = data.length;
    for (i = 0; i < len; i++) {
      $(".spawn-points").append(
        '<div class="spawn-point" data-id=' +
          data[i].id +
          " data-x=" +
          data[i].coords.x +
          " data-y=" +
          data[i].coords.y +
          " data-z=" +
          data[i].coords.z +
          " data-label=" +
          data[i].label +
          ' id="loc' +
          data[i].id +
          '"><i class="fas fa-map-marker-alt" data-id=' +
          data[i].id +
          ' id="loc' +
          data[i].id +
          '"><div class="info-box" id="label' +
          data[i].id +
          '">' +
          data[i].label +
          "</div></i></div>"
      );

      $(".spawn-point")
        .find("[data-id=" + data[i].id + "]")
        .data("data", data[i]);
      $(".spawn-point")
        .find("[data-id=" + data[i].id + "]")
        .data("coords", data[i].coords);
      $(".spawn-point")
        .find("[data-id=" + data[i].id + "]")
        .data("id", data[i].id);
    }
  }

  $(document).on("mouseenter", ".spawn-point", function (e) {
    var th = $(this);
    $("#label" + th.data("id")).fadeIn(150);
    setTimeout(() => {
      $("#label" + th.data("id")).css("display", "flex");
      if (th.data("label") != null) {
        $("#label" + current).css("display", "none");
        $("#label" + current).fadeOut(150);
      }
    }, 150);
  });

  $(document).on("mouseleave", ".spawn-point", function (e) {
    var th = $(this);
    if ("#label" + th.data("id") != "#label" + current) {
      $("#label" + th.data("id")).fadeOut(150);
      setTimeout(() => {
        $("#label" + th.data("id")).css("display", "none");
      }, 150);
    }
  });

  $(document).on("click", ".spawn-point", function (e) {
    var th = $(this);
    // if (current != null) {
    //   $("#loc" + current).css("color", "rgb(255, 65, 65)");
    //   $("#loc" + current).css("font-size", "x-large");
    //   $("#label" + current).fadeOut(400);
    // }
    // $("#loc" + th.data("id")).css("color", "rgb(253, 253, 253)");
    current = th.data("id");
    pos = {
      x: th.data("x"),
      y: th.data("y"),
      z: th.data("z"),
    };

    console.log(JSON.stringify(pos));
    if (pos != null) {
      $(".container").fadeOut(500);
      $.post(
        "https://sp-spawn-encrypted/spawn",
        JSON.stringify({ coords: pos })
      );
      $("#info").hide();
    }
  });

  $(document).on("click", ".lastspawn", function (e) {
    $(".container").fadeOut(500);
    $.post(
      "https://sp-spawn-encrypted/sonkonum",
      JSON.stringify({ coords: pos })
    );
    $("#info").hide();
  });

  $(document).on("click", ".apartspawn", function (e) {
    $(".container").fadeOut(500);
    $.post(
      "https://sp-spawn-encrypted/spawn",
      JSON.stringify({ coords: apartPos })
    );
    $("#info").hide();
  });

  $(document).on("click", ".confirm", function (e) {
    let persona = $('input[name="persona"]:checked').val();

    if (persona == "undefined") {
      return console.error("Please select a persona!");
    }

    $(".select-character-type").fadeOut(500);
    $.post(
      "https://sp-spawn-encrypted/choosepersona",
      JSON.stringify({ persona: persona })
    );
    $("#info").hide();
  });
});
