class AddIsStoryToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :is_story, :boolean
  end
end
