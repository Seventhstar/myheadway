# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#metadata').on 'click', 'li.link',  ->
    controller =  $('form').attr('action').replace("/", "")
    url = {}
    p_params = q2ajx($('form').serialize())
    each p_params, (i, a) ->
      url[i] = a
      return
    url['doc_id'] = $(this).attr('id').replace("doc", "")
    $.get controller, url, null, 'script'
    setLoc(controller+"?"+ajx2q(url));
    return

