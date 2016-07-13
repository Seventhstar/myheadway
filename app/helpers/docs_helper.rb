module DocsHelper

   def check_fn(name)

    delim = 'multiline_code">'
    new_name = name.split(delim)
    # dd
    if new_name.length >1
      pos_sp = new_name[1].index(' ')
      pos_bkt= new_name[1].index('(')
      new_str = new_name[1]

      new_str = '<span class="function">'+new_str[0..pos_bkt-1] +'</span>'+ new_str[pos_bkt..-1] if pos_bkt< pos_sp
      new_str = new_name[0]+delim+new_str
      new_str = new_str + check_fn('multiline_code">'+new_name[2..-1].join) if new_name.length>2
    else
      new_str = name
    end
    new_str
  end

end
