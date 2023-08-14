class SearchController < ApplicationController
  before_action :authenticate_user!
  def index
    @search_query = params[:search]
    
    # Perform search logic based on @search_query
    # For example, you can fetch users with a name similar to the search query
    @search_results = User.where("first_name LIKE ?", "%#{@search_query}%")
  end
end
