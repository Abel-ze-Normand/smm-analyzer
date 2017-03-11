class LoadGroupStatsJob
  @queue = :default

  def self.perform(options = {})
    group_id = options.fetch(:group_id)
    Vk::FullProcessStatsService.new(options).call
    unlock_group(group_id)
  end

  private

  def unlock_group(group_id)
    Group.find(group_id).update_attributes!(stat_job_status: "done")
  end
end
