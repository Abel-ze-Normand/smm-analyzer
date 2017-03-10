class StatsController < ApplicationController
  def load_stats
    Vk::StartStatsJobService.new(
      group_id: params[:group_id],
      access_token: session[:access_token],
      # TODO remove this, hardcode
      # leave it for datepicker
      date_from: "1970-01-01",
      date_to: "2017-01-01",
      loader: Vk::LoadStatsService,
      parser: Vk::ParseStatsService,
      analyzer: Vk::StatsAnalyzerService
    ).call
    redirect_to dashboard_path
  end

  def index
    result = GetStatsForGroupService.new(params).call
    @stats = result[:stats]
    @group = result[:group]
  end
end
