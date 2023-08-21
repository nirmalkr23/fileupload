class AddMediaToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :Media, :string
  end
end
