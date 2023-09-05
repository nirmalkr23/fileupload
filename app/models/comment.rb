class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user

    after_create_commit :notify_user
    before_destroy :cleanup_notifications
    has_noticed_notifications model_name: 'Notification'

    private

    def notify_user
        
        CommentNotification.with(comment: self,post: post).deliver_later(post.user)
    end

    def cleanup_notifications
        notifications_as_comment.destroy_all
    end
    

end
