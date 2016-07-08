module StatementsHelper

   def CheckShortContent (ss,id, cut_length = 240)
    s = ss.gsub("</p>","").gsub('<p>','')
    if s.length >cut_length
	    s.gsub!(/\n/, '<br>')
	    new_s = s[0..cut_length] + "<span id=""addon"+id.to_s+" style=""display:none; "" >" + s[cut_length+1..s.length] + "</span><span class=""toggleButton"" value=""Hide"" id=""stid"+id.to_s+"> ... </span>"
    else
        simple_format(s)
    end

  end

end
