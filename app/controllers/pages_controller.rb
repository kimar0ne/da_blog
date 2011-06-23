class PagesController < ApplicationController

  def home
    @title = "Home"
    @blogposts = Blogpost.paginate(:page => params[:page])
    @categories = Category.find(:all)
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
end