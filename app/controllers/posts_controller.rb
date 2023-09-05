class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  def test
  end



  
  def get_story
    @stories=Story.all
  end

  def get_post_of_follower
    if current_user
      @stories=Story.all
      @following_posts = Post.all # or however you're getting the posts

        # Sorting logic
        case params[:sort_by]
        when 'name_asc'
          @following_posts = @following_posts.joins(:user).order('users.first_name ASC')
        when 'name_desc'
          @following_posts = @following_posts.joins(:user).order('users.first_name DESC')
        when 'latest'
          @following_posts = @following_posts.order('created_at DESC')
        when 'oldest'
          @following_posts = @following_posts.order('created_at ASC')
        end
        
        # ... any other logic ...

        @following_posts = @following_posts.paginate(page: params[:page], per_page: 8) # or whatever per_page you set
    else
      redirect_to new_user_session_path
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    
    @post = Post.find(params[:id])
    if current_user != @post.user # Only increment if current user is not the owner
      @post.increment!(:view_count)
    end
    @comment = Comment.new  # Initialize a new Comment object for the form
    @comments = @post.comments
    mark_notifications_as_read
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end
  # def new_story
  #   @story = Post.new
  # end

  # def create_story
  #   @story = Post.new(story_params)
  #   @story.is_story = true
  #   @story.user = current_user

  #   if @story.save
  #     redirect_to posts_path, notice: 'Story was successfully uploaded.'
  #   else
  #     render :new_story
  #   end
  # end
  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.likes.destroy_all # Delete associated likes
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description,  :video, :user_id)
    end

    private
    def story_params
      params.require(:post).permit(:title, :description, :media)
    end

    def mark_notifications_as_read
      notification_to_mark_as_read = @post.notifications_as_post.where(recipient: current_user)
      notification_to_mark_as_read.update_all(read_at: Time.zone.now)
    end
end
