# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require jquery-ui

$(document).ready ->
  $('#search').autocomplete
    source: "/search_suggestions"


  $('#statement_author_name').autocomplete
    source: "/ajax/authors"
    select: (event,ui) ->
      $("#statement_author_id").val(ui.item.id)
    change: (event, ui) ->
       $("#statement_author_id").val(null)

  $('#statement_book_name').autocomplete
    source: "/ajax/books"
    select: (event,ui) ->
      $("#statement_book_id").val(ui.item.id)
    change: (event, ui) ->
       $("#statement_book_id").val(null)       
      
  $('#statement_tag_tokens').tokenInput('/tags.json',
    theme: 'facebook'
    prePopulate: $('#statement_tag_tokens').data('load')
  )
    