module BlogpostsHelper

  def blogpost_belongs_category?(category)
    if @blogpost  # no sense in testing new users that have no languages
        @blogpost.categories.include?(category)
    else
        false
    end
  end

end