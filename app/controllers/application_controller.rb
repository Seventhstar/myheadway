class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
      unless logged_in?
        store_location
        # flash[:danger] = "Выполните вход."
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
