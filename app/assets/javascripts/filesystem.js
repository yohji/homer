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
	cache: false,
	success: function (data) {

	    pop = $.mobile.activePage.find("#popupInfoContent");
	    pop.html(data);
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
