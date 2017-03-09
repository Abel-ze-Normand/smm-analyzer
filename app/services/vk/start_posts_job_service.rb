module Vk
  class StartPostsJobService
    def initialize(options = {})
      @options = options
      @group_id = options.fetch(:group_id)
    end

    def call
      group = Group.find(@group_id)
      job = LoadPostsJob.perform_later(@options)
      group.update_attributes(posts_job_status: "running", posts_job_id: job.job_id)
    end
  end
end
