class UsersController < ApplicationController

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render 'edit'
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private
  # ストロングパラメーターに住所関連のカラムを追加
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email, :postcode, :prefecture_code, :address_city, :address_street, :address_building)
  end
end
