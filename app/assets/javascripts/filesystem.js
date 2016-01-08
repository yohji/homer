function setupPopupMove(name, path, route) {

    pop = $.mobile.activePage.find("#popupMoveContent");
    pop.find("h3").text(name);
    pop.find("input[name='path']").val(path);
    pop.find("input[name='route']").val(route);
}

function setupPopupRename(name, path, route) {

    pop = $.mobile.activePage.find("#popupRenameContent");
    pop.find("input[name='name']").val(name);
    pop.find("input[name='path']").val(path);
    pop.find("input[name='route']").val(route);
}

function setupPopupDelete(name, path, route) {

    pop = $.mobile.activePage.find("#popupDeleteContent");
    pop.find("h3").text(name);
    pop.find("input[name='path']").val(path);
    pop.find("input[name='route']").val(route);
}

function setupPopupInfo(path) {

    $.ajax({
	type: "GET",
	url: "/info?path=" + encodeURIComponent(path),
	dataType: "json",
	success: function (data) {

	    pop = $.mobile.activePage.find("#popupInfoContent");
	    pop.empty();
	    table = $(document.createElement("table"));
	    pop.append(table);

	    $.each(data, function (name, value) {
		if (value !== null) {

		    tr = $(document.createElement("tr"));

		    if (name === "audio" || name === "video" || name === "image") {
			sep = $(document.createElement("td"))
				.attr("colspan", "2")
				.attr("style", "padding-top: 15px;")
				.text(name.toUpperCase());

			tr.append(sep);
			table.append(tr);

			$.each(value, function (n, v) {
			    if (v !== null) {

				tr = $(document.createElement("tr"));

				tr.append($(document.createElement("td")).text(n));
				tr.append($(document.createElement("td")).text(v));

				table.append(tr);
			    }
			});

		    } else {
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

	setupPopupMove(
		$(this).data("name"),
		$(this).data("path"),
		$(this).data("route"));

	$("#popupMove").popup("open");
    });

    $(".openPopupRename").click(function () {

	setupPopupRename(
		$(this).data("name"),
		$(this).data("path"),
		$(this).data("route"));

	$("#popupRename").popup("open");
    });

    $(".openPopupDelete").click(function () {

	setupPopupDelete(
		$(this).data("name"),
		$(this).data("path"),
		$(this).data("route"));

	$("#popupDelete").popup("open");
    });

    $(".openPanel").click(function () {

	name = $(this).data("name");
	path = $(this).data("path");
	route = $(this).data("route");

	setupPopupMove(name, path, route);
	setupPopupRename(name, path, route);
	setupPopupDelete(name, path, route);
	setupPopupInfo(path);

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
