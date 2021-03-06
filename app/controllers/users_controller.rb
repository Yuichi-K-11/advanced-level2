class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @users = User.all
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def follow
    @user = User.find(params[:id])
    @users = User.all
  end
  
  def follower
    @user = User.find(params[:id])
    @users = User.all
  end  
  
  def confirm!
    super
    if confirmed?
      UserMailer.completion_of_registration(self).deliver
    end
  end
  
  private
  def zipedit
  params.require(:user).permit(:postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
