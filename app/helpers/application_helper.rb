module ApplicationHelper
	def getRandomStatement()
		#@rand_statement = Statement.order("RANDOM()").first
		@rand_statement = Statement.find(95)
	end

  def chosen_src( id, collection, obj = nil, options = {})  
    p_name    = options[:p_name].nil? ? 'name' : options[:p_name]
    order     = options[:order].nil? ? p_name : options[:order]
    nil_value = options[:nil_value].nil? ? 'Выберите...' : options[:nil_value]
    
    coll = collection.class.ancestors.include?(ActiveRecord::Relation) ? collection : collection
    coll = coll.collect{ |u| [u[p_name], u.id] }
    coll.insert(0,[nil_value,nil]) if nil_value != ''
    coll.insert(1,[options[:special_value],-1]) if !options[:special_value].nil?

    is_attr = (obj.class != Fixnum && obj.class != String && !obj.nil?)
    sel = is_attr ? obj[id] : obj
    sel = options[:selected] if !options[:selected].nil?
      n = is_attr ? obj.model_name.singular+'['+ id.to_s+']' : id

    def_cls = coll.count < 8 ? 'chosen' : 'schosen'
    cls       = options[:class].nil? ? def_cls : options[:class]
    
    cls = cls+" has-error" if is_attr && ( obj.errors[id].any? || obj.errors[id.to_s.gsub('_id','')].any? )
    l = label_tag options[:label]
    s = select_tag n, options_for_select(coll, :selected => sel), class: cls
    options[:label].nil? ? s : l+s
  end

  def menu_li(title, link, def_link = :statements)
     css_li = current_page?(link)||link==def_link ? "active": ""
     #p "link",link, request.url==root_url
     content_tag :li,{:class => css_li} do
        link_to title, link
     end
  end

  def sortable_pil(column, title = nil)
    css_class = column.to_s == @gr_id ? "active " : ""
    #p "column",column, @gr_id
    link_to title, "targets?tgroup_id="+column.to_s,{:class => css_class, :sort => column }
  end

  def edit_delete(element, subcount = 0, invisible = false)

    hidden = invisible ? "hid": ""

    content_tag :div,{:class=>"edit_delete #{hidden}"} do
		ed = link_to image_tag('edit.png'), edit_polymorphic_path(element) 
 		
    

    subcount ||= 0
		if subcount>0 
  			de = image_tag('delete-disabled.png')
		else
  			de = link_to image_tag('delete.png'), element, method: :delete, data: { confirm: 'Действительно удалить?' }
		end 

		ed + de
	end
  end

  def td_tool_icons(element,str_icons='edit,delete',params = nil)
    
    all_icons = {} #['edit','delete','show'] tag='span',subcount=nil
    params ||= {}
    params[:tag] ||= 'href' 
    icons = str_icons.split(',')
    params[:subcount] ||= 0
    params[:add_cls] ||= ''
    dilable_cls = params[:subcount]>0 ? '_disabled' : ''
    if params[:tag] == 'span' 
      all_icons['edit'] = content_tag :span, "", {class: 'icon icon_edit', item_id: element.id}
      all_icons['delete'] = content_tag( :span,"",{class: ['icon icon_remove',dilable_cls,' ',params[:add_cls]].join, item_id: params[:subcount]>0 ? '' : element.id})
     else
      all_icons['edit'] = link_to "", edit_polymorphic_path(element), class: "icon icon_edit"
      all_icons['show'] = link_to "", polymorphic_path(element), class: "icon icon_show", data: { modal: true }
      all_icons['delete'] = link_to "", element, method: :delete, data: { confirm: 'Действительно удалить?' }, class: "icon icon_remove " if params[:subcount]==0
      all_icons['delete'] = content_tag(:span,"",{class: 'icon icon_remove_disabled'}) if params[:subcount]>0
    end
    content_tag :td,{:class=>"edit_delete"} do
      icons.collect{ |i| all_icons[i] }.join.html_safe
    end

  end


  def submit_cancel(back_url)
      s = submit_tag  t('Save'), class: 'btn btn-success' 
      c = link_to t('Cancel'), back_url, class: "btn btn-white btn-reset" 
      s + c
  end


end
