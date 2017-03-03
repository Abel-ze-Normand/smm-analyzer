module Vk
  class FullProcessStatsService
    def initialize(options = {})
      @group_id = options.fetch(:group_id)
      @access_token = options.fetch(:access_token)
      @date_from = options.fetch(:date_from)
      @date_to = options.fetch(:date_to)
    end

    def call
      raw_stats = Vk::LoadStatsService.new(
        group_id: @group_id,
        access_token: @access_token,
        date_from: @date_from,
        date_to: @date_to
      ).call
      Vk::ParseStatsService.new(stats: raw_stats, group_id: @group_id).call
    end
  end
end
