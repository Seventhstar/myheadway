module StatementsHelper

   def CheckShortContent (ss,id)
    s = ss.gsub("</p>","").gsub('<p>','')
    if s.length >240
	    s.gsub!(/\n/, '<br>')
	    new_s = s[0..240] + "<span id=""addon"+id.to_s+" style=""display:none; "" >" + s[241..s.length] + "</span><span class=""toggleButton"" value=""Hide"" id=""stid"+id.to_s+"> ... </span>"
    else
        simple_format(s)
    end
   
  end

end
