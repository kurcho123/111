var cacheid = 0;
var timeout = null;
var configg = null;
var cacheData = null;
var sec = 0;
var hudAlwaysOpen = false;
var interval = null;

$(window).ready(function () {
  window.addEventListener("message", (event) => {
    let data = event.data;
    switch (data.action) {
      case "hudAlways":
        hudAlwaysOpen = !hudAlwaysOpen;
        $(".hud").show();
        if (hudAlwaysOpen == false) {
          $(".hud").hide();
        }
        break;
      case "hudSize":
        $(".hud").css("zoom", data.size + "%");
        break;
      case "open":
        sec = 0;
        // $(".treatment-ui").css("right", "0%");
        $(".bone-list").show();
        $(".treatment-ui").show();
        $(".treatment-ui-s").show();
        // $(".treatment-ui").animate({
        //     left: "0%",

        // }, 1000);
        // $(".treatment-ui-s").animate({
        //     right: "0%",

        // }, 1000);

        // Adjust the duration (1000ms) as needed
        // $(".menu").show();
        // $(".menu header").html("Patient: " + data.data.name);

        $(".dead").hide();
        $(".cc").hide();
        $(".icon").hide();
        $(".anim").hide();
        $(".duzcizgi").hide();
        $(".rev-list").hide();

        configg = data.config;
        cacheid = data.data.pid;
        cacheData = data;

        $(".circle-ic span").html("");
        if (data.dead == true) {
          $(".dead").show();
          $(".duzcizgi").show();
        } else {
          $(".cc").show();
          $(".icon").show();
          $(".anim").show();
        }

        if (cacheData.data.hitdate) {
          const hitDate = new Date(cacheData.data.hitdate * 1000);
          const time = hitDate.getTime();

          const now = new Date();
          const nowTime = now.getTime();
          const diff = nowTime - time;

          sec = Math.floor(diff / 1000);
          clearInterval(interval);
          interval = null;
          interval = setInterval(() => {
            sec = sec + 1;
            $(".circle-ic span").html(secondsToMinutesSeconds(sec));
          }, 1000);
        } else {
          if (configg.EnableRevive == true) {
            if (data.dead == true) {
              $(".rev-list").show();
            }
          }
        }

        $(".hud").hide();
        $(".bone-list").html("");

        $.each(data.bones, function (i, v) {
          coordX = v.screenX;
          coordY = v.screenY;
          w = configg.BoneLabelText[v.bid].unity;
          health = 100;
          if (w == "Chest") {
            w = "Body";
          }

          if (w == "RKnee") {
            w = "rleg";
          }

          if (w == "LKnee") {
            w = "lleg";
          }

          if (w == "RShoulder") {
            w = "rarm";
          }

          if (w == "LShoulder") {
            w = "larm";
          }

          $(".un-" + w.toLowerCase()).attr("data-bid", v.bone);
          $(".un-" + w.toLowerCase()).data("bid", v.bone);
          $("." + w.toLowerCase() + "-perc").html(health + "%");
          $("." + w.toLowerCase() + "-status").css("width", health + "%");
          style = `
                            position: absolute;
                            width: 4vw;
                            height: 4.5vh;
                            z-index: 1000;
                            inset: ${coordY * 90 + "%"} ${
            100 - coordX * 100 + "%"
          } ${100 - coordY * 100 + "%"} ${coordX * 100 + "%"};
                        `;
          if (data.dead == false) {
            style = `
                            position: absolute;
                            width: 4vw;
                            height: 4.5vh;
                            z-index: 1000;
                            inset: ${coordY * 90 + "%"} ${
              100 - coordX * 100 + "%"
            } ${100 - coordY * 100 + "%"} ${coordX * 100 + "%"};
                            transform: scale(0.8);
                        `;
          }
          $(".bone-list").append(`
                            <div class="bone-item" style="  ${style}

                            " data-bone="${v.bone}" data-w="${w}"> 
                                <div class="bone-item-label">${v.label}</div>
                                <div class="bone-item-per h-b-${v.bone}">${health}% Health</div>
                                <div class="bone-item-heal" data-bone="${v.bone}">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none">
                                    <path d="M5.99097 13.7788C5.99097 14.8128 6.82915 15.6509 7.8631 15.6509C8.89704 15.6509 9.73522 14.8128 9.73522 13.7788L9.73522 9.66013H5.99097L5.99097 13.7788Z" fill="white"/>
                                    <path d="M5.99097 5.99081H9.73522V1.87213C9.73522 0.838182 8.89704 2.38419e-06 7.8631 2.38419e-06C6.82915 2.38419e-06 5.99097 0.838183 5.99097 1.87213L5.99097 5.99081Z" fill="white"/>
                                    <rect width="15.7259" height="3.74426" rx="1.87213" transform="matrix(1 0 0 -1 0 9.73492)" fill="white"/>
                                </svg>
                                </div>
                                <div class="stap">
                                    <svg viewBox="0 0 184 68" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M181.5 5.5C182.605 5.5 183.5 4.60457 183.5 3.5C183.5 2.39543 182.605 1.5 181.5 1.5V5.5ZM3.91421 66.4142L59.2635 11.065L56.435 8.23655L1.08579 63.5858L3.91421 66.4142ZM72.6985 5.5H181.5V1.5H72.6985V5.5ZM59.2635 11.065C62.8266 7.50178 67.6594 5.5 72.6985 5.5V1.5C66.5985 1.5 60.7484 3.92321 56.435 8.23655L59.2635 11.065Z" fill="white" fill-opacity="0.26"/>
                                        <circle cx="3" cy="65" r="3" fill="#38a2e5"/>
                                        <circle cx="181" cy="3" r="3" fill="#38a2e5"/>
                                    </svg>
                                </div>
                            </div>
                        `);
        });

        $.each(data.data.injuresD, function (i, v) {
          var binfo = null;
          health = 100;
          $.each(configg.BoneLabelText, function (q, w) {
            if (w.bid == v.bid) {
              binfo = w;
              if (binfo != null) {
                if (v.count >= 1) {
                  if (health < -1) {
                    health = 0;
                  } else {
                    health = health - v.count * 10;
                  }
                  if (health < 0) {
                    health = 0;
                  }
                }

                if (binfo.name == "Chest") {
                  binfo.name = "Body";
                }

                if (binfo.name == "RKnee") {
                  binfo.name = "rleg";
                }

                if (binfo.name == "LKnee") {
                  binfo.name = "lleg";
                }

                $(".h-b-" + binfo.bid).html(`${health}% Health`);
                $("." + binfo.name.toLowerCase() + "-perc").html(health + "%");
                $("." + binfo.name.toLowerCase() + "-status").css(
                  "width",
                  health + "%"
                );
              }
            }
          });
        });

        $(".ic-liste").html("");
        $.post("https://sp-ambulance/checkItems", {}, function (data) {
          $.each(data, function (i, v) {
            $(".ic-liste").append(`
                        <div class="ic-item"  data-name="${v.name}">
                            <div class="ic-img" data-name="${v.name}"><div class="asl-img" style="background:url(items/${v.name}.png); background-size:cover;"></div></div>
                            <div class="ic-ic">
                                <div class="ic-name">${v.label}</div>
                                <div class="ic-desc">Heals Wounds</div>
                                <div class="ic-count">${v.count}</div>
                            </div>
                        </div>
                    `);

            handle();
          });
        });

        break;
      case "damageTaken":
        var CurrentInjure = data.CurrentInjure;
        var config = data.config;

        if (hudAlwaysOpen == false) {
          $(".hud").show();
        }

        if (timeout != null) {
          clearTimeout(timeout);
          timeout = null;
        }

        $(".human *").hide();

        $.each(CurrentInjure, function (i, v) {
          binfo = null;
          $.each(config, function (q, w) {
            if (w.bid == v) {
              binfo = w;
            }
          });

          $("." + binfo.unity).show("pulsate");
        });

        if (hudAlwaysOpen == false) {
          timeout = setTimeout(() => {
            $(".hud").hide();
          }, 2500);
        }
        break;
      case "checked":
        var CurrentInjure = data.data.injures;
        var CurrentInjureOld = data.injuresOld;
        var config = data.config;
        $(".human_doc *").hide();
        $(".list").html("");

        $.each(CurrentInjure, function (i, v) {
          var v = v;
          binfo = null;
          $.each(config, function (q, w) {
            if (w.bid == v) {
              binfo = w;
            }
          });
          clvl = "Minor";
          lvl = CurrentInjureOld[v];
          if (lvl > 1 && lvl < 2) {
            clvl = "Minor";
          } else if (lvl >= 3 && lvl < 8) {
            clvl = "Medium";
          } else if (lvl >= 9) {
            clvl = "Critical";
          }
          $(".list").append(`
                         <div class="item" data-clvl="${clvl}" data-v="${v}" data-type="${binfo.name}">${binfo.Label} <span>Difficulty in treatment: ${clvl} </span></div>
                    `);
          $("." + binfo.unity + "_doc").show();
        });
        break;
      case "theme":
        if (data.theme == "sigma") {
          $(".style").html(`
                        .ic-img, .dot {
                            background: #38a2e5;
                        }
                        .ic-name, .status-list-item-name, .title, .circle-ic h1, .com-list-item-name, .bone-item-per, .title h1 {
                            color: #38a2e5;
                        }
                     
                        .ic-count, .status-list-item-img, .com-list-item-img, .com-list-item-count  {
                            background: #38a2e5;
                            box-shadow: 0px 0px 9px #38a2e5;
                            border: 2px solid rgba(255, 255, 255, 0.19);
                        }
                        .status-prog {
                            border: 1px solid rgba(255, 255, 255, 0.05);
                            color: #38a2e5;
                            background: linear-gradient(180deg, rgba(93, 220, 174, 0.30) 0%, rgba(219, 92, 105, 0.30) 0.01%, rgba(219, 92, 105, 0.30) 100%);
                            text-shadow: 0px 0px 20px #38a2e5;
                        }
                        .status-c {
                            background: #dc5d5d63;
                        }
                        .bone-item-heal {
                            background: #38a2e5;
                            box-shadow: 0px 0px 7px 0px #38a2e5a3;
                        }
                        .com-ic-listx button {
                            background: #38a2e5;
                            box-shadow: 0px 0px 7px 0px #38a2e5a3;
                        }
                        .com-ic-listx button:hover {
                            background: #38a2e5;
                            box-shadow: 0px 0px 7px 0px #38a2e5a3;
                        }
                    `);
        }
        break;
    }
  });
});

