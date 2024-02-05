var categoryVehicleSelected = "all";
var vehicleSelected = {};
var isEnableTestDrive = false;
var dataVehicles = [];
var handlingVehicle = [];
var selectedColor = "primary";

window.addEventListener("message", function (event) {
  var data = event.data;
  if (data.type == "display") {
    $("body").fadeIn();
    isEnableTestDrive = data.testDrive;
    document.getElementById("top-menu").innerHTML =
      '<a href="#all" onclick="menuVehicle(event)" value="all" class="selected">all</a>';
    for (var [key, value] of Object.entries(data.data)) {
      $(".top-menu").append(
        `
                <a href="#` +
          key +
          `" onclick="menuVehicle(event)" value="` +
          key +
          `">` +
          key +
          `</a>
            `
      );
      for (var [k, v] of Object.entries(value)) {
        dataVehicles.push(v);
      }
    }
    Dealership.Open(dataVehicles);
    //  document.getElementById("playerName").innerHTML = data.playerName;
    //  document.getElementById("playerMoney").innerHTML = data.playerMoney;
  }
  if (data.type == "hide") {
    $("body").fadeOut();
    dataVehicles = [];
    document.getElementById("nameBrand").innerHTML = "";
    document.getElementById("contentVehicle").innerHTML = "";
    document.getElementById("vehiclebrand").innerHTML = "";
    document.getElementById("carouselCars").innerHTML = "";
  }
  if (data.type == "menu") {
    for (var [k, v] of Object.entries(data.data)) {
      dataVehicles.push(v);
    }
    Dealership.Open(dataVehicles);
  }
  if (data.type == "successful-buy") {
    $("#messagePopup").css("background-color", "rgba(0,0,0,0.4)");
    $("#messagePopup").fadeIn(500);
    $("#messagePopup").append(
      `
        <span>You bought: ` +
        data.vehicleName +
        ` for ` +
        data.value +
        `</span>
        `
    );
    setTimeout(function () {
      $("#messagePopup").fadeOut(500);
      document.getElementById("messagePopup").innerHTML = "";
    }, 3000);
  }
  if (data.type == "notify") {
    $("#messagePopup").css("background-color", "rgb(56, 162, 229)");
    $("#messagePopup").fadeIn(500);
    $("#messagePopup").append(
      `
        <span>` +
        data.message +
        `</span>
        `
    );
    setTimeout(function () {
      $("#messagePopup").fadeOut(500);
      document.getElementById("messagePopup").innerHTML = "";
    }, 3000);
  }
  if (data.type == "updateVehicleInfos") {
    var data = data;
    handlingVehicle = data.data;
    var originalPrice = parseInt(vehicleSelected.sale);
    var discountPrice = parseInt(vehicleSelected.discount) + originalPrice;
    $("#contentVehicle").append(
      `
            <div class="row spacebetween" id="vehicleinfoprice">
                <span class="priceVehicle">$` +
        discountPrice +
        `</span>
            </div>
            <div class="column spacebetween info">
                <span class="title">Handling</span>
                <div class="bar">
                    <span class="percent" style="width:` +
        Math.ceil(10 * handlingVehicle.traction * 1.6) +
        `%"></span>
                </div>
            </div>
            <div class="column spacebetween info">
                <span class="title">Top Speed</span>
                <div class="bar">
                    <span class="percent" style="width:` +
        Math.ceil(handlingVehicle.maxSpeed * 1.4) +
        `%"></span>
                </div>
            </div>
            <div class="column spacebetween info">
                <span class="title">Acceleration</span>
                <div class="bar">
                    <span class="percent" style="width:` +
        Math.ceil(100 * handlingVehicle.acceleration) +
        `%"></span>
                </div>
            </div>
            <div class="column spacebetween info">
                <span class="title">Breaking</span>
                <div class="bar">
                    <span class="percent" style="width:` +
        Math.ceil(100 * handlingVehicle.breaking) +
        `%"></span>
                </div>
            </div>
            <div class="row" id="actionButton"> </div>
        `
    );
    if (vehicleSelected.discount > 0 || vehicleSelected.discount < 0) {
      $("#vehicleinfoprice").append(
        `
            <span class="priceVehicle" style="text-decoration:line-through">$` +
          originalPrice +
          `</span>
            `
      );
    }
    if (handlingVehicle.buy) {
      $("#actionButton").append(`
                <a class="buyButton" style=" color:#38a2e5;" onclick="openModalMenu()"> Buy </a>
            `);
    }
    // if (isEnableTestDrive) {
    //   $("#actionButton").append(`
    //             <a class="tdButtton" onclick="testDrive()"> Test Drive </a>
    //         `);
    // }
  }
  if (data.type == "updateMoney") {
    document.getElementById("playerMoney").innerHTML = data.playerMoney;
  }
});

$(document).ready(function () {
  $(".upper-bottom-container").on(
    "afterChange",
    function (event, slick, currentSlide) {
      $(".button-container").appendTo(currentSlide);
    }
  );
});

