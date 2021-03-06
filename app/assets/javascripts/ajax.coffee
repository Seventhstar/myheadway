# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@onBlur = (el) ->
  if (el.value == '')
    el.value = el.defaultValue

@onFocus = (el) ->
  if (el.value == '0' || el.value == '0,0' || el.value == '0.0')
    el.value = ''

@upd_param = (param) ->
  $.ajax
    url: '/ajax/upd_param'
    data: param
    type: 'POST'
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
      return
    success: ->
      disable_input(false)
      show_ajax_message('Успешно обновлено')
      return

@disable_input = (cancel=true) ->
  item_id = $('.icon_apply').attr('item_id')
  item_rm_id = $('.icon_cancel').attr('item_id')
  $cells = $('.editable')
  $cells.each ->
  _cell = $(this)
  _cell.removeClass('editable')

  if cancel
    _cell.html _cell.attr('last_val')
  else
    _cell.html _cell.find('input').val()
  return

  $cell = $('td.app_cancel')
  $cell.removeClass('app_cancel')
  if item_rm_id == 'undefined' || item_rm_id == ''
    del_span = '<span class="icon icon_remove_disabled"></span>'
  else
    del_span = '<span class="icon icon_remove" item_id="'+item_id+'"></span>'
  $cell.html ('<span class="icon icon_edit" item_id="'+item_id+'"></span>'+del_span)

@apply_opt_change = (item)->
  model = item.closest('table').attr('model')
  item_id = item.attr('item_id')
  inputs = $('input[name^=upd]').serialize()
  upd_param(inputs+'&model='+model+'&id='+item_id)
  if item.closest('td').hasClass('l_edit') then sortable_query({})
  return

@cell_to_edit = (cl)->
  cl.addClass('editable')
  table = cl.closest('table')
  val = cl.html()
  cl.data('text', val).html ''
  cl.attr('last_val',val)
  fld = table.find('th:eq('+cl.index()+')').attr('fld')
  cl.attr('ind', fld)
  type = cl.attr('type')
  type = if type == undefined then 'text' else type
  $input = $('<input type="'+type+'" name=upd['+fld+'] />').val(cl.data('text')).width(cl.width() - 16)
  cl.append $input
  cl.context.firstChild.focus()

@sortable_query = (params)->
  actual = if $('.only_actual').length==0 then null else $('.only_actual').hasClass('on')

  url = {
    only_actual: actual
    sort: $('span.active').attr('sort')
    direction: $('span.active').attr('direction')
    sort2: $('span.subsort.current').attr('sort2')
    dir2: $('span.subsort.current').attr('dir2')
    search: $('#search').val()
  }

  l = window.location.toString().split('?');
  p = q2ajx(l[1])
  p_params = q2ajx($('.index_filter').serialize())
  each p, (i, a) ->
    if ['search','page','_'].include? i
      url[i] = a
    return
  each p_params, (i, a) ->
    url[i] = a
    return
  each params, (i, a) ->
    url[i] = a
    return
  # method = if $('#cur_method').val() == 'edit_multiple' then '/edit_multiple' else ''
  controller =  $('form').attr('action').replace("/", "")

  $.get controller, url, null, 'script'
  setLoc(controller+"?"+ajx2q(url));
  return

