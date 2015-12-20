// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function scale(width, height, padding, border) {
	
	var scrWidth = $(window).width() - 30, 
		scrHeight = $(window).height() - 30, 
		ifrPadding = 2 * padding, 
		ifrBorder = 2 * border, 
		ifrWidth = width
			+ ifrPadding + ifrBorder, ifrHeight = height + ifrPadding
			+ ifrBorder, h, w;

	if (ifrWidth < scrWidth && ifrHeight < scrHeight) {
		w = ifrWidth;
		h = ifrHeight;
	} else if ((ifrWidth / scrWidth) > (ifrHeight / scrHeight)) {
		w = scrWidth;
		h = (scrWidth / ifrWidth) * ifrHeight;
	} else {
		h = scrHeight;
		w = (scrHeight / ifrHeight) * ifrWidth;
	}

	return {
		'width' : w - (ifrPadding + ifrBorder),
		'height' : h - (ifrPadding + ifrBorder)
	};
};
