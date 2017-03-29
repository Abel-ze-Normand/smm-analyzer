module Vk
  class StartInitializeAllService
    def initialize(options = {})
      @group_id = options.fetch(:group_id)
      @options = options
    end

    def call
      Resque.enqueue(InitializeAllJob, @options)
      group = Group.find(@group_id)
      group.update_attributes(posts_job_status: "running", stat_job_status: "running")
    end
  end
end
