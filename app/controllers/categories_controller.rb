class CategoriesController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user, :only => [:index, :edit, :update, :destroy]

  
  # GET /categories
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @categories }
    end
  end


  # GET /categories/1
  def show
    @category = Category.find(params[:id])
    @categories = Category.find(:all)
    @blogposts = @category.blogposts.paginate(:page => params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @category }
    end
  end


  # GET /categories/new
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @category }
    end
  end


  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end



  # POST /categories
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'Post was successfully created.') }
        format.xml { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /categories/1
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(@category, :notice => 'Post was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /categories/1
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

  end

  private

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end

