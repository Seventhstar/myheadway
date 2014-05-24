module StatementsHelper

   def CheckShortContent (ss,id)
    if ss.length >280
        s = ss.gsub("</p>","").gsub('<p>','')
	    s.gsub!(/\n/, '<br>')
	    new_s = s[0..280] + "<span id=""addon"+id.to_s+" style=""display:none; "" >" + s[281..s.length] + "</span><span class=""toggleButton"" value=""Hide"" id=""stid"+id.to_s+"> ... </span>"
    else
        simple_format(ss)
    end
   
  end

end
