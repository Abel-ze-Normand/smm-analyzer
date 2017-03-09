module Vk
  class LoadPostsService
    def initialize(options = {})
      @access_token = options.fetch(:access_token)
      @group_id = options.fetch(:group_id)
      @app = VkClient.new
    end

    def call
      @app.authorize(access_token: @access_token)
      @app.get_posts(@group_id)
    end
  end
end
