class LoadGroupStatsJob < ApplicationJob
  include ActiveJobStatus::Hooks
  queue_as :default

  def perform(options = {})
    group_id = options.fetch(:group_id)
    Vk::FullProcessStatsService.new(options).call
    unlock_group(group_id)
  end

  private

  def unlock_group(group_id)
    group = Group.find(group_id)
    group.stat_job_status = "done"
    group.save!
  end
end