function menuVehicle(event) {
  var div = $(event.target).parent().find(".selected");
  $(div).removeClass("selected");
  $(event.currentTarget).addClass("selected");
  categoryVehicleSelected = $(event.currentTarget).attr("value");
  document.getElementById("nameBrand").innerHTML = "";
  document.getElementById("contentVehicle").innerHTML = "";
  document.getElementById("vehiclebrand").innerHTML = "";
  document.getElementById("carouselCars").innerHTML = "";
  dataVehicles = [];
  $.post(
    "https://sp-vehicleshop/menuSelected",
    JSON.stringify({
      menuId: categoryVehicleSelected.toLowerCase(),
    })
  );
}

function testDrive() {
  $.post(
    "https://sp-vehicleshop/TestDrive",
    JSON.stringify({
      vehicleModel: vehicleSelected.modelcar,
    })
  );
  $("body").css("display", "none");
}

function openModalMenu() {
  var originalPrice = parseInt(vehicleSelected.sale);
  var discountPrice = parseInt(vehicleSelected.discount) + originalPrice;

  document.getElementById("closemenu").innerHTML = "";
  $("body").fadeIn();
  $(".modal").css("display", "flex");
  $("#closemenu").append(
    `
        <div class="background-circle"></div>
        <div class="modal-content">
            <p class="title">Purchase confirmation:</p>
            <p class="vehicle">Vehicle</p>
            <p>Brand: <span class="brand">` +
      vehicleSelected.brand +
      `</span></p>
            <p>Model: <span class="model">` +
      vehicleSelected.modelcar +
      `</span></p>
        </div>
        <div class="modal-footer">
            <div class="modal-price" id="modalprice">
                <p class='price sale'>$` +
      discountPrice +
      `</p>
            </div>
            <div class="modal-buttons">
                <div>
                    <span>Buy</span>
                    <button id="money" class="modal-money button" onclick="buyVehicle('confirm')" >$</button>
                </div>
                <div>
                    <span>Cancel</span>
                    <button href="#!" id="card" class="modal-money button" onclick="buyVehicle('cancel')">X</button>
                </div>
            </div>
        </div>
    `
  );
  if (vehicleSelected.discount > 0 || vehicleSelected.discount < 0) {
    $("#modalprice").append(
      `
            <p class='price discount'>$` +
        originalPrice +
        `</p>
        `
    );
  }
}

function buyVehicle(option) {
  $(".modal").css("display", "none");
  switch (option) {
    case "cancel":
      break;
    case "confirm":
      $.post("https://sp-vehicleshop/Buy", JSON.stringify(vehicleSelected));
      break;
  }
}

const scrollContainer = document.querySelector(".carousel-cars");

$(document).on("keydown", function () {
  switch (event.keyCode) {
    case 27: // ESC
      $.post("https://sp-vehicleshop/Close");
      $("body").css("display", "none");
      document.getElementById("top-menu").innerHTML = "";
      break;
    case 9: // TAB
      break;
    case 17: // TAB
      break;
    case 68: // LEFT A
      $.post(
        "https://sp-vehicleshop/rotate",
        JSON.stringify({
          key: "left",
        })
      );
      break;
    case 65: // RIGHT D
      $.post(
        "https://sp-vehicleshop/rotate",
        JSON.stringify({
          key: "right",
        })
      );
      break;
    case 39:
      scrollContainer.scrollLeft += +100;
      // seta direita
      break;
    case 37:
      scrollContainer.scrollLeft += -100;
      // seta esquerda
      break;
  }
});

document.addEventListener("wheel", (evt) => {
  scrollContainer.scrollLeft += evt.deltaY;
});

$(document).on("keydown", function (ev) {
  var input = $(ev.target);
  var num = input.hasClass("input-number");
  var _key = false;
  if (ev.which == 68) {
    if (num === false) {
      _key = "left";
    } else if (num) {
      input.val(parseInt(input.val()) + 1);
      inputChange(input, true);
    }
  }
  if (ev.which == 65) {
    if (num === false) {
      _key = "right";
    } else if (num) {
      input.val(parseInt(input.val()) - 1);
      inputChange(input, false);
    }
  }
  if (_key) {
    $.post(
      "https://sp-vehicleshop/rotate",
      JSON.stringify({
        key: _key,
      })
    );
  }
});

