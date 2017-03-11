module Vk
  class StartStatsJobService
    def initialize(options = {})
      @options = options
      @group_id = options.fetch(:group_id)
    end

    def call
      group = Group.find(@group_id)
      Resque.enqueue(LoadGroupStatsJob, @options)
      group.update_attributes(stat_job_status: "running")
    end
  end
end
