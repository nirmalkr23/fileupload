class Story < ApplicationRecord
  belongs_to :user

  has_one_attached :Media,dependent: :destroy


  def self.delete_old_stories
    where("created_at < ?", 5.minutes.ago).destroy_all
  end
end
