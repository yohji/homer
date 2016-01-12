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

function buildTree(tree, elem) {

	var a = $(document.createElement("a"))
			.text(elem.name)
			.attr("href", "#")
			.attr("data-path", elem.path)
			.attr("class", "choosePopupMove");
		
	if (elem.path === "-")
	    a.attr("class", "disabled");

	if (elem.child !== null && elem.child.length > 0) {

		var li = $(document.createElement("li"))
				.attr("data-role", "collapsible")
				.attr("data-iconpos", "right")
				.attr("data-shadow", "false")
				.attr("data-corners", "false");

		tree.append(li);
		li.append($(document.createElement("h2")).append(a));

		var ul = $(document.createElement("ul"))
				.attr("data-role", "listview")
				.attr("data-inset", "true")
				.attr("data-shadow", "false")
				.attr("data-corners", "false");

		li.append(ul);
		$.each(elem.child, function (idx, child) {

			buildTree(ul, child);
		});

	} else
		tree.append($(document.createElement("li")).append(a));
}

$(document).on("pagecreate", function () {

	$(".openPopupMove").click(function () {

		params = readPanelParams();

		pop = $.mobile.activePage.find("#popupMoveContent");
		pop.find("#popupMoveName").text(params[0]);
		pop.find("input[name='path']").val(params[1]);
		pop.find("input[name='route']").val(params[2]);
		pop.find("#popupMoveLocation").text("");

		$.ajax({
			type: "GET",
			url: "/tree",
			dataType: "json",
			success: function (data) {

				tree = $.mobile.activePage.find("#popupMoveTree");
				tree.empty();
				
				buildTree(tree, data);
				$("#popupMove").trigger("create");

				$(".choosePopupMove").click(function () {
				    
					name = $(this).text();
					path = $(this).data("path");

					pop.find("#popupMoveLocation").text(name);
					pop.find("input[name='location']").val(path);
				});

				openPopup("#popupMove");
			}
		});
	});

	$(".openPopupRename").click(function () {

		params = readPanelParams();

		pop = $.mobile.activePage.find("#popupRenameContent");
		pop.find("input[name='name']").val(params[0]);
		pop.find("input[name='path']").val(params[1]);
		pop.find("input[name='route']").val(params[2]);

		openPopup("#popupRename");
	});

	$(".openPopupDelete").click(function () {

		params = readPanelParams();

		pop = $.mobile.activePage.find("#popupDeleteContent");
		pop.find("h3").text(params[0]);
		pop.find("input[name='path']").val(params[1]);
		pop.find("input[name='route']").val(params[2]);

		openPopup("#popupDelete");
	});

	$(".openPopupInfo").click(function () {

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
