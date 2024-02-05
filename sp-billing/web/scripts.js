var table = [];
var windowIsOpened = false;
var selectedWindow = "none";
var item = null;

// Windows
window.addEventListener("message", function (event) {
  item = event.data;
  switch (event.data.action) {
    case "mainmenu":
      if (!windowIsOpened) {
        var popup = new Audio("popup.mp3");
        popup.volume = 0.4;
        popup.play();

        windowIsOpened = true;

        if (event.data.society == true) {
          row = `	<div class="col col-md-5">
								<div class="card h-100">
								  <div class="card-body text-center mainmenu-subcard" id="menuMyInvoices" style="background-color: #eeeff3; color: #2f3037;">
								    <span class="card-title" style="font-size: 30px;"><i class="fas fa-user"></i></span>
								    <p class="card-text">Лични фактури</p>
								  </div>
								</div>
							</div>
							<div class="col col-md-5">
								<div class="card h-100">
								<div class="card-body text-center mainmenu-subcard" id="menuCreateInvoice" style="background-color: #eeeff3; color: #2f3037;">
									<span class="card-title" style="font-size: 30px;"><i class="fas fa-paper-plane"></i></span>
									<p class="card-text">Създай фактура</p>
								</div>
								</div>
							</div>
							<div class="col col-md-5 mt-2">
								<div class="card h-100">
								  <div class="card-body text-center mainmenu-subcard" id="menuSocietyInvoices" style="background-color: #eeeff3; color: #2f3037;">
								    <span class="card-title" style="font-size: 30px;"><i class="fas fa-building"></i></span>
								    <p class="card-text">Фирмени фактури</p>
								  </div>
								</div>
							</div>
							<div class="col col-md-5 mt-2">
								<div class="card h-100">
								<div class="card-body text-center mainmenu-subcard" id="menuSocietyBonus" style="background-color: #eeeff3; color: #2f3037;">
									<span class="card-title" style="font-size: 30px;"><i class="fas fa-calculator"></i></span>
									<p class="card-text">Изчисли бонуси</p>
								</div>
								</div>
							</div>
							<div class="col col-md-10 mt-2" disabled>
								<div class="card h-100">
								<div class="card-body text-center mainmenu-subcard" id="menuPriceList" style="background-color: #eeeff3; color: #2f3037;">
									<span class="card-title" style="font-size: 30px;"><i class="fas fa-question"></i></span>
									<p class="card-text">СКОРО</p>
								</div>
								</div>
							</div>
						  `;
        } else if (event.data.create & !event.data.society) {
          row = `	<div class="d-flex justify-content-center">
								<div class="col col-md-4">
									<div class="card h-100">
									  <div class="card-body text-center mainmenu-subcard" id="menuMyInvoices" style="background-color: #eeeff3; color: #2f3037;">
									    <span class="card-title" style="font-size: 30px;"><i class="fas fa-user"></i></span>
									    <p class="card-text">Лични фактури</p>
									  </div>
									</div>
								</div>
								<div class="col col-md-4" style="margin-left: 25px;">
									<div class="card h-100">
									  <div class="card-body text-center mainmenu-subcard" id="menuCreateInvoice" style="background-color: #eeeff3; color: #2f3037;">
									    <span class="card-title" style="font-size: 30px;"><i class="fas fa-paper-plane"></i></span>
									    <p class="card-text">Създай фактура</p>
									  </div>
									</div>
								</div>
							</div>
						  `;
        } else if (!event.data.create & !event.data.society) {
          row = `	<div class="d-flex justify-content-center">
								<div class="col col-md-4">
									<div class="card h-100">
									  <div class="card-body text-center mainmenu-subcard" id="menuMyInvoices" style="background-color: #eeeff3; color: #2f3037;">
									    <span class="card-title" style="font-size: 30px;"><i class="fas fa-user"></i></span>
									    <p class="card-text">Лични фактури</p>
									  </div>
									</div>
								</div>
							</div>
						  `;
        }

        $(".mainmenu").fadeIn();
        $("#mainMenuData").html(row);
        selectedWindow = "mainMenu";
      }
      break;
    case "myinvoices":
      if (!windowIsOpened) {
        var popup = new Audio("popup.mp3");
        popup.volume = 0.4;
        popup.play();

        var row = "";

        for (var i = 0; i < event.data.invoices.length; i++) {
          var invoices = event.data.invoices[i];
          var tablestatus = "";

          if (invoices.status == "paid") {
            tablestatus =
              '<td class="text-center align-middle"><span class="badge bg-success" style="font-size: 14px;"><i class="fas fa-check-circle"></i> ПЛАТЕНА</span></td>';
            modalstatus =
              '<span class="badge bg-success" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-check-circle"></i> ПЛАТЕНА</span>';
            payment_status = `<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">ПЛАТЕНА НА: ${invoices.paid_date}</span>`;
          } else if (invoices.status == "unpaid") {
            tablestatus =
              '<td class="text-center align-middle"><span class="badge bg-danger" style="font-size: 14px;"><i class="fas fa-times-circle"></i> ПРОСРОЧЕНА</span></td>';
            modalstatus =
              '<span class="badge bg-danger" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-times-circle"></i> ПРОСРОЧЕНА</span>';
            payment_status = `<button type="button" id="" class="btn btn-blue flex-grow-1 payInvoice" style="border-radius: 10px; flex-basis: 100%;" data-invoiceId="${
              invoices.id
            }" data-invoiceMoney="${
              invoices.invoice_value
            }" data-bs-dismiss="modal"><i class="fas fa-shopping-bag"></i> ПЛАТИ ${invoices.invoice_value.toLocaleString()}&euro;</button>`;
          } else if (invoices.status == "autopaid") {
            tablestatus =
              '<td class="text-center align-middle"><span class="badge bg-info" style="font-size: 14px;"><i class="fas fa-clock"></i> АВТО-ПЛАТЕНА</span></td>';
            modalstatus =
              '<span class="badge bg-info" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-clock"></i> АВТО-ПЛАТЕНА</span>';
            payment_status = `<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">АВТО-ПЛАТЕНА НА: ${invoices.paid_date}</span>`;
          } else if (invoices.status == "cancelled") {
            tablestatus =
              '<td class="text-center align-middle"><span class="badge bg-secondary" style="font-size: 14px;"><i class="fas fa-minus-circle"></i> ОТКАЗАНА</span></td>';
            modalstatus =
              '<span class="badge bg-secondary" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-minus-circle"></i> ОТКАЗАНА</span>';
            payment_status =
              '<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">ОТКАЗАНА</span>';
          }

          if (invoices.limit_pay_date == "N/A") {
            limit_pay_date = "";
          } else {
            limit_pay_date = `<h6>До: ${invoices.limit_pay_date}</h6>`;
          }

          row += `
						<tr>
							<td class="text-center align-middle">${invoices.id}</td>
							${tablestatus}
							<td class="text-center align-middle">${invoices.society_name}</td>
							<td class="text-center align-middle">${invoices.item}</td>
							<td class="text-center align-middle">${invoices.invoice_value.toLocaleString()}€</td>
							<td class="text-center align-middle"><button type="button" class="btn btn-blue showInvoice" style="border-radius: 10px; flex-basis: 100%;" data-toggle="modal" data-target="#showInvoiceModal${
                invoices.id
              }" data-invoiceId="${
            invoices.id
          }""><i class="fas fa-eye"></i> ВИЖ</button></td>
						</tr>
					`;

          var modal = `<div class="modal fade" id="showInvoiceModal${
            invoices.id
          }" tabindex="-1">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content myinvoices_modal-content">
											<div class="modal-body p-4">
												<span class="menutitle">Фактура #${invoices.id}</span>
												${modalstatus}
												<h6 class="" id="" style="">Изпратена на: ${invoices.sent_date}</h6>
												${limit_pay_date}
												<h6 class="" id="" style="margin-top: 20px;">Заплащане до: <span style="color: #2f3037;">${
                          invoices.receiver_name
                        }</span></h6>
												<h6 class="" id="" style="">Изпратена от: <span style="color: #2f3037;">${
                          invoices.author_name
                        }</span></h6>
												<hr>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">${
                            invoices.item
                          }</span> <span class="" id="" style="font-size: 18px;">${Math.round(
            invoices.invoice_value -
              Math.round(invoices.invoice_value * (event.data.VAT / 100))
          ).toLocaleString()} &euro;</span>
												</div>
												<hr>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">Междинна сума</span> <span class="" id="" style="font-size: 18px;">${Math.round(
                            invoices.invoice_value -
                              Math.round(
                                invoices.invoice_value * (event.data.VAT / 100)
                              )
                          ).toLocaleString()} &euro;</span>
												</div>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">ДДС (${
                            event.data.VAT
                          }%)</span> <span class="" id="" style="font-size: 18px;">${Math.round(
            invoices.invoice_value * (event.data.VAT / 100)
          ).toLocaleString()} &euro;</span>
												</div>
												<br>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px; font-weight: 700;">Обща сума</span> <span class="" id="" style="font-size: 18px;">${Math.round(
                            invoices.invoice_value
                          ).toLocaleString()} &euro;</span>
												</div>
												<br>
												<div class="d-flex justify-content-center">
													${payment_status}
												</div>
												<br>
												<div class="d-flex justify-content-center">
													<textarea class="form-control" readonly>${invoices.notes}</textarea>
												</div>
											</div>
										</div>
									</div>
								</div>
								`;
          $("body").append(modal);
        }
        $("#myInvoicesData").html(row);

        const myinvoices = document.getElementById("myInvoices");
        table.push(
          new simpleDatatables.DataTable(myinvoices, {
            searchable: true,
            perPageSelect: false,
            perPage: 5,
          })
        );

        windowIsOpened = true;

        selectedWindow = "myinvoices";
        $(".myinvoices").fadeIn();
      }
      break;
    case "createinvoice":
      if (!windowIsOpened) {
        windowIsOpened = true;
        $("#sendInvoiceSubtitle").html(event.data.society);
        $(".sendinvoice").fadeIn();
        selectedWindow = "createinvoice";
      }
      break;
    case "societyinvoices":
      if (!windowIsOpened) {
        var popup = new Audio("popup.mp3");
        popup.volume = 0.4;
        popup.play();

        var row = "";

        for (var i = 0; i < event.data.invoices.length; i++) {
          var invoices = event.data.invoices[i];
          var data = event.data;
          var tablestatus = "";

          $("#societyInvoicesTitle").html(invoices.society_name);
          $("#totalInvoices").html(data.totalInvoices);
          $("#totalIncome").html(`${data.totalIncome.toLocaleString()}€`);
          $("#unpaidInvoices").html(data.totalUnpaid);
          $("#awaitedIncome").html(`${data.awaitedIncome.toLocaleString()}€`);

          if (invoices.status == "paid") {
            tablestatus =
              '<td class="text-center align-middle"><span class="badge bg-success" style="font-size: 14px;"><i class="fas fa-check-circle"></i> ПЛАТЕНА</span></td>';
            modalstatus =
              '<span class="badge bg-success" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-check-circle"></i> ПЛАТЕНА</span>';
            payment_status = `<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">ПЛАТЕНА НА: ${invoices.paid_date}</span>`;
          } else if (invoices.status == "unpaid") {
            tablestatus =
              '<td class="text-center align-middle"><span class="badge bg-danger" style="font-size: 14px;"><i class="fas fa-times-circle"></i> ПРОСРОЧЕНА</span></td>';
            modalstatus =
              '<span class="badge bg-danger" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-times-circle"></i> ПРОСРОЧЕНА</span>';
            payment_status = `<button type="button" id="" class="btn btn-red flex-grow-1 cancelInvoice" style="border-radius: 10px; flex-basis: 100%;" data-invoiceId="${invoices.id}" data-invoiceMoney="${invoices.invoice_value}" data-bs-dismiss="modal"><i class="fas fa-times-circle"></i> ОТКАЖИ ФАКТУРА</button>`;
          } else if (invoices.status == "autopaid") {
            tablestatus =
              '<td class="text-center align-middle"><span class="badge bg-info" style="font-size: 14px;"><i class="fas fa-clock"></i> АВТО-ПЛАТЕНА</span></td>';
            modalstatus =
              '<span class="badge bg-info" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-clock"></i> АВТО-ПЛАТЕНА</span>';
            payment_status = `<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">АВТО-ПЛАТЕНА НА: ${invoices.paid_date}</span>`;
          } else if (invoices.status == "cancelled") {
            tablestatus =
              '<td class="text-center align-middle"><span class="badge bg-secondary" style="font-size: 14px;"><i class="fas fa-minus-circle"></i> ОТКАЗАНА</span></td>';
            modalstatus =
              '<span class="badge bg-secondary" style="position: absolute; right: 5%; top: 5%; font-size: 18px;"><i class="fas fa-minus-circle"></i> ОТКАЗАНА</span>';
            payment_status =
              '<span style="font-size: 20px; color: #2f3037; text-transform: uppercase; font-weight: 600;">ОТКАЗАНА</span>';
          }

          if (invoices.limit_pay_date == "N/A") {
            limit_pay_date = "";
          } else {
            limit_pay_date = `<h6>До: ${invoices.limit_pay_date}</h6>`;
          }

          row += `
						<tr>
							<td class="text-center align-middle">${invoices.id}</td>
							${tablestatus}
							<td class="text-center align-middle">${invoices.receiver_name}</td>
							<td class="text-center align-middle">${invoices.item}</td>
							<td class="text-center align-middle">${invoices.invoice_value.toLocaleString()}€</td>
							<td class="text-center align-middle"><button type="button" class="btn btn-blue showInvoice" style="border-radius: 10px; flex-basis: 100%;" data-toggle="modal" data-target="#showInvoiceModal${
                invoices.id
              }" data-invoiceId="${
            invoices.id
          }""><i class="fas fa-eye"></i> ВИЖ</button></td>
						</tr>
					`;

          var modal = `<div class="modal fade" id="showInvoiceModal${
            invoices.id
          }" tabindex="-1">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content myinvoices_modal-content">
											<div class="modal-body p-4">
												<span class="menutitle">Фактура #${invoices.id}</span>
												${modalstatus}
												<h6 class="" id="" style="">Изпратена на: ${invoices.sent_date}</h6>
												${limit_pay_date}
												<h6 class="" id="" style="margin-top: 20px;">Изпратена до: <span style="color: #2f3037;">${
                          invoices.receiver_name
                        }</span></h6>
												<h6 class="" id="" style="">Изпратена от: <span style="color: #2f3037;">${
                          invoices.author_name
                        }</span></h6>
												<hr>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">${
                            invoices.item
                          }</span> <span class="" id="" style="font-size: 18px;">${Math.round(
            invoices.invoice_value -
              Math.round(invoices.invoice_value * (event.data.VAT / 100))
          ).toLocaleString()} &euro;</span>
												</div>
												<hr>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">Междунна сума</span> <span class="" id="" style="font-size: 18px;">${Math.round(
                            invoices.invoice_value -
                              Math.round(
                                invoices.invoice_value * (event.data.VAT / 100)
                              )
                          ).toLocaleString()} &euro;</span>
												</div>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px;">ДДС (${
                            event.data.VAT
                          }%)</span> <span class="" id="" style="font-size: 18px;">${Math.round(
            invoices.invoice_value * (event.data.VAT / 100)
          ).toLocaleString()} &euro;</span>
												</div>
												<br>
												<div class="d-flex justify-content-between">
													<span class="" id="" style="color: #2f3037; font-size: 20px; font-weight: 700;">Обща сума</span> <span class="" id="" style="font-size: 18px;">${Math.round(
                            invoices.invoice_value
                          ).toLocaleString()} &euro;</span>
												</div>
												<br>
												<div class="d-flex justify-content-center">
													${payment_status}
												</div>
												<br>
												<div class="d-flex justify-content-center">
													<textarea class="form-control" readonly>${invoices.notes}</textarea>
												</div>
											</div>
										</div>
									</div>
								</div>
								`;
          $("body").append(modal);
        }
        $("#societyInvoicesData").html(row);

        const societyinvoices = document.getElementById("societyInvoices");
        table.push(
          new simpleDatatables.DataTable(societyinvoices, {
            searchable: true,
            perPageSelect: false,
            perPage: 5,
          })
        );

        windowIsOpened = true;

        selectedWindow = "societyinvoices";
        $(".societyinvoices").fadeIn();
      }
      break;
    case "societybonus":
      if (!windowIsOpened) {
        var popup = new Audio("popup.mp3");
        popup.volume = 0.4;
        popup.play();

        var row = "";

        for (var i = 0; i < event.data.invoices.length; i++) {
          var invoices = event.data.invoices[i];
          var data = event.data;
          var tablestatus = "";

          $("#societyBonusTitle").html(invoices.society_name);

          row += `
						<tr>
							<td class="text-center align-middle">${invoices.author_name}</td>
							<td class="text-center align-middle" id="getcalc"><button type="button" class="btn btn-blue showBonuses" style="border-radius: 10px; flex-basis: 100%;" data-citizen="${invoices.author_identifier}" "> Изчисли</button></td>
						</tr>
					`;
        }
        $("#societyBonusesData").html(row);

        const societyinvoices3 = document.getElementById("societybonusesT");

        // societyinvoices3;
        table.push(
          new simpleDatatables.DataTable(societyinvoices3, {
            searchable: true,
            perPageSelect: false,
            perPage: 5,
          })
        );

        windowIsOpened = true;

        selectedWindow = "societybonuses";
        $(".societybonuses").fadeIn();
      }
      break;
    case "societybonusModal":
      if (!windowIsOpened) {
        var popup = new Audio("popup.mp3");
        popup.volume = 0.4;
        popup.play();

        var row = "";

        var end = moment();
        console.log(JSON.stringify(event.data.invoices));

        for (var i = 0; i < event.data.invoices.length; i++) {
          var invoices = event.data.invoices[i];
          var data = event.data;
          var tablestatus = "";

          $("#playerBonus").html(invoices.author_name);
          $("#totalPlayerInvoices").html(data.totalInvoices);
          $("#totalPlayerWorth").html(data.worth);

          row += `
						<tr>
							<td class="text-center align-middle">${invoices.receiver_name}</td>
							<td class="text-center align-middle">${invoices.item}</td>
							<td class="text-center align-middle">${invoices.invoice_value}</td>
							<td class="text-center align-middle">${invoices.sent_date}</td>
						</tr>
					`;

          var modal = `<div class="modal fade" id="showInvoiceModalSortWeek" tabindex="-1">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content myinvoices_modal-content">
											<div class="modal-body p-4">
												<div class="input-group">

													<div id="reportrange" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
														<i class="fa fa-calendar"></i>&nbsp;
														<span></span> <i class="fa fa-caret-down"></i>
													</div>
												</div>
												<div class="row mt-3 mb-3">

													<div class="col col-md-5">
														<div class="card">
														<div class="card-body text-center" style="background-color: #eeeff3; color: #2f3037;">
															<h6 class="card-title">Брой фактури</h6>
															<p class="card-text" id="totalWeekInvoices">0</p>
														</div>
														</div>
													</div>

													<div class="col col-md-5">
														<div class="card">
														<div class="card-body text-center" style="background-color: #eeeff3; color: #2f3037;">
															<h6 class="card-title">Обща стойност</h6>
															<p class="card-text" id="totalWeekWorth">0</p>
														</div>
														</div>
													</div>
												</div>

											</div>
										</div>
									</div>
								</div>
								`;

          $("body").append(modal);

          const startInvoice = moment(invoices.sent_date);

          $("#reportrange").daterangepicker(
            {
              autoApply: true,
              startDate: startInvoice,
              endDate: end,
            },
            function (startInvoice, end) {
              // console.log('New date range selected: ' + startInvoice.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' ');

              $.post(
                "https://sp-billing/countdays",
                JSON.stringify({
                  action: "countDays",
                  startDate: startInvoice,
                  endDate: end,
                  citizen: invoices.author_identifier,
                  society: invoices.society_name,
                })
              );
            }
          );
        }

        $("#playerBonusesData2").html(row);
        $("#playerBonusesData2").attr("id", "playerBonusesData2");

        const societyinvoices2 = document.getElementById("playerInvoicesTable");

        societyinvoices2.c;
        table.push(
          new simpleDatatables.DataTable(societyinvoices2, {
            searchable: true,
            perPageSelect: false,
            perPage: 5,
            paging: true,
          })
        );

        windowIsOpened = true;

        selectedWindow = "playerbonuses";

        $(".playerbonuses").fadeIn();
      }

      break;
    case "showcount":
      var data = event.data;

      $("#totalWeekInvoices").html(data.playerInvoices);
      $("#totalWeekWorth").html(`${data.totalInvoices.toLocaleString()}€`);

      break;
  }
});

