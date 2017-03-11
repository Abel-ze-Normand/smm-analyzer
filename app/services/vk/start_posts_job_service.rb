module Vk
  class StartPostsJobService
    def initialize(options = {})
      @options = options
      @group_id = options.fetch(:group_id)
    end

    def call
      group = Group.find(@group_id)
      Resque.enqueue(LoadPostsJob, @options)
      group.update_attributes(posts_job_status: "running")
    end
  end
end
