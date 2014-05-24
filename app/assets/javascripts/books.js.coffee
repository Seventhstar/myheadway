# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#book_author_name').autocomplete
    source: "/ajax/authors"
    select: (event,ui) ->
      $("#statement_author_id").val(ui.item.id)
    change: (event, ui) ->
       $("#statement_author_id").val(null)