// Button Actions
$(document).on("click", ".showInvoice", function () {
  var modalId = $(this).attr("data-target");
  var invoiceModal = new bootstrap.Modal(modalId);
  invoiceModal.show();
});

$(document).on("click", ".payInvoice", function () {
  var invoiceId = $(this).attr("data-invoiceId");

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "payInvoice",
      invoice_id: invoiceId,
    })
  );

  $(".myinvoices").fadeOut();

  setTimeout(function () {
    windowIsOpened = false;

    for (var i = 0; i < table.length; i++) {
      table[i].destroy();
      table.splice(i, 1);
    }

    $(".modal").remove();
  }, 400);
});

$(document).on("click", ".cancelInvoice", function () {
  var invoiceId = $(this).attr("data-invoiceId");

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "cancelInvoice",
      invoice_id: invoiceId,
    })
  );

  $(".societyinvoices").fadeOut();

  setTimeout(function () {
    windowIsOpened = false;

    for (var i = 0; i < table.length; i++) {
      table[i].destroy();
      table.splice(i, 1);
    }

    $(".modal").remove();
  }, 400);
});

$(document).on("click", "#menuMyInvoices", function () {
  windowIsOpened = false;
  $(".mainmenu").fadeOut();

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "mainMenuOpenMyInvoices",
    })
  );
});

