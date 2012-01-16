class UsersController < ApplicationController
  def index
    @users = User.excludes(:id => current_user.id).order_by [:name, :asc]
    @user = User.new
    @categories = Category.order_by [:name, :asc]
  end

  def create
    @user = User.new params[:user]
    if @user.save
      flash[:notice] = 'Docent is toegevoegd.'
    end
    redirect_to users_path
  end

  def edit
    @categories = Category.order_by [:name, :asc]
  end

  def update
    @user = User.find params[:id]
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes params[:user]
      flash[:notice] = 'Profiel is bijgewerkt.'
    end
    redirect_to users_path
  end

  def destroy
    @user = User.find params[:id]
    if @user.destroy
      flash[:notice] = 'Docent is verwijderd.'
    end
    redirect_to users_path
  end
end
