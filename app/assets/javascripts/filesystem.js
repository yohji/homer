$(document).on("pageshow", function () {

	$(".openPanelActionFile").click(function () {

		name = $(this).data("name");
		path = $(this).data("path");
		route = $(this).data("route");

		$("#popupDeleteFileContent").find("h3").text("Delete " + name + " ?");
		$("#popupDeleteFileContent").find(".deleteFileBtn")
				.attr("href", "/delete?route=" + route + "&path=" + path);

		$("#panelActionFile").trigger("updatelayout");
		$("#panelActionFile").panel("open");
	});
});
