class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page],per_page:10)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page],per_page:10)
    @comments = @user.comments
    @courses = @user.courses
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
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "我关注的人"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "关注我的人"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
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

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end
