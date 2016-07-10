# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  #$('#search').autocomplete
  #  source: "/search_suggestions"
  #$('#search').on 'keyup', ->
  #  delay($.get $('form').attr('action'), $('form').serialize(), null, 'script')

  $('.st_chosen').chosen()
  $('#tag_id').chosen().on 'change', ->

  $('.filter_chosen').chosen().on 'change', ->
    prms = $('form').serialize()
    url = $('form').attr('action')
    $.get url, prms, null, 'script'
    setLoc( url.replace("/", "")+"?"+prms);

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

  #$('.chosen-select').chosen
  #  placeholder_text_multiple: 'Выберите...'

