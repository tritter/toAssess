class CategoriesController < ApplicationController
  authorize_resource

  def index
    @categories = Category.order_by [:name, :asc]
    @category = Category.new
    6.times { @category.courses.build }
  end

  def create
    @category = Category.new params[:category]
    if @category.save
      flash[:notice] = 'Gegevens zijn toegevoegd.'
    end
    redirect_to categories_path
  end

  def update
    @category = Category.find params[:id]
    if @category.update_attributes params[:category]
      flash[:notice] = 'Gegevens zijn bijgewerkt.'
    end
    redirect_to categories_path
  end

  def destroy
    @category = Category.find params[:id]
    if @category.destroy
      flash[:notice] = 'Gegevens zijn verwijderd.'
    end
    redirect_to categories_path
  end
end