$(document).on("click", "#menuSocietyInvoices", function () {
  windowIsOpened = false;
  $(".mainmenu").fadeOut();

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "mainMenuOpenSocietyInvoices",
    })
  );
});

$(document).on("click", "#menuSocietyBonus", function () {
  windowIsOpened = false;
  $(".mainmenu").fadeOut();

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "mainMenuOpenBonuses",
    })
  );
});

// button
$(document).on("click", ".showBonuses", function () {
  windowIsOpened = false;
  $(".societybonuses").fadeOut();

  var citizen = $(this).attr("data-citizen");

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "openBonusesModal",
      citizen: citizen,
    })
  );
});

$(document).on("click", "#menuCreateInvoice", function () {
  windowIsOpened = false;
  $(".mainmenu").fadeOut();

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "mainMenuOpenCreateInvoice",
    })
  );
});

$(document).on("click", "#sendInvoice", function () {
  var invoice_value = $("#invoice_value").val();
  var invoice_item = $("#invoice_item").val();
  var invoice_notes = $("#invoice_notes").val();

  if (document.getElementById("invoice_notes").value === "") {
    invoice_notes = "Няма нищо за добавяне.";
  }

  if (!invoice_value || !invoice_item) {
    $.post(
      "https://sp-billing/action",
      JSON.stringify({
        action: "missingInfo",
      })
    );
  } else {
    if (invoice_value >= 0) {
      $(".sendinvoice").fadeOut();
      windowIsOpened = false;

      $.post(
        "https://sp-billing/action",
        JSON.stringify({
          action: "createInvoice",
          target: 0,
          targetName: -1,
          society: "",
          society_name: "",
          invoice_value: invoice_value,
          invoice_item: invoice_item,
          invoice_notes: "Бележки: " + invoice_notes,
        })
      );

      setTimeout(function () {
        for (var i = 0; i < table.length; i++) {
          table[i].destroy();
          table.splice(i, 1);
        }
        $("#invoice_value").val("");
        $("#invoice_item").val("");
        $("#invoice_notes").val("");
      }, 400);
    } else {
      $.post(
        "https://sp-billing/action",
        JSON.stringify({
          action: "negativeAmount",
        })
      );
    }
  }
});