var cachedTreat = {
  clvl: null,
  v: null,
  type: null,
  pid: null,
};

function secondsToMinutesSeconds(seconds) {
  const minutes = Math.floor(seconds / 60);
  const remainingSeconds = seconds % 60;
  return `${minutes}:${remainingSeconds < 10 ? "0" : ""}${remainingSeconds}`;
}

$(document).on("click", ".com-ic-listx button", function () {
  $.post("https://sp-ambulance/rev", JSON.stringify(cacheid));
  Close();
});

$(document).on("click", ".bone-item-heal", function () {
  const bone = $(this).data("bone");
  var bones = cacheData.bones;
  var info = cacheData.data.info;
  var injures = cacheData.data.injuresD;
  var cacheBones = {};
  // console.log(bone)
  $(".com-ic-list").html("");
  try {
    $.each(info, function (i, v) {
      if (v.bone == bone) {
        $(".com-ic-list").append(`
                    <div class="com-list-item">
                        <div class="com-list-item-img"><div class="inj"></div></div>
                        <div class="com-list-item-ic">
                            <div class="com-list-item-name">${v.label}</div>
                            <div class="com-list-item-count">${v.count}</div>
                        </div>
                    </div>
                `);
      }
    });
  } catch (e) {
    // console.log(e);
  }
});

