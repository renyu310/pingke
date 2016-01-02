class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # 登入用户，重定向到主页
      log_in user
      redirect_to user
    else
      #创建一个错误消息
      flash.now[:danger] = '无效的邮箱或密码！'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