$(document).on("click", "#closeMainMenu", function () {
  var popuprev = new Audio("popupreverse.mp3");
  popuprev.volume = 0.4;
  popuprev.play();

  windowIsOpened = false;
  $(".mainmenu").fadeOut();

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "close",
    })
  );
});

$(document).on("click", "#closeSendInvoice", function () {
  var popuprev = new Audio("popupreverse.mp3");
  popuprev.volume = 0.4;
  popuprev.play();

  $(".sendinvoice").fadeOut();

  setTimeout(function () {
    windowIsOpened = false;

    for (var i = 0; i < table.length; i++) {
      table[i].destroy();
      table.splice(i, 1);
    }

    $("#invoice_value").val("");
    $("#invoice_item").val("");
    $("#invoice_notes").val("");
    $(".modal").remove();
  }, 400);

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "close",
    })
  );
});

$(document).on("click", "#closeSocietyInvoices", function () {
  var popuprev = new Audio("popupreverse.mp3");
  popuprev.volume = 0.4;
  popuprev.play();

  $(".societyinvoices").fadeOut();

  setTimeout(function () {
    windowIsOpened = false;

    for (var i = 0; i < table.length; i++) {
      table[i].destroy();
      table.splice(i, 1);
    }

    $(".modal").remove();
  }, 400);

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "close",
    })
  );
});

