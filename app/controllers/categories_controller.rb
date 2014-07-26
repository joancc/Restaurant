class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @restaurants = @category.restaurants
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
