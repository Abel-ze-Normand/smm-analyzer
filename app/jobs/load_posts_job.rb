class LoadPostsJob
  @queue = :default

  def self.perform(options = {})
    options = options.symbolize_keys
    group_id = options.fetch(:group_id)
    GroupPost.where(group_id: group_id).destroy_all
    Vk::FullProcessPostsService.new(
      options.merge(
        loader: Vk::LoadPostsService,
        parser: Vk::ParsePostsService,
        analyzer: Vk::PostsAnalyzerService
      )
    ).call
    unlock_group(group_id)
  rescue
    lock_group(group_id)
  end

  private

  def self.unlock_group(group_id)
    Group.find(group_id).update_attributes(posts_job_status: "done")
  end

  def self.lock_group(group_id)
    Group.find(group_id).update_attributes(posts_job_status: "not_started")
  end
end
