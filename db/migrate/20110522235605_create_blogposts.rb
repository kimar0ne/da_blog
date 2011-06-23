class CreateBlogposts < ActiveRecord::Migration
  def self.up
    create_table :blogposts do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.string :category
      t.boolean :published

      t.timestamps
    end


  end

  def self.down
    drop_table :blogposts
  end
end