$(document).on("click", ".status-list-item", function () {
  const bone = $(this).data("bid");
  var bones = cacheData.bones;
  var info = cacheData.data.info;
  var injures = cacheData.data.injuresD;
  var cacheBones = {};
  // console.log(bone)
  $(".com-ic-list").html("");
  try {
    $.each(info, function (i, v) {
      if (v.bone == bone) {
        $(".com-ic-list").append(`
                    <div class="com-list-item">
                        <div class="com-list-item-img"><div class="inj"></div></div>
                        <div class="com-list-item-ic">
                            <div class="com-list-item-name">${v.label}</div>
                            <div class="com-list-item-count">${v.count}</div>
                        </div>
                    </div>
                `);
      }
    });
  } catch (e) {
    // console.log(e);
  }
});

function getCount(injures, bid) {
  for (let i = 0; i < injures.length; i++) {
    if (injures[i].bid == bid) {
      return injures[i].count;
    }
  }
}

function handle() {
  $(".ic-img").draggable({
    helper: "clone",
    appendTo: "body",
    scroll: true,
    revertDuration: 0,
    revert: "invalid",
    cursorAt: {
      top: Math.floor($(".ic-item").outerHeight() / 12),
      left: Math.floor($(".ic-item").outerWidth() / 8),
    },
    start: function (event, ui) {
      $(ui.helper).css({
        width: $(this).width() + 20,
        height: $(this).height() + 25,
      });
    },
    stop: function () {},
  });

  $(".bone-item").droppable({
    accept: ".ic-img",
    drop: function (event, ui) {
      var bone = $(this).data("bone");
      var w = $(this).data("w");
      var item = ui.draggable.data("name");

      if (w == "Chest" || w == "Pelvis") {
        w = "body";
      }

      if (w == "RKnee") {
        w = "rleg";
      }

      if (w == "LKnee") {
        w = "lleg";
      }

      if (w == "RShoulder") {
        w = "rarm";
      }

      if (w == "LShoulder") {
        w = "larm";
      }

      w = w.toLowerCase();

      $.post(
        "https://sp-ambulance/checkTreatment",
        JSON.stringify({ bone: bone, area: w, item: item, cacheid: cacheid }),
        function (data) {}
      );

      $(".treatment-supplies").hide();
      $(".injure-list").hide();
      $(".menu").hide();
      $(".treatment-ui").hide();
      $(".treatment-ui-s").hide();
      $(".bone-list").hide();

      $.post("https://sp-ambulance/close");
      clearInterval(interval);
      interval = null;
    },
  });

  $(".status-list-item").droppable({
    accept: ".ic-img",
    drop: function (event, ui) {
      var bone = $(this).data("bid");
      var w = $(this).data("unity");
      var item = ui.draggable.data("name");

      if (w == "Chest" || w == "Pelvis") {
        w = "body";
      }

      if (w == "RKnee") {
        w = "rleg";
      }

      if (w == "LKnee") {
        w = "lleg";
      }

      if (w == "RShoulder") {
        w = "rarm";
      }

      if (w == "LShoulder") {
        w = "larm";
      }

      w = w.toLowerCase();

      $.post(
        "https://sp-ambulance/checkTreatment",
        JSON.stringify({ bone: bone, area: w, item: item, cacheid: cacheid }),
        function (data) {}
      );

      $(".treatment-supplies").hide();
      $(".injure-list").hide();
      $(".menu").hide();
      $(".treatment-ui").hide();
      $(".treatment-ui-s").hide();
      // $(".treatment-ui").animate({
      //     left: "-40%"
      // }, 1000);
      // $(".treatment-ui-s").animate({
      //     right: "-40%"
      // }, 1000);
      $(".bone-list").hide();

      $.post("https://sp-ambulance/close");
      clearInterval(interval);
      interval = null;
    },
  });
}

