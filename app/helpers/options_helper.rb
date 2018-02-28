module OptionsHelper

  def attr_boolean?(item,attr)
    item.class.columns_hash[attr.to_s].class == ActiveRecord::Type::Boolean
  end


  def option_li( page,title, url = nil )
    #p "page",page,"@page_data",@page
    css_class = @page == page ? "active" : nil
    lnk = url.nil? ? '#' : page
    #p "lnk",lnk,url
    content_tag :li, {:class =>css_class } do

      link_to title, lnk,{:class =>"list-group-item", :controller => page}
    end
  end


  def get_active_option_page

    case @page
    when 'books','authors','tags'
      0
    when 'attn_cats'
      2
    when 'doc_types'
      3
    when 'task_cats', 'priorities'
      4
    else
      1
    end
        
  end


end
