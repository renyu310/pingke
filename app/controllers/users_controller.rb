class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def create

    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:sucess] = "欢迎来到友课网！"
      redirect_to @user
    else
      render 'new'
    end

  end

  def new
    @user = User.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def delete

  end

  def destroy

  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    #健壮参数
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :department, :major, :tag, :introduction, :phone, :qq)
    end

    #确保用户已登陆
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    #确保是正确的用户
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
