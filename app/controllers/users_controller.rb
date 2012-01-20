class UsersController < ApplicationController
  authorize_resource

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
    unless (current_user.admin? and @user.name == 'Administrator' and params[:user][:name] != 'Administrator') or (!current_user.admin? and params[:user][:name] == 'Administrator')
      if @user.update_attributes params[:user]
        flash[:notice] = 'Profiel is bijgewerkt.'
      end
    end
    if current_user.admin?
      redirect_to users_path
    else
      redirect_to edit_user_path @user
    end
  end

  def destroy
    @user = User.find params[:id]
    unless @user.name == 'Administrator'
      if @user.destroy
        flash[:notice] = 'Docent is verwijderd.'
      end
    end
    redirect_to users_path
  end
end
