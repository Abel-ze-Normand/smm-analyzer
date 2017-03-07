module Vk
  class LoadGroupsService
    def initialize(options = {})
      @group_id = options[:group_id]
      @group_ids = options[:group_ids]
      @action = options.fetch(:action)
      @access_token = options.fetch(:access_token)
      @app = VkClient.new
    end

    def call
      @app.authorize access_token: @access_token
      case @action
      when :one
        @app.get_group(@group_id)
      when :many
        @app.get_groups(@group_ids.join(","))
      end
    end
  end
end
