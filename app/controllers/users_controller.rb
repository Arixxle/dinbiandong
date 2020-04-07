class UsersController < ApplicationController
  
  skip_before_action :check_login

  def login
    @user = User.new
  end
  def signin
    #查資料庫有沒有這個使用者
    user = User.find_by(email: user_params[:email], password: user_params[:password])
    # user = User.find_by(email: user_params[:email], password: user_params[:password])
    if user
      session[:ccc9527] = user.email
      redirect_to root_path
    else
      redirect_to login_path
    end 
  end

  def logout
    session[:ccc9527] = nil
    redirect_to root_path
  end

  def sign_up
    @user = User.new
  end

  def registration
    @user = User.new(user_params)
    if @user.save
      #成功
      #todo 幫登入
      session[:ccc9527] = @user.email
      #todo 密碼加密-很重要，一定要做
      redirect_to "/"
    else
      #失敗
      render :sign_up
      # redirect_to "/sign_up"
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, 
                                 :password, 
                                 :password_confirmation)
    
  end
end