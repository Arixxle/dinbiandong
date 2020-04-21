class ApplicationController < ActionController::Base
  
  rescue_from ActiveRecord::RecordNotFound, 
  with: :record_not_found

  before_action :check_login
  helper_method :current_user, :current_cart
  # include UsersHelper

  private
  def check_login
    if not current_user
      redirect_to login_path
    end
  end

  def record_not_found
    # redirect_to items_path, notice: '找嘸!'
    render file: 'public/404.html', 
    status: 404, 
    layout: false
  end
  def current_user
    # session[:ccc9527] #現在這裡是id
    User.find_by(id: session[:ccc9527]) #這裡會撈出一比model資料 find_by(id)
  end
  def current_cart
    @_ca123 ||= Cart.from_hash(session[:carty])
  end
end
