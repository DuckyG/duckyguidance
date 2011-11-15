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
	
	accountAlert('.accountAlert');

	// Cancel button
	formCancel('form .cancel');
	// Autotab phone field
	$('.phone .areaCode, .phone .prefix, .phone .line, .phone .ext').autotab_magic().autotab_filter('numeric');
	// Autotab date field
	$('.date .month, .date .day, .date .year').autotab_magic().autotab_filter('numeric');

  $('input[data-confirm]').click(function(){
    var answer = confirm($(this).attr("data-confirm"))
    return answer;
  });
	
	$('.multiselect').multiselect();

	$( ".datepicker" ).datepicker({
		showOn: "button",
		buttonImage: "/images/buttons/calendar.png",
		buttonImageOnly: true,
		dateFormat: "yy-mm-dd"
	});

  $("a[data-remote=true]").live("click",function(){
    $(".pagination").html("<img  src='/images/ajax-loader.gif' />");
    $.get(this.href, null,null,"script");
    return false;
  });

  $(".modNotes .modToggle a").live("click", function(){
    $(".modNotes .content").prepend("<div><img  src='/images/ajax-loader.gif' /></div>");
    $.get(this.href, null, null, "script");
    return false;
  });

  $(".filter_box").focus();
  $('.filter_box').keyup(function(){
    $.get(window.location.pathname + "?search=" + $('.filter_box').val(), null, null, "script");
  });

  $(".student-search").tokenInput("/students/search", {
    preventDuplicates: true,
    prePopulate: eval($("#prior_members").val())
  });

  $(".group-search").tokenInput("/groups/search", {
    preventDuplicates: true,
    prePopulate: eval($("#prior_groups").val())
  });

  $(".add-smart-group-filter").click(addSmartGroupFilterField);
  $(".delete-smart-group-filter").live("click",deteleSmartGroupFilterField);


}); // Bye-bye jQuery!


slideUpSpeed = 500;


function closeLayer(el){
	$(el).each(function(){
		var layer = $(this).parent();
		$(this).bind('click', function(){
			layer.slideUp(slideUpSpeed);
		})
	});
};

function deteleSmartGroupFilterField(){
  var $el = $(this)
  var $id = this.href.substring(this.href.indexOf("#")+1)
  var $deletedIdsField = $("#smart_group_deleted_filters")

  if($deletedIdsField.val())
    $deletedIdsField.val($deletedIdsField.val()+","+$id)
  else
    $deletedIdsField.val($id)

  $el.parent().slideUp(500, function() { $(this).remove(); });

  return false;
};

function addSmartGroupFilterField(){
  var $el = $(this)
  var $fieldset = $el.parent("fieldset")
  var $newElementIndex = $el.attr("count")
  if ($newElementIndex == undefined)
    $newElementIndex = 1
  var $target = $el.attr("data-target");
  $el.attr("count", ($newElementIndex + 1))
  $.get($target + $newElementIndex, null,null,"script");

  return false;
};
function accountAlert(el) {
	$(el).each(function() {
		var thisHeight = $(this).height();
    $('body').css('padding-top', thisHeight+28)
		$(this).css('top', -thisHeight).animate({
			opacity: 1,
			top: '10px'
		}, 750);
    		$(this).append('<span class="icon iconCloseFFF close" />').find('.close').bind('click', function() {
			$(this).parent().animate({
				opacity: 0,
				top: -thisHeight
			}, 750);
      $('body').animate({
				paddingTop: 0
			}, 750);
		})
	});
};

