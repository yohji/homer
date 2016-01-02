$(document).on("pagecreate", function () {

	$(".openPanelActionFile").click(function () {

		name = $(this).data("name");
		path = $(this).data("path");
		route = $(this).data("route");

		pop = $.mobile.activePage.find("#popupDeleteFileContent");
		pop.find("h3").text("Delete " + name + " ?");
		pop.find(".deleteFileBtn")
				.attr("href", "/delete?route=" + route + "&path=" + path);

		pan = $.mobile.activePage.find("#panelActionFile");
		pan.trigger("updatelayout");
		pan.panel("open");
	});
});
