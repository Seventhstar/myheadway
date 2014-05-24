module TargetsHelper

  def current_period

     if params[:month]
        @current_year  = params[:year].to_i
        @current_month  = params[:month].to_i

        @current_period = Date.new(@current_year,@current_month,1)
     else    	
	@current_month = Date.today.month
	@current_year = Date.today.year
        @current_period ||= Date.today.beginning_of_month

     end
  end

  def current_month (month = nil)
     if params[:month]
        @current_month = params[:month].to_i
     else    	
	@current_month ||= Date.today.month
     end
  end

  def prev_year 
      year = current_period.prev_year.year
      month = current_period.prev_year.month
      return link_to "<<", targets_path+"/period/"+year.to_s+"/"+month.to_s
  end

  def next_year 
      year = current_period.next_year.year
      month = current_period.next_year.month
      return link_to ">>", targets_path+"/period/"+year.to_s+"/"+month.to_s
  end

  def prev_month 
      year = current_period.prev_month.year
      month = current_period.prev_month.month
      return link_to "<", targets_path+"/period/"+year.to_s+"/"+month.to_s
  end

  def next_month
      year = current_period.next_month.year
      month = current_period.next_month.month
      return link_to ">", targets_path+"/period/"+year.to_s+"/"+month.to_s
  end


  def day_checked(target_id_1, day_1)
     t = TargetDay.where( :target_id => target_id_1, :day => day_1, :month =>@current_month, :year => @current_year ).first
#   trgts = Target.find(target_id_1).target_ids

 #  t = TargetDay.where( "(target_id =? or parent_id in ?) and day =? and month =? and year = ?", target_id_1,trgts,day_1,@current_month,@current_year).first
    if t!=nil
        if t.checked 
           return "checked"
        end
    end
    return ""
  end
  
  def class_on_date_type( day )
	
      class_name = ""
      if day.sunday? || day.saturday? 
         class_name=" holyday"
      end 
      if day == Date.today
         class_name=" today"
      end 

      return class_name
  end

end
