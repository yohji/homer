function setupPopupMove(path, route) {

    pop = $.mobile.activePage.find("#popupMoveContent");
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

$(document).on("pagecreate", function () {

    $(".openPopupMove").click(function () {

	name = $(this).data("name");
	path = $(this).data("path");
	route = $(this).data("route");

	setupPopupMove(path, route);

	$("#popupMove").popup("open");
    });

    $(".openPopupRename").click(function () {

	name = $(this).data("name");
	path = $(this).data("path");
	route = $(this).data("route");

	setupPopupRename(name, path, route);

	$("#popupRename").popup("open");
    });

    $(".openPopupDelete").click(function () {

	name = $(this).data("name");
	path = $(this).data("path");
	route = $(this).data("route");

	setupPopupDelete(name, path, route);

	$("#popupDelete").popup("open");
    });

    $(".openPanel").click(function () {

	name = $(this).data("name");
	path = $(this).data("path");
	route = $(this).data("route");

	setupPopupMove(path, route);
	setupPopupRename(name, path, route);
	setupPopupDelete(name, path, route);

	pan = $.mobile.activePage.find("#panelActionFile");
	pan.trigger("updatelayout");
	pan.panel("open");
    });

    $("#popupMove, #popupRename, #popupDelete").popup({
	afterclose: function () {

	    try {
		$.mobile.popup.active = null;
		delete $.mobile.popup.active;
	    } catch (e) {
	    }
	}
    });
});
