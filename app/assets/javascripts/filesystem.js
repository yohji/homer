$(document).on("pagecreate", function () {

	$(".openPanelActionFile").click(function () {

		name = $(this).data("name");
		path = $(this).data("path");
		route = $(this).data("route");

		// Rename popup
		pop = $.mobile.activePage.find("#popupRenameFileContent");
		pop.find("input[name='name']").val(name);
		pop.find("input[name='path']").val(path);
		pop.find("input[name='route']").val(route);

		// Delete popup
		pop = $.mobile.activePage.find("#popupDeleteFileContent");
		pop.find("h3").text(name);
		pop.find("input[name='path']").val(path);
		pop.find("input[name='route']").val(route);

		// Action panel
		pan = $.mobile.activePage.find("#panelActionFile");
		pan.trigger("updatelayout");
		pan.panel("open");
	});
});