//  Apply the proper stylesheets to IE when the window resizes
function ieResize(){
	function adjustStyle(width) {
		width = parseInt(width);
		if ( width <= 800 ) {
			$("#styles800").attr("href", "/stylesheets/window_800.css");
		} else {
			$("#styles1024").attr("href", "/stylesheets/ie_blank.css");
			$("#styles800").attr("href", "/stylesheets/ie_blank.css");
		}
		if (width <= 1024) {
			$("#styles1024").attr("href", "/stylesheets/window_1024.css");
		} else {
			$("#styles1024").attr("href", "/stylesheets/ie_blank.css");
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
				obj.find('.item').hide();
				trigger.html(view);
			} else {
				obj.addClass('open');
				obj.find('.item').show();
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
		if( $(this).attr('type') == 'text' || $(this).attr('type') == 'password' || $(this).attr('type') == 'textarea' || $(this).attr('type') == 'email' ) {
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

/*!
 * jQuery UI 1.8.10
 *
 * Copyright 2011, AUTHORS.txt (http://jqueryui.com/about)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * http://docs.jquery.com/UI
 */
(function(c,j){function k(a){return!c(a).parents().andSelf().filter(function(){return c.curCSS(this,"visibility")==="hidden"||c.expr.filters.hidden(this)}).length}c.ui=c.ui||{};if(!c.ui.version){c.extend(c.ui,{version:"1.8.10",keyCode:{ALT:18,BACKSPACE:8,CAPS_LOCK:20,COMMA:188,COMMAND:91,COMMAND_LEFT:91,COMMAND_RIGHT:93,CONTROL:17,DELETE:46,DOWN:40,END:35,ENTER:13,ESCAPE:27,HOME:36,INSERT:45,LEFT:37,MENU:93,NUMPAD_ADD:107,NUMPAD_DECIMAL:110,NUMPAD_DIVIDE:111,NUMPAD_ENTER:108,NUMPAD_MULTIPLY:106,
NUMPAD_SUBTRACT:109,PAGE_DOWN:34,PAGE_UP:33,PERIOD:190,RIGHT:39,SHIFT:16,SPACE:32,TAB:9,UP:38,WINDOWS:91}});c.fn.extend({_focus:c.fn.focus,focus:function(a,b){return typeof a==="number"?this.each(function(){var d=this;setTimeout(function(){c(d).focus();b&&b.call(d)},a)}):this._focus.apply(this,arguments)},scrollParent:function(){var a;a=c.browser.msie&&/(static|relative)/.test(this.css("position"))||/absolute/.test(this.css("position"))?this.parents().filter(function(){return/(relative|absolute|fixed)/.test(c.curCSS(this,
"position",1))&&/(auto|scroll)/.test(c.curCSS(this,"overflow",1)+c.curCSS(this,"overflow-y",1)+c.curCSS(this,"overflow-x",1))}).eq(0):this.parents().filter(function(){return/(auto|scroll)/.test(c.curCSS(this,"overflow",1)+c.curCSS(this,"overflow-y",1)+c.curCSS(this,"overflow-x",1))}).eq(0);return/fixed/.test(this.css("position"))||!a.length?c(document):a},zIndex:function(a){if(a!==j)return this.css("zIndex",a);if(this.length){a=c(this[0]);for(var b;a.length&&a[0]!==document;){b=a.css("position");
if(b==="absolute"||b==="relative"||b==="fixed"){b=parseInt(a.css("zIndex"),10);if(!isNaN(b)&&b!==0)return b}a=a.parent()}}return 0},disableSelection:function(){return this.bind((c.support.selectstart?"selectstart":"mousedown")+".ui-disableSelection",function(a){a.preventDefault()})},enableSelection:function(){return this.unbind(".ui-disableSelection")}});c.each(["Width","Height"],function(a,b){function d(f,g,l,m){c.each(e,function(){g-=parseFloat(c.curCSS(f,"padding"+this,true))||0;if(l)g-=parseFloat(c.curCSS(f,
"border"+this+"Width",true))||0;if(m)g-=parseFloat(c.curCSS(f,"margin"+this,true))||0});return g}var e=b==="Width"?["Left","Right"]:["Top","Bottom"],h=b.toLowerCase(),i={innerWidth:c.fn.innerWidth,innerHeight:c.fn.innerHeight,outerWidth:c.fn.outerWidth,outerHeight:c.fn.outerHeight};c.fn["inner"+b]=function(f){if(f===j)return i["inner"+b].call(this);return this.each(function(){c(this).css(h,d(this,f)+"px")})};c.fn["outer"+b]=function(f,g){if(typeof f!=="number")return i["outer"+b].call(this,f);return this.each(function(){c(this).css(h,
d(this,f,true,g)+"px")})}});c.extend(c.expr[":"],{data:function(a,b,d){return!!c.data(a,d[3])},focusable:function(a){var b=a.nodeName.toLowerCase(),d=c.attr(a,"tabindex");if("area"===b){b=a.parentNode;d=b.name;if(!a.href||!d||b.nodeName.toLowerCase()!=="map")return false;a=c("img[usemap=#"+d+"]")[0];return!!a&&k(a)}return(/input|select|textarea|button|object/.test(b)?!a.disabled:"a"==b?a.href||!isNaN(d):!isNaN(d))&&k(a)},tabbable:function(a){var b=c.attr(a,"tabindex");return(isNaN(b)||b>=0)&&c(a).is(":focusable")}});
c(function(){var a=document.body,b=a.appendChild(b=document.createElement("div"));c.extend(b.style,{minHeight:"100px",height:"auto",padding:0,borderWidth:0});c.support.minHeight=b.offsetHeight===100;c.support.selectstart="onselectstart"in b;a.removeChild(b).style.display="none"});c.extend(c.ui,{plugin:{add:function(a,b,d){a=c.ui[a].prototype;for(var e in d){a.plugins[e]=a.plugins[e]||[];a.plugins[e].push([b,d[e]])}},call:function(a,b,d){if((b=a.plugins[b])&&a.element[0].parentNode)for(var e=0;e<b.length;e++)a.options[b[e][0]]&&
b[e][1].apply(a.element,d)}},contains:function(a,b){return document.compareDocumentPosition?a.compareDocumentPosition(b)&16:a!==b&&a.contains(b)},hasScroll:function(a,b){if(c(a).css("overflow")==="hidden")return false;b=b&&b==="left"?"scrollLeft":"scrollTop";var d=false;if(a[b]>0)return true;a[b]=1;d=a[b]>0;a[b]=0;return d},isOverAxis:function(a,b,d){return a>b&&a<b+d},isOver:function(a,b,d,e,h,i){return c.ui.isOverAxis(a,d,h)&&c.ui.isOverAxis(b,e,i)}})}})(jQuery);
;
