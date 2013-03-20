class CategoriesController < ApplicationController

  # Only authorize administrators to be able to interact with categories
  before_filter :authorize_administrator

  def new
    @category=Category.new
  end

  def create
    @category=Category.new(params[:category])
    if @category.save
      redirect_to root_url, :notice => "Successfully created"
    else
    end
  end

  def index
    @categories=Category.all
  end

  def show
    @category=Category.find(params[:id])
  end

  def edit
    @category=Category.find(params[:id])
  end

  def update
    category = Category.find(params[:id])
    if category.update_attributes(params[:category])
      redirect_to category_path(category.id)
    else
      render action: "edit"
    end
  end


end
