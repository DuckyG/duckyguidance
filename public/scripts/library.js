$(document).ready(function(){
	$("body").addClass("jsOn");

	if ($.browser.msie && $.browser.version.substr(0,1)<10) {
		ieResize();
	}

	closeLayer('.close');
	equalCols('.cols2');


	tableRowDrop('tr.drop');
	contentDrop('.contentDrop');
	swapLayers('.swapLayers')


	drop('.modDrop');
	activeSwap('#landing input');
	tableStyle('.modCopy table')

	homeForm('.requestMeeting');
	editName('.requestMeeting .editName');
	inputClear('.requestMeeting input');

	// Cancel button
	formCancel('form .cancel');
	// Autotab phone field
	$('.phone .areaCode, .phone .prefix, .phone .line, .phone .ext').autotab_magic().autotab_filter('numeric');
	// Autotab date field
	$('.date .month, .date .day, .date .year').autotab_magic().autotab_filter('numeric');

  $(document).ready(function(){
    $(".multiselect").multiselect();
  });

}); // Bye-bye jQuery!



slideUpSpeed = 500;


function closeLayer(el){
	$(el).each(function(){
		var layer = $(this).parent();
		$(this).bind('click', function(){
			layer.slideUp(slideUpSpeed);
		})
	});
}


//  Apply the proper stylesheets to IE when the window resizes
function ieResize(){
	function adjustStyle(width) {
		width = parseInt(width);
		if ( width <= 800 ) {
			$("#styles800").attr("href", "/styles/window_800.css");
		} else {
			$("#styles1024").attr("href", "/styles/ie_blank.css");
			$("#styles800").attr("href", "/styles/ie_blank.css");
		}
		if (width <= 1024) {
			$("#styles1024").attr("href", "/styles/window_1024.css");
		} else {
			$("#styles1024").attr("href", "/styles/ie_blank.css");
		}
	}	
	$(function() {
		adjustStyle($(this).width());
		$(window).resize(function() {
			adjustStyle($(this).width());
		});
	});
}

function equalCols(el){
	if( $(el).hasClass('unequal') == false ){
		$(el).each(function(){
			var thisHeight = $(this).height();
			$(this).find('.col').each(function(){
			if ($.browser.msie && $.browser.version.substr(0,1)<7) {
				$(this).css('height', thisHeight);
			} else {
				$(this).css('min-height', thisHeight);
			}
			});
		});
	}
}

function tableStyle(el){
	$(el).each(function(){
		$(this).find('thead td:first, th:first').addClass('first');
	});
}

function tableRowDrop(el){
	$(el).each(function(){
		var obj = $(this);
		var trigger = obj.find('.trigger');
		var view = trigger.html();
		obj.bind('click', function(){
			if ( obj.hasClass('open') == true ) {
				obj.removeClass('open').next('tr').hide();
				trigger.html(view);
				obj.find('.buttonSet').show();
			} else {
				obj.addClass('open').next('tr').show();	
				trigger.html('<span class="close icon iconClose"></span>');
				obj.find('.buttonSet').hide();
			};
		})
	});
}

function contentDrop(el){
	$(el).each(function(){
		var obj = $(el);
		var trigger = obj.find('.trigger');
		var view = trigger.html();
		trigger.click(function(){
			if(obj.hasClass('open') == true) {
				obj.removeClass('open');
				trigger.next('.item').hide();
				trigger.html(view);
			} else {
				obj.addClass('open');
				trigger.next('.item').show();
				trigger.html('<span class="close icon iconClose"></span>');
			}
			return false;
		});
	})
}

function swapLayers(el){
	$(el).each(function(){
		var obj = $(this);
		obj.bind('click',function(){
			if ($(this).parent().hasClass('firstLayer') == true) {
				$(this).parent().hide().next('.secondLayer').show();
			} else if ($(this).parent().parent().hasClass('secondLayer') == true) {
				$(this).parent().parent().hide().prev('.firstLayer').show();
			}
			
		});
	});
}





















function homeForm(el){
	
//  Show the continue button (the button isn't necessary when JS is turned off)
	$(el).find('.continue').show();
//  Hide stuff we don't need
	$(el).find('.continue').bind('click', function(){

		//  Simple error messaging for homepage. This needs to be replaced.
		if ($('.first_name').attr('value') == 'First Name'){
			//  Error: First name
			$('.first_name').parent('p').append('<span class="error"><strong class="oops">Oops!</strong> Please add your first name.<span class="btm"></span></span>');
		} else if ($('.last_name').val() == 'Last Name'){
			//  Error: Last Name
			$('.last_name').parent('p').append('<span class="error"><strong class="oops">Oops!</strong> Please add your first name.<span class="btm"></span></span>');
		} else {
			$(el + ' .formBegin').hide();
			$(el + ' .message').show();
			$(el + ' .formContinue').show();
			$(el + ' .message strong').html( $('input.first_name').val() + ' ' + $('input.last_name').val() )
		}
		return false;
	});

//  Get rid of error messages when selecting an input
	$(el + ' input').focus(function(){
		$(this).next('.error').remove();
	});
}

function editName(el){
	var edit = $(el).parent().prev('.formBegin');
	var msg = $(el).parent();
	$(el).bind('click', function(){
		$(edit).show();
		$(msg).hide();
	});
}

function drop(el){
	$(el).each(function(){
		var obj = $(this);
		$(this).mouseover(function(){
			obj.addClass('modDropOver');
		});
		$(this).mouseout(function(){
			obj.removeClass('modDropOver');
		});
	});
}

