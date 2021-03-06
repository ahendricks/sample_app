class UsersController < ApplicationController
  before_action :signed_in_user, only:     [:index, :edit, :update, :destroy]
  before_action :correct_user,   only:     [:edit, :update]
  before_action :admin_user,     only:     [:destroy]
  before_action :non_signed_in_user, only: [:new, :create]
	
  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def index
    @users = User.order(:id).paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) 
	if @user.save
    sign_in @user
		flash[:success] = "Welcome to the Sample App, #{@user.name}!"
		redirect_to @user
	else
		render 'new'
	end
  end

  def edit
  end

  def update 
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.admin?
      flash[:error] = "You can't delete an admin."
    else
      user.destroy
      flash[:success] = "User deleted."
    end
    redirect_to users_url
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password,
  		 							 :password_confirmation)
  	end

    # before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      unless current_user.admin?
        redirect_to root_url
      end
    end

    def non_signed_in_user
      unless !signed_in?
        redirect_to root_url
      end
    end
end
