class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # protect_from_forgery with: :exception #null_session
  include SessionsHelper

  def logged_in_user
      unless logged_in?
        store_location
        # flash[:danger] = "��������� ����."
        redirect_to login_url
      end
  end

	def fomatdate_date(d)
		if !d
			d= DateTime.now.to_date
		end
		d.strftime("%d-%m-%Y")
	end


end
