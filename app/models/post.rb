class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, :length => { :maximum => 100 }
end

