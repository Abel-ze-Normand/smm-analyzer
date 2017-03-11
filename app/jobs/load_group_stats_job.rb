class LoadGroupStatsJob
  @queue = :default

  def self.perform(options = {})
    options = options.symbolize_keys
    group_id = options.fetch(:group_id)
    GroupStat.where(group_id: group_id).destroy_all
    Vk::FullProcessStatsService.new(
      options.merge(
        loader: Vk::LoadStatsService,
        parser: Vk::ParseStatsService,
        analyzer: Vk::StatsAnalyzerService
      )
    ).call
    unlock_group(group_id)
  rescue
    lock_group(group_id)
  end

  private

  def self.unlock_group(group_id)
    Group.find(group_id).update_attributes!(stat_job_status: "done")
  end

  def self.lock_group(group_id)
    Group.find(group_id).update_attributes!(stat_job_status: "not_started")
  end
end
