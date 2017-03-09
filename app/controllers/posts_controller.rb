class PostsController < ApplicationController
  def load_posts
    Vk::StartPostsJobService.new(
      group_id: params[:group_id],
      loader: Vk::LoadPostsService,
      parser: Vk::ParsePostsService,
    ).call
    redirect_to dashboard_path
  end
end
