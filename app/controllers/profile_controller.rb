class ProfileController < ApplicationController
  include ProfileHelper
  before_action :set_user, except: [:followers, :following]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  def following
    @user = User.find(params[:id])
    @following = @user.followees
  end

  def follow
    Relationship.create_or_find_by(follower_id: current_user.id, followee_id: @user.id)
    
    respond_to do |format|
      format.turbo_stream do
        updates
      end
    end
  end
  

  def unfollow
    current_user.followed_users.where(follower_id: current_user.id, followee_id: @user.id).destroy_all
      format.turbo_stream do
        pdates
      end
    end
  end

  private

  def updates
    render turbo_stream:
    [
      turbo_stream.replace(dom_id_for_follower(@user.id), partial: 'profile/follow_button', locals: { user: @user }),
      turbo_stream.update(target: "#{@user.id}-follower-count", partial: 'profile/follower_count', locals: { user: @user })
    ]
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end
