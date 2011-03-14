$(document).ready(function(){
	$("body").addClass("jsOn");

	homeForm('.pageHome .homeForm');
	editName('.pageHome .homeForm .edit');

	drop('.modDrop');
	activeSwap('#landing input');
	inputClear('#landing input');

	reveal('#login .trigger', 500);

	reveal2('.modSearch .trigger', 500);

//	Zebra Tables
	$("table:not(.plain) tr:nth-child(odd)").addClass("odd");


}); // Bye-bye jQuery!


function homeForm(el){
//  Show the continue button (the button isn't necessary when JS is turned off)
	$(el).find('.continue').show();
//  Hide stuff we don't need
	$(el).find('.continue').bind('click', function(){
		if ($('.first_name').attr('value') == 'First Name'){
			//  Error: First name
			$('.first_name').parent('p').append('<span class="error"><strong class="oops">Oops!</strong> Please add your first name.<span class="btm"></span></span>');
		} else if ($('.last_name').val() == 'Last Name'){
			//  Error: Last Name
			$('.last_name').parent('p').append('<span class="error"><strong class="oops">Oops!</strong> Please add your first name.<span class="btm"></span></span>');
		} else {
			$(el + ' .formBegin').hide();
			$(el + ' .message').show();
			$(el + ' .formContinue').slideDown(1000);
			$(el + ' .message strong').html( $('input.first_name').val() + ' ' + $('input.last_name').val() )
		}
		return false;
	});

//  Get rid of error messages when selecting an input
	$(el + ' input').focus(function(){
		$(this).next('.error').remove();
	});

//  Guidance Counselor Drop	
	var drop = $(el).find('.modDrop');
	$('.modDrop input').focus(function(){
			drop.addClass('modDropOver');
	});
	$('.modDrop input').blur(function(){
			drop.removeClass('modDropOver');
	});

	//  Move selected value to module title
	drop.find('label').click(function(){
		var choice = $(this).text();
		$(el).find('.header').html(choice);
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
		var obj = $(el);
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
		$(this).addClass('focus');
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



function reveal(el, duration){
	var obj = $(el);
	obj.bind('click', function(){
		if($(this).parent().hasClass('open') == true){
			$(this).parent().animate({
				marginTop: 0
			}, duration, function(){
				$(this).removeClass('open');
			});

		} else {
			$(this).parent().animate({
				marginTop: 276
			}, duration, function(){
				$(this).addClass('open');
			});
		}
	});
}




function reveal2(el, duration){
	var obj = $(el);
	obj.bind('click', function(){
		if($(this).next().hasClass('open') == true){
			obj.next('.item').slideUp(duration);
			$(this).next().removeClass('open');
		} else {
			obj.next('.item').slideDown(duration);
			$(this).next('.item').addClass('open');
		}
	});
}








