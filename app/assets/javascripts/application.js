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
//= require jquery-ui/accordion
//= require jquery_ujs
//= require jquery.tokeninput
//= require rails-timeago
//= require locales/jquery.timeago.ru.js
//= require chosen.jquery
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

var delay = (function(){
  timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();


$(document).ready(function(){

  $('.switcher_a').each(function(){
        var switcher = $(this);
        var link = $(this).find('.link_a');
        var scale = $(this).find('.scale');
        var handle = $(this).find('.handle');
        var details = switcher.parent().find('.details');

        $(link).click(function(event){
            switcher.toggleClass('toggled');
            link.toggleClass('on');
            var attr = link.hasClass('on') ? 'on' : 'off'
            link[0].innerHTML = link.attr(attr);
            handle.toggleClass('active');

            if(switcher.hasClass('toggled')){
                details.slideDown(300);
                
            } else {
                details.slideUp(300);
           
            }
            sortable_query({only_actual:link.hasClass('on')});
            return false;
        });

        $(scale).click(function(event){
            switcher.toggleClass('toggled');
            link.toggleClass('on');
            link[0].innerHTML = link.attr(link.hasClass('on') ? 'on' : 'off');
            handle.toggleClass('active');

            if(switcher.hasClass('toggled')){
                details.slideDown(300);
            } else {
                details.slideUp(300);
            }
            sortable_query({only_actual:link.hasClass('on')});
            return false;
        });
       
        

    });

  var accordion_head = $('.accordion > li > a'),
  accordion_body = $('.accordion li > .sub-menu');

  m_active = parseInt($('.accordion').attr('active'));

  accordion_head.eq(m_active).addClass('active').next().slideDown('normal');
  accordion_head.on('click', function(event) {
    event.preventDefault();
    if ($(this).attr('class') != 'active'){
      accordion_body.slideUp('normal');
      $(this).next().stop(true,true).slideToggle('normal');
      accordion_head.removeClass('active');
      $(this).addClass('active');
    }
  });

  $('.flash').fadeOut(3000);

  $('.col-70').on('click','.toggleButton',function(){
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

  $(".notice").fadeOut(1400);
  $('span.plus').click(function(){
  	id = $(this).attr('id').substr(5);
  	$('#children-'+id).slideToggle('slow');
    $('.day_'+id).slideToggle('slow');
    
  	if($('#span-'+id).hasClass('opened')) {
      $('#span-'+id).removeClass('opened');
      $('#span-'+id).text('-');
    } else {
      $('#span-'+id).text('+');
      $('#span-'+id).addClass('opened');
    }
  })
});
