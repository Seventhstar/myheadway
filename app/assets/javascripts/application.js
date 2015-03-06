// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery.tokeninput
//= require rails-timeago-all
//= require locales/jquery.timeago.ru.js
//= require_tree .

function capitalize(a) {
    newVal = '';
    a = a.split(' ');
    for (var c = 0; c < a.length; c++) {
        newVal += a[c].substring(0, 1).toUpperCase() + a[c].substring(1, a[c].length)+' '
    }
    return newVal.substring(0, newVal.length-1)
}

function capitalize_first(a) {
    newVal = a.substring(0, 1).toUpperCase() + a.substring(1, a.length)
    return newVal
}


$(document).ready(function(){

/*$('.calenday').mouseover(function(){
   day = $(this).attr("day");
   $('.h'+day).addClass('overhead');
})

$('.calenday').mouseout(function(){
   day = $(this).attr("day");
   $('.h'+day).removeClass('overhead');
})*/

$('.dropdown-menu li a').click(function(event) {
  //alert($(this).attr('tagid'));
  $.get($("#statements_search").attr("action"), {tagid:$(this).attr('tagid')}, null, "script");
} );                  


if ($('#key0').hasClass('selected') || $('#key2').hasClass('selected'))
$('#key1').removeClass('simple-navigation-active-leaf');

  $('.toggleButton').click(function(){
    id = $(this).attr('id');
    id = id.substring(4);

    $('#addon'+id).slideToggle('slow', function(){
    	if($('#addon'+id).is(':visible')) { 
    		$('#addon'+id).attr('style','');
    		$('#stid'+id).text(' <');
    	}else{
    		$('#stid'+id).text(' ...');
    	}
  	});
    
  });
  
  $("#statement_author_name").keyup(function() {
    var c= String.fromCharCode(event.keyCode);
    var isWordcharacter = c.match(/\w/);
    
    if (isWordcharacter || event.keyCode ==8){

      myString = capitalize($(this).val());
      $(this).val(myString);
      return false;
    }
  });
  
  $("#statement_theme, #target_parent_name, #target_name").keyup(function() {
    var c= String.fromCharCode(event.keyCode);
    var isWordcharacter = c.match(/\w/);
    
    if (isWordcharacter || event.keyCode ==8){

      myString = capitalize_first($(this).val());
      $(this).val(myString);
      return false;}
    });
  
  $('span.calenday').click(function(){
     day = $(this).attr("day");
     target = $(this).attr("target");
     month = $("#current_month").val();
     year = $("#current_year").val();

     if ($(this).hasClass("checked")){

        $(this).removeClass("checked");
	checked = false;
     }else{
        checked = true;
	$(this).addClass("checked");
     };

     $.ajax({
	 url: "/ajax/target_days",
	 data: {'day':day,'target':target, 'checked': checked, 'month': month, 'year': year },
	 type: "POST",
	 beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},	 
	  success: function(){
	   $(this).addClass("done");
	  }
	 });

   
  });

  
  $('.target_li, .t-item').hover(
    function(){
     $(this).find("a").removeAttr("style");
   },
    function(){
     $(this).find("a").attr("style","display: none; ");
   }

  );
  
  $(".notice").fadeOut(1400);

  $('span.plus').click(function(){
  	
  	id = $(this).attr('id').substr(5);
  	$('#children-'+id).slideToggle('slow');
        $('.day_'+id).slideToggle('slow');

   //alert(id);
     
  	if($('#span-'+id).hasClass('opened')) {
      
      //alert( $('#span-'+id).attr('text') );
     
      $('#span-'+id).removeClass('opened');
      $('#span-'+id).text('-');
      
    } else {
    	  
     $('#span-'+id).text('+');
      $('#span-'+id).addClass('opened');
      
    }
  })
});
