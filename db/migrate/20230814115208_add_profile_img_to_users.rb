class AddProfileImgToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile_img, :string
  end
end