$(document).on("click", "#closeSocietyBonuses", function () {
  var popuprev = new Audio("popupreverse.mp3");
  popuprev.volume = 0.4;
  popuprev.play();

  $(".societybonuses").fadeOut();

  setTimeout(function () {
    windowIsOpened = false;

    for (var i = 0; i < table.length; i++) {
      table[i].destroy();
      table.splice(i, 1);
    }

    $(".modal").remove();
  }, 400);

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "close",
    })
  );
});

$(document).on("click", "#closePlayerBonuses", function () {
  var popuprev = new Audio("popupreverse.mp3");
  popuprev.volume = 0.4;
  popuprev.play();

  $(".playerbonuses").fadeOut();

  setTimeout(function () {
    windowIsOpened = false;

    for (var i = 0; i < table.length; i++) {
      table[i].destroy();
      table.splice(i, 1);
    }
  }, 400);

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "close",
    })
  );
});

$(document).on("click", "#closeMyInvoices", function () {
  var popuprev = new Audio("popupreverse.mp3");
  popuprev.volume = 0.4;
  popuprev.play();

  $(".myinvoices").fadeOut();

  setTimeout(function () {
    windowIsOpened = false;

    for (var i = 0; i < table.length; i++) {
      table[i].destroy();
      table.splice(i, 1);
    }

    $(".modal").remove();
  }, 400);

  $.post(
    "https://sp-billing/action",
    JSON.stringify({
      action: "close",
    })
  );
});

