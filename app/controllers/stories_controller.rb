class StoriesController < ApplicationController
  before_action :set_story, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  def show
    @story = Story.find(params[:id])
  end
  
  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    

    if @story.save
     # DeleteStoryJob.perform_later(@story.id, 5.minutes)
      redirect_to root_path, notice: 'Story was successfully uploaded.'
    else
      render :new
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to root_path, notice: "Story was successfully deleted."
  end

  private

  def story_params
    params.require(:story).permit(:title, :description, :Media, :user_id)
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end
end
