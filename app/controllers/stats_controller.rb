class StatsController < ApplicationController
  def load_stats
    Vk::StartStatsJobService.new(
      group_id: params[:group_id],
      access_token: session[:access_token],
      # TODO remove this, hardcode
      date_from: "1970-01-01",
      date_to: "2017-01-01"
    ).call
  end
end