$(document).on("click", ".item", function () {
  $(".treatment-supplies").show();
  $(".supplies").html("");
  cachedTreat.clvl = $(this).data("clvl");
  cachedTreat.v = $(this).data("v");
  cachedTreat.type = $(this).data("type");
  cachedTreat.pid = cacheid;

  // if($("treatment-supplies").css("top") != "50%") {
  $(".treatment-supplies").removeClass("active");

  $(".treatment-supplies a").css("display", "none");
  // }

  $.post("https://sp-ambulance/checkItems", {}, function (data) {
    var i = 0;
    $.each(configg.Treatment[cachedTreat.clvl], function (x, v) {
      var have = "";
      if (data[v]) {
        i = i + 1;

        have = `<i class="fa-duotone fa-circle-check"></i>`;
      }
      $(".supplies").append(`
                <div class="sup" style=" background: url(items/${v}.png); background-size: cover;">${have}</div>
            `);

      if (i == configg.Treatment[cachedTreat.clvl].length) {
        // setTimeout(() => {
        $(".treatment-supplies").addClass("active");
        // $(".treatment-supplies").css({ "top": "52.5%", "height": "38vh" });
        $(".treatment-supplies a").css("display", "block");
        // }, 1000);
      }
    });
  });
});

$(document).on("click", ".treatment-supplies a", function () {
  $(".treatment-supplies").hide();
  $(".injure-list").hide();
  $(".menu").hide();
  clearInterval(interval);
  interval = null;
  $.post("https://sp-ambulance/close");
  $.post("https://sp-ambulance/startTreat", JSON.stringify(cachedTreat));
});

$(document).on("click", ".menu-item", function () {
  $(".menu").hide();
  $.post(
    "https://sp-ambulance/action",
    JSON.stringify({ type: $(this).data("type"), pid: cacheid })
  );
});

$(document).on("keydown", function () {
  switch (event.keyCode) {
    case 27:
      Close();
      break;
  }
});

Close = () => {
  $(".treatment-supplies").hide();
  $(".injure-list").hide();
  $(".menu").hide();
  // $(".treatment-ui").animate({
  //     left: "-40%"
  // }, 1000);
  // $(".treatment-ui-s").animate({
  //     right: "-40%"
  // }, 1000);
  $(".treatment-ui").hide();
  $(".treatment-ui-s").hide();
  $(".bone-list").hide();

  $.post("https://sp-ambulance/close");
  clearInterval(interval);
  interval = null;
};
