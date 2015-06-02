class Denial < ActiveRecord::Base
 def denial_start_date
     if self.start_date
       fomatdate_date(self.try(:start_date))
     else
       ""
     end
 end
end
