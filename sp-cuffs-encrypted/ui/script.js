let players = [];

window.addEventListener("message", (e) => {
  switch (e.data.action) {
    case "show":
      $(".container").css("opacity", "1");
      break;

    case "hide":
      $(".container").css("opacity", "0");
      break;

    case "open_headbag":
      $(".headbag").css("display", "block");
      break;

    case "close_headbag":
      $(".headbag").css("display", "none");
      break;
  }

  if (e.data?.players) {
    players = e.data.players;

    $(".bottom").children().remove();
    $(".bottom").css("justify-content", "");

    if (e.data.players.length > 0) {
      e.data.players.forEach((player) => {
        $(".bottom").append(`
            <div data-id="${player.id}" class="player">
                <div class="details">
                  <div class="details-left">
                    <h2>${player.name}</h2>
                    <p id="gps_status">GPS is <span style="color: #5f69d4;">${
                      player.gpsEnabled ? "enabled" : "disabled"
                    }</span></p>
                    <p>
                      Cuff date: <span style="font-weight: bold;">${
                        player.cuffDate
                      }</span>
                    </p>
                  </div>
                  <div class="details-right">
                    <div onclick="postAction(this, 'shockPlayer', ${
                      player.id
                    })" class="btn">Shock</div>
                    <div onclick="postAction(this, '${
                      e.data.realtimeGPS ? "toggleGPS" : "markGPS"
                    }', ${player.id})" class="btn">${
          e.data.realtimeGPS ? "Toggle GPS" : "Mark GPS Location"
        }</div>
                    <div onclick="postAction(this, 'unlockPlayer', ${
                      player.id
                    })" class="btn">Unlock</div>
                  </div>
                </div>
            </div>
        `);
      });
    } else {
      $(".bottom").css("justify-content", "center");
      $(".bottom").append(
        `<h1 id="noone_cuffed">No one has electrocuffed</h1>`
      );
    }
  }
});

const postAction = function (el, type, playerId) {
  let player = players.find((x) => x.id == playerId);

  if (player) {
    switch (type) {
      case "toggleGPS":
        for (let i = 0; i < players.length; i++) {
          if (players[i].id == playerId) {
            player.gpsEnabled = player.gpsEnabled ? false : true;
            players[i].gpsEnabled = player.gpsEnabled;
          }
        }

        break;
    }

    $.post(
      `https://${GetParentResourceName()}/${type}`,
      JSON.stringify(player)
    );

    $(el)
      .parent()
      .siblings(".details-left")
      .children()
      .each(function () {
        if ($(this).attr("id") == "gps_status") {
          $(this)
            .children()
            .text(player.gpsEnabled ? "enabled" : "disabled");
        }
      });
  }
};
const closeUi = () => {
  $.post(`https://${GetParentResourceName()}/close`);
};

window.addEventListener("keydown", (e) => {
  if (e.key === "Escape") closeUi();
});