// Back
$(document).on("click", ".goBack", function () {
  $(".societyinvoices").fadeOut();

  $(".mainmenu").fadeIn();
});

$(document).on("click", ".goBack2", function () {
  $(".societybonuses").fadeOut();

  $(".mainmenu").fadeIn();
});

$(document).on("click", ".goBack3", function () {
  $(".playerbonuses").fadeOut();

  $(".societybonuses").fadeIn();
});

// Close ESC Key
$(document).ready(function () {
  document.onkeyup = function (data) {
    if (data.which == 27) {
      var popuprev = new Audio("popupreverse.mp3");
      popuprev.volume = 0.4;
      popuprev.play();
      switch (selectedWindow) {
        case "myinvoices":
          $(".myinvoices").fadeOut();

          setTimeout(function () {
            windowIsOpened = false;

            for (var i = 0; i < table.length; i++) {
              table[i].destroy();
              table.splice(i, 1);
            }

            $(".modal").remove();
          }, 400);

          $.post(
            "https://sp-billing/action",
            JSON.stringify({
              action: "close",
            })
          );
          break;
        case "mainMenu":
          windowIsOpened = false;

          $(".mainmenu").fadeOut();

          $.post(
            "https://sp-billing/action",
            JSON.stringify({
              action: "close",
            })
          );
          break;
        case "societyinvoices":
          $(".societyinvoices").fadeOut();

          setTimeout(function () {
            windowIsOpened = false;

            for (var i = 0; i < table.length; i++) {
              table[i].destroy();
              table.splice(i, 1);
            }

            $(".modal").remove();
          }, 400);

          $.post(
            "https://sp-billing/action",
            JSON.stringify({
              action: "close",
            })
          );
          break;
        case "createinvoice":
          $(".sendinvoice").fadeOut();

          setTimeout(function () {
            windowIsOpened = false;

            for (var i = 0; i < table.length; i++) {
              table[i].destroy();
              table.splice(i, 1);
            }

            $(".modal").remove();
          }, 400);

          $.post(
            "https://sp-billing/action",
            JSON.stringify({
              action: "close",
            })
          );
          break;
      }
    }
  };
});
