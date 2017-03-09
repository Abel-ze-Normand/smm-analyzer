class StatsController < ApplicationController
  def load_stats
    Vk::StartStatsJobService.new(
      group_id: params[:group_id],
      access_token: session[:access_token],
      # TODO remove this, hardcode
      # leave it for datepicker
      date_from: "1970-01-01",
      date_to: "2017-01-01"
    ).call
    redirect_to dashboard_path
  end
end
