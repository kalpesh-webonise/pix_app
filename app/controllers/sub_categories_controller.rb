class SubCategoriesController < ApplicationController
  before_action :find_sub_category, only: [:show, :edit, :update, :destroy]

  # GET /sub_categories/1
  # GET /sub_categories/1.json
  def show
  end

  # GET /sub_categories/new
  def new
    @category = Category.find(params[:category_id])
    @sub_category = @category.sub_categories.new
  end

  # GET /sub_categories/1/edit
  def edit
    @category = @sub_category.category
  end

  # POST /sub_categories
  # POST /sub_categories.json
  def create
    @category = Category.find(params[:sub_category][:category_id])
    @sub_category = SubCategory.new(sub_category_params)
    #@category = Category.find(params[:category_id])
    #@sub_category = @category.sub_categories.new

    respond_to do |format|
      if @sub_category.save
        format.html { redirect_to '/categories', notice: 'Sub category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sub_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_categories/1
  # PATCH/PUT /sub_categories/1.json
  def update
    respond_to do |format|
      if @sub_category.update(sub_category_params)
        format.html { redirect_to  '/categories', notice: 'Sub category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_categories/1
  # DELETE /sub_categories/1.json
  def destroy
    @sub_category.destroy
    respond_to do |format|
      format.html { redirect_to sub_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_category_params
      params.require(:sub_category).permit(:name, :category_id)
    end
end
