$(document).on("pagecreate", function () {

	$("#openDeletePath").click(function () {

		$("#popupDeletePath").popup("open");
	});

	$("#closeDeletePath").click(function () {

		$("#popupDeletePath").popup("close");
	});
});