$(document).on("mousedown", ".item-cars", function (event) {
  switch (event.which) {
    case 3:
      // click direito
      break;
    case 1:
      // click esquerdo
      var div = $(this).parent().find(".selectedVehicle");
      $(event.currentTarget)
        .addClass("selectedVehicle")
        .queue(function (next) {
          $(div).removeClass("selectedVehicle");
          next();
        });
      var classList = $(event.currentTarget).attr("class").split(/\s+/);
      var itemDisabled = false;
      $.each(classList, function (index, item) {
        if (item === "disable") {
          itemDisabled = true;
        }
      });
      if (!itemDisabled) {
        $("#colorPicker").css("display", "flex");
        var dataCar = $(event.currentTarget)
          .find(".specification")
          .find("span");
        $(".modal").css("display", "none");
        document.getElementById("nameBrand").innerHTML = "";
        document.getElementById("vehiclebrand").innerHTML = "";
        document.getElementById("contentVehicle").innerHTML = "";
        document.getElementById("vehiclebrand").innerHTML =
          ' <img id="vehicle_brand_image" src="../imgs/' +
          dataCar[0].outerText +
          '.png">';
        $("#nameBrand").append(
          `
                    <span id="vehicle_name">` +
            dataCar[1].outerText +
            `</span>
                    <span id="vehicle_line"></span>
                    <span id="vehicle_brand">` +
            dataCar[0].outerText +
            `</span>
                `
        );
        $(".changeVehicleColor").css("display", "block");
        vehicleSelected = {
          brand: dataCar[0].outerText,
          modelcar: dataCar[9].outerText,
          sale: dataCar[7].outerText,
          name: dataCar[1].outerText,
          discount: dataCar[11].outerText,
        };
        $.post(
          "https://sp-vehicleshop/SpawnVehicle",
          JSON.stringify({
            modelcar: dataCar[9].outerText,
            price: dataCar[7].outerText,
          })
        );
        if (dataCar[7].outerText < 1) {
          document.getElementById("buttonbuy").innerHTML =
            '<span class="sold-out-text">Sold OUT</span>';
        }
      }
      break;
  }
});

(() => {
  Dealership = {};
  Dealership.Open = function (data) {
    $(".item-cars").empty();
    $(".carousel-cars").empty();
    for (i = 0; i < data.length; i++) {
      var modelUper = data[i].brand;
      if (data[i].qtd < 1) {
        $(".carousel-cars").append(
          `
                <div class="item-cars">
                    <div class="col-lg-3 col-md-6 ">
                        <div class="specification" style="opacity:0.0; position:absolute;">
                            <span id="brand">` +
            data[i].brand +
            `</span>
                            <span id="name">` +
            data[i].name +
            `</span>
                            <span id="fabrication">` +
            data[i].fabrication +
            `</span>
                            <span id="handling">` +
            data[i].handling +
            `</span>
                            <span id="topspeed">` +
            data[i].topspeed +
            `</span>
                            <span id="power">` +
            data[i].power +
            `</span>
                            <span id="breaking">` +
            data[i].breaking +
            `</span>
                            <span id="price">` +
            data[i].price +
            `</span>
                            <span id="qtd">` +
            data[i].qtd +
            `</span>
                            <span id="model">` +
            data[i].model +
            `</span>
                            <span id="category">` +
            data[i].category +
            `</span>
                            <span id="discount">` +
            data[i].discount +
            `</span>
                        </div>
                        <div class="img-fluid" style="background-image:  url(../imgs/` +
            modelUper +
            `.png);"> <span class="exibeName">` +
            data[i].name +
            `</span></div>
                        <div class="soldOut">SOLD OUT</div>
                    </div>
                </div>`
        );
      } else if (data[i].qtd > 0) {
        $(".carousel-cars").append(
          `
                <div class="item-cars" >
                    <div class="col-lg-3 col-md-6 ">
                        <div class="specification" style="opacity:0.0; position:absolute;">
                            <span id="brand">` +
            data[i].brand +
            `</span>
                            <span id="name">` +
            data[i].name +
            `</span>
                            <span id="fabrication">` +
            data[i].fabrication +
            `</span>
                            <span id="handling">` +
            data[i].handling +
            `</span>
                            <span id="topspeed">` +
            data[i].topspeed +
            `</span>
                            <span id="power">` +
            data[i].power +
            `</span>
                            <span id="breaking">` +
            data[i].breaking +
            `</span>
                            <span id="price">` +
            data[i].price +
            `</span>
                            <span id="qtd">` +
            data[i].qtd +
            `</span>
                            <span id="model">` +
            data[i].model +
            `</span>
                            <span id="category">` +
            data[i].category +
            `</span>
                            <span id="discount">` +
            data[i].discount +
            `</span>
                        </div>
                        <div class="img-fluid" style="background-image:  url(../imgs/` +
            modelUper +
            `.png);"> <span class="exibeName">` +
            data[i].name +
            `</span></div>
                    </div>
                </div>`
        );
      }
    }
  };
  Dealership.Open(dataVehicles);
})();

function openOption(option) {
  pickr.show();
}

function setVehicleColorRGB(R, G, B) {
  print(R, G, B);
  if (selectedColor == "primary") {
    $.post(
      "https://sp-vehicleshop/RGBVehicle",
      JSON.stringify({
        primary: true,
        R: R,
        G: G,
        B: B,
      })
    );
  } else {
    $.post(
      "https://sp-vehicleshop/RGBVehicle",
      JSON.stringify({
        primary: false,
        R: R,
        G: G,
        B: B,
      })
    );
  }
}
