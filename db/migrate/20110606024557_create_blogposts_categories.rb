class CreateBlogpostsCategories < ActiveRecord::Migration
  def self.up
    create_table :blogposts_categories, :id => false do |t|
      t.integer :blogpost_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :blogposts_categories
  end
end
