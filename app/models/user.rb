class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_img,dependent: :destroy
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: [:google_oauth2]
        def self.from_omniauth(auth)
          user = where(provider: auth.provider, uid: auth.uid).first
          if user
            user.update(email: auth.info.email) unless user.email == auth.info.email
          else
            user = where(email: auth.info.email).first_or_create do |new_user|
              new_user.provider = auth.provider
              new_user.uid = auth.uid
              new_user.password = Devise.friendly_token[0, 20]
            end
          end
          user
        end
        
      
        validates :first_name, :last_name, presence: true
        scope :all_except, ->(user) { where.not(id: user) }
        after_create_commit { broadcast_append_to "users" }
        has_many :messages

        has_many :posts, dependent: :destroy
        has_many :comments, dependent: :destroy
        has_many :stories, dependent: :destroy
        
        # relationship config
        has_many :followed_users,
                  foreign_key: :follower_id,
                  class_name: 'Relationship',
                  dependent: :destroy

        has_many :followees, through: :followed_users,dependent: :destroy

        has_many :following_users,
                  foreign_key: :followee_id,
                  class_name: 'Relationship',
                  dependent: :destroy

        has_many :followers, through: :following_users,dependent: :destroy

        has_many :likes,dependent: :destroy
        has_many :notifications, as: :recipient, dependent: :destroy
end
