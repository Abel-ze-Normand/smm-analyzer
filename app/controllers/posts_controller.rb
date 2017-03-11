class PostsController < ApplicationController
  def load_posts
    Vk::StartPostsJobService.new(
      group_id: params[:group_id],
      access_token: session[:access_token],
    ).call
    redirect_to dashboard_path
  end

  # REMOVE
  def test_load_posts
    GroupPost.where(group_id: params[:group_id]).destroy_all
    Vk::FullProcessPostsService.new(
      group_id: params[:group_id],
      access_token: session[:access_token],
      loader: Vk::LoadPostsService,
      parser: Vk::ParsePostsService,
    ).call
    redirect_to dashboard_path
  end
end
