class Denial < ActiveRecord::Base

  attr_accessor :denial_start_date

 def denial_start_date
     if self.present?
        start_date = self.try(:start_date) 
        if start_date
           start_date.strftime("%d-%m-%Y")
	else
	  ""
        end
     else
       ""
     end
 end
end
