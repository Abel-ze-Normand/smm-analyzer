module Vk
  class StartStatsJobService
    def initialize(options = {})
      @options = options
      @group_id = options.fetch(:group_id)
    end

    def call
      group = Group.find(@group_id)
      job = LoadGroupStatsJob.perform_later(@options)
      group.update_attributes(stat_job_status: "running", stat_job_id: job.job_id)
    end
  end
end
