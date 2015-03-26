# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#target_parent_name').autocomplete
    source: "/ajax/targets"
    #select: (event,ui) ->
     # $("#target_parent_id").val if ui.item then ui.item.id else ""
    change: (event,ui) ->
      $("#target_parent_id").val if ui.item then ui.item.id else ""

  $(".calenday").mouseout ->
    day = $(this).attr("day")
    $('.h'+day).removeClass('overhead') 
  
  $('.calenday').mouseover ->
    day = $(this).attr("day");
    $('.h'+day).addClass('overhead');

  $('.target_li, .t-item').hover ->
    $(this).find('div.edit_delete').toggleClass 'hid'  