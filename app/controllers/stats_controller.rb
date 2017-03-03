class StatsController < ApplicationController
  def load_stats
    Vk::StartStatsJobService.new(

    )

  end
end
