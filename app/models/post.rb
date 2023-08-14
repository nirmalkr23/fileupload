class Post < ApplicationRecord
    has_one_attached :video,dependent: :destroy

    belongs_to :user 

    has_many :comments,dependent: :destroy
    has_many :likes,dependent: :destroy

    validates :title, presence: true, length: { minimum: 5, maximum: 100 }
    validates :description, presence: true,length: { minimum: 5, maximum: 200 }
end