@sortable_prepare = (params, getFromUrl = false, applink = undefined) ->
  app = applink

  actual = if $('.switcher_a .link_a').length == 0 then null else $('.switcher_a .link_a').hasClass('on')

  cut = ''
  cut_selecter = '.cut.cutted'
  if $('.goods_list').length>0
    cut_selecter = '.cut:not(".cutted")'
  
  $(cut_selecter).each ->
    cut = cut + $(this).attr('cut_id') + '.'

  search = $('.search_area').val()
  year = if (nav? && nav.year?) then nav.year.value else $('#year').val()

  $('.search_save a').each (i) ->
    href = new URL(this.href)
    if search == '' || search == undefined
      href.searchParams.delete('search')
    else 
      href.searchParams.set('search', search)
    this.href = href

  url = {    
    only_actual: actual
    sort: $('span.active').attr('sort')
    direction: $('span.active').attr('direction')
    sort2: $('span.subsort.current').attr('sort2')
    dir2: $('span.subsort.current').attr('dir2')
    search: search
    year: year
    priority_id: $('#priority_id').val()
    good_state: $('#good_state').val()
    cut: cut
  }

  l = window.location.toString().split('?')
  p = q2ajx(l[1])
  ser = $('.index_filter').serialize()
  if ser == ""
    ser = $('.index_filter select').serialize()
  if_params = q2ajx(ser)
  
  each p, (i, a) -> # restore params from url
    if url[i] == undefined || ['search','page','_'].include? i 
      url[i] = a
    return

  each if_params, (i, a) -> # add params from .index_filter
    url[i] = a
    return

  each params, (i, a) -> # add params from args hash
    url[i] = a
    return 

  if (app?)
    filtersList = app.getFiltersList()
    if filtersList != undefined
      filtersList.forEach (e) ->
        if e.name == 'actual'
          url['actual'] = app.onlyActual
        else if e.value != undefined 
          url[e.name] = e.value
        else if app.readyToChange == undefined || app.readyToChange
          delete url[e.name]
        return

  each url, (i, a) ->
    if (a == 0 || a == '0' || a == undefined)
      delete url[i]  
    return 
    
  base_url = sort_base_url()  
  setLoc(""+base_url+"?"+ajx2q(url));
  return url
  
@sort_base_url = ->
  method = if $('#cur_method').val() == 'edit_multiple' then '/edit_multiple' else ''
  controller =  $('#search').attr('cname')
  controller = controller + "/" + $('#search').attr('mname') if controller == 'options'
  if controller == undefined 
    controller = window.location.toString().split('?')[0].split('/').splice(3).join('/')
  return controller+method

$(document).ready ->
  # поиск
  $('#search').on 'keyup', (e)->
    c= String.fromCharCode(event.keyCode);
    isWordCharacter = c.match(/\w/);
    isBackspaceOrDelete = (event.keyCode == 8 || event.keyCode == 46);
    if (isWordCharacter || isBackspaceOrDelete)
       delay("$.get($('form').attr('action'), $('form').serialize(), null, 'script')",700)
    return

  # обновление данных в таблицах страниц index
  $('.index_filter select,.index_filter input[type="radio"]').on 'change', ->
    sortable_query({})
    return

  $('.schosen').chosen(width: '99.5%')
  # $('#new_statement .st_chosen').chosen(width: '80%')
  # $('#new_attention .st_chosen,.edit_attention .st_chosen').chosen(width: '100%')
  # $('.chosen-select').chosen(width: '100%', disable_search: 'true')
  $('.chosen').chosen(width: '99.5%', disable_search: 'true')

  # редактирование ячейки в таблице
  $('.container').on 'dblclick', 'td.l_edit', ->
    if $(this).hasClass('editable')  then return
    disable_input()
    cell_to_edit($(this))
    return

  # редактирование данных в таблице
  $('.container').on 'click', 'span.icon_edit', ->
    item_id = $(this).attr('item_id')
    item_rm_id= $(this).next().attr('item_id')
    $row = $(this).parents('')
    disable_input()
    $cells = $row.children('td').not('.edit_delete,.state,.col_id')
    $cells.each ->
      cell_to_edit($(this))
      return

    $cell = $row.children('td.edit_delete')
    $cell.addClass('app_cancel')
    $cell.html '<span class="icon icon_apply" item_id="'+item_id+'"></span><span class="icon icon_cancel" item_id="'+item_rm_id+'"></span>'

  # отмена редактирования
  $('.container').on 'click', 'span.icon_cancel', ->
    disable_input()
    return

  # отправка новых данных
  $('.container').on 'click', 'span.icon_apply', ->
    apply_opt_change($(this))

  $('body').on 'keyup', '.editable input', (e) ->
    if e.keyCode == 13
      if $(this).closest('td').hasClass('l_edit') then i = $('.l_edit.editable') else i = $('span.icon_apply')
      apply_opt_change(i)
    else if e.keyCode == 27
      disable_input()
    return

  $('body').on 'keyup', '.edit_project input', (e)->
    if e.keyCode == 13 || e.keyCode == 8
      e.preventDefault()
    return
  $('body').on 'keyup', '.simple_options_form', (e) ->
    code = e.keyCode or e.which
    if code == 13
      console.log('on keyup .simple_options_form')
      e.preventDefault()
      if e.type == 'keyup'
        $('#btn-send').trigger('click')
        return
      return false
    return



