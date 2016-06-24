# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
//= require jquery-ui

$(document).ready ->

  $('#search').autocomplete
    source: "/search_suggestions"
  $('#search').on 'keyup', ->
    $.get 'statements', $("#statements_search").serialize(), null, 'script'

  $('#tag_id').chosen().on 'change', ->
  # $('#tag_id').chosen().on 'change', ->
  #   $.get 'statements', $("#statements_search").serialize(), null, 'script'

  # $('#author_id').chosen().on 'change', ->
  #   $.get 'statements', $("#statements_search").serialize(), null, 'script'
  $('.st_chosen').chosen().on 'change', ->
    prms = $("#statements_search").serialize()
    $.get 'statements', prms, null, 'script'
    setLoc("statements?"+prms);

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

  $('.chosen-select').chosen
    placeholder_text_multiple: 'Выберите...'

