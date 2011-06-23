class Blogpost < ActiveRecord::Base
    attr_accessible :content, :title, :category, :published, :category_ids

    belongs_to :user
    has_and_belongs_to_many :categories

    validates :content, :presence => true
    validates :title, :presence => true, :length => { :maximum => 140 }
    validates_inclusion_of :published, :in => [true,false]
    validates :user_id, :presence => true

    default_scope :order => 'blogposts.created_at DESC'


end
