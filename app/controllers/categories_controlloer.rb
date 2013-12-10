class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new

  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category successfully created"
      redirect_to categories_path
      
    else
      render :new
    end
  end

  def edit
  
  end

  def update
    
  end

  private

  def category_params
    params.require(:catgory).permit(:name)
  end

end