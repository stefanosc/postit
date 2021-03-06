class CategoriesController < ApplicationController

  before_action :require_user, except: [:show, :index]
  before_action :require_admin, except: [:show, :index]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by_slug(params[:id])
  end

  def new
    @category = Category.new

  end

  def create
    @category = Category.new(category_params)
    @category.name.capitalize!

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
    params.require(:category).permit(:name)
  end

end