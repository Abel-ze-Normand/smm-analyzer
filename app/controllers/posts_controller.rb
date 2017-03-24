class PostsController < ApplicationController
  def load_posts
    Vk::StartPostsJobService.new(
      group_id: params[:group_id],
      access_token: session[:access_token],
    ).call
    redirect_to dashboard_path
  end
end