function activeSwap(el){
	$(el).each(function(){
		$(this).addClass('inactive');
		$(this).focus(function(){
			$(this).removeClass('inactive');
		});
		$(this).blur(function(){
			$(this).addClass('inactive');
		});
	});
}

//	Clear inputs on focus
function inputClear(target) {
	var target = target || "input";
	$(target).each(function() {
		if( $(this).attr('type') == 'text' || $(this).attr('type') == 'password' || $(this).attr('type') == 'textarea' ) {
			var value = $(this).val();
			$(this).focus(function() {
				if($(this).val() == value) {
					$(this).val("");
				}
			});
			$(this).blur(function() {
				$(this).removeClass('focus');
				if($(this).val() == "") {
					$(this).val(value);
				}
			});
		}
	});
}















function formCancel(el){
	var alertMessage = "Are you sure you want to clear all fields?";
	var confirmMessage = "All fields have been cleared. No information has been sent or saved.";
	var cancelButton = $(el).append('<a href="#">Cancel</a>');
	cancelButton.click(function(){
		if ( confirm(alertMessage) ){
			// If user clicks yes, clear all necessary form elements
			$(':input').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');
			alert(confirmMessage);
			return false;
		} else {
			// If user clicks no, don't do anything.
		    return false;
		}
	})
}
/**
 * Autotab - jQuery plugin 1.1b
 * http://www.lousyllama.com/sandbox/jquery-autotab
 * 
 * Copyright (c) 2008 Matthew Miller
 * 
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 * 
 * Revised: 2008-09-10 16:55:08
 */
(function($) {
var check_element = function(name) {
	var obj = null;
	var check_id = $('#' + name);
	var check_name = $('input[name=' + name + ']');
	if(check_id.length)
		obj = check_id;
	else if(check_name != undefined)
		obj = check_name;
	return obj;
};
$.fn.autotab_magic = function(focus) {
	for(var i = 0; i < this.length; i++){
		var n = i + 1;
		var p = i - 1;
		if(i > 0 && n < this.length)
			$(this[i]).autotab({ target: $(this[n]), previous: $(this[p]) });
		else if(i > 0)
			$(this[i]).autotab({ previous: $(this[p]) });
		else
			$(this[i]).autotab({ target: $(this[n]) });
		if(focus != null && (isNaN(focus) && focus == $(this[i]).attr('id')) || (!isNaN(focus) && focus == i))
			$(this[i]).focus();
	}
	return this;
};
$.fn.autotab_filter = function(options) {
	var defaults = {
		format: 'all',
		uppercase: false,
		lowercase: false,
		nospace: false,
		pattern: null
	};
	if(typeof options == 'string' || typeof options == 'function')
		defaults.format = options;
	else
		$.extend(defaults, options);
	for(var i = 0; i < this.length; i++){
		$(this[i]).bind('keyup', function(e) {
			var val = this.value;
			switch(defaults.format){
				case 'text':
					var pattern = new RegExp('[0-9]+', 'g');
					val = val.replace(pattern, '');
					break;
				case 'alpha':
					var pattern = new RegExp('[^a-zA-Z]+', 'g');
					val = val.replace(pattern, '');
					break;
				case 'number':
				case 'numeric':
					var pattern = new RegExp('[^0-9]+', 'g');
					val = val.replace(pattern, '');
					break;
				case 'alphanumeric':
					var pattern = new RegExp('[^0-9a-zA-Z]+', 'g');
					val = val.replace(pattern, '');
					break;
				case 'custom':
					var pattern = new RegExp(defaults.pattern, 'g');
					val = val.replace(pattern, '');
					break;
				case 'all':
				default:
					if(typeof defaults.format == 'function')
						var val = defaults.format(val);
					break;
			}
			if(defaults.nospace){
				var pattern = new RegExp('[ ]+', 'g');
				val = val.replace(pattern, '');
			}
			if(defaults.uppercase)
				val = val.toUpperCase();
			if(defaults.lowercase)
				val = val.toLowerCase();
			if(val != this.value)
				this.value = val;
		});
	}
};
$.fn.autotab = function(options) {
	var defaults = {
		format: 'all',
		maxlength: 2147483647,
		uppercase: false,
		lowercase: false,
		nospace: false,
		target: null,
		previous: null,
		pattern: null
	};
	$.extend(defaults, options);
	if(typeof defaults.target == 'string')
		defaults.target = check_element(defaults.target);
	if(typeof defaults.previous == 'string')
		defaults.previous = check_element(defaults.previous);
	var maxlength = $(this).attr('maxlength');
	if(defaults.maxlength == 2147483647 && maxlength != 2147483647)
		defaults.maxlength = maxlength;
	else if(defaults.maxlength > 0)
		$(this).attr('maxlength', defaults.maxlength)
	else
		defaults.target = null;
	if(defaults.format != 'all')
		$(this).autotab_filter(defaults);
	return $(this).bind('keydown', function(e) {
		if(e.which == 8 && this.value.length == 0 && defaults.previous)
			defaults.previous.focus().val(defaults.previous.val());
	}).bind('keyup', function(e) {
		var keys = [8, 9, 16, 17, 18, 19, 20, 27, 33, 34, 35, 36, 37, 38, 39, 40, 45, 46, 144, 145];
		if(e.which != 8){
			var val = $(this).val();
			if($.inArray(e.which, keys) == -1 && val.length == defaults.maxlength && defaults.target)
				defaults.target.focus();
		}
	});
};
})(jQuery);