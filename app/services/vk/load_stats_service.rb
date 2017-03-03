module Vk
  class LoadStatsService
    def initialize(options = {})
      @group_id = options.fetch(:group_id)
      @access_token = options.fetch(:access_token)
      @date_from = options.fetch(:date_from)
      @date_to = options.fetch(:date_to)
      @app = VkClient.new
    end

    def call
      @app.authorize access_token: @access_token
      @app.get_stats group_id: @group_id, date_from: @date_from, date_to: @date_to
    end
  end
end
