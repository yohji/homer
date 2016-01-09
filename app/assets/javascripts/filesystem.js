function writePanelParams(name, path) {

	form = $.mobile.activePage.find("form[name='panelParams']");
	form.find("input[name='name']").val(name);
	form.find("input[name='path']").val(path);
}

function readPanelParams() {

	form = $.mobile.activePage.find("form[name='panelParams']");
	name = form.find("input[name='name']").val();
	path = form.find("input[name='path']").val();
	route = form.find("input[name='route']").val();

	return [name, path, route];
}

function openPopup(id) {

	$(id).popup("option", "transition", "pop");
	$(id).popup("option", "positionTo", "window");
	$(id).popup("open");
}

function setupPopupMove() {

	params = readPanelParams();

	pop = $.mobile.activePage.find("#popupMoveContent");
	pop.find("h3").text(params[0]);
	pop.find("input[name='path']").val(params[1]);
	pop.find("input[name='route']").val(params[2]);
}

function setupPopupRename() {

	params = readPanelParams();

	pop = $.mobile.activePage.find("#popupRenameContent");
	pop.find("input[name='name']").val(params[0]);
	pop.find("input[name='path']").val(params[1]);
	pop.find("input[name='route']").val(params[2]);
}

function setupPopupDelete() {

	params = readPanelParams();

	pop = $.mobile.activePage.find("#popupDeleteContent");
	pop.find("h3").text(params[0]);
	pop.find("input[name='path']").val(params[1]);
	pop.find("input[name='route']").val(params[2]);
}

function setupPopupInfo() {

	params = readPanelParams();

	$.ajax({
		type: "GET",
		url: "/info?path=" + encodeURIComponent(params[1]),
		dataType: "json",
		success: function (data) {

			pop = $.mobile.activePage.find("#popupInfoContent");
			pop.empty();
			table = $(document.createElement("table"));
			pop.append(table);

			$.each(data, function (name, value) {
				if (value !== null) {

					if (name === "audio" || name === "video" || name === "image") {
						$.each(value, function (idx, hash) {

							tr = $(document.createElement("tr"));
							sep = $(document.createElement("td"))
									.attr("colspan", "2")
									.attr("style", "padding-top: 15px;")
									.text(name.toUpperCase() + " #" + idx);

							tr.append(sep);
							table.append(tr);

							$.each(hash, function (n, v) {
								if (v !== null) {

									tr = $(document.createElement("tr"));
									tr.append($(document.createElement("td")).text(n));
									tr.append($(document.createElement("td")).text(v));
									table.append(tr);
								}
							});
						});

					} else {
						tr = $(document.createElement("tr"));
						tr.append($(document.createElement("td")).text(name));
						tr.append($(document.createElement("td")).text(value));
						table.append(tr);
					}
				}
			});
		}
	});
}

$(document).on("pagecreate", function () {

	$(".openPopupMove").click(function () {

		setupPopupMove();
		openPopup("#popupMove");
	});

	$(".openPopupRename").click(function () {

		setupPopupRename();
		openPopup("#popupRename");
	});

	$(".openPopupDelete").click(function () {

		setupPopupDelete();
		openPopup("#popupDelete");
	});

	$(".openPopupInfo").click(function () {

		setupPopupInfo();
		openPopup("#popupInfo");
	});

	$(".openPanel").click(function () {

		writePanelParams(
				$(this).data("name"),
				$(this).data("path"));

		pan = $.mobile.activePage.find("#panelActionFile");
		pan.trigger("updatelayout");
		pan.panel("open");
	});

	$("#popupMove, #popupRename, #popupDelete, #popupInfo").popup({
		afterclose: function () {

			try {
				$.mobile.popup.active = null;
				delete $.mobile.popup.active;
			} catch (e) {
			}
		}
	});
});
