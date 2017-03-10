class GetStatsForGroupService
  def initialize(options = {})
    @group_id = options.fetch(:group_id)
  end

  def call
    {
      group: group,
      stats: stats
    }
  end

  private

  def group
    @group = Group.find(@group_id)
  end

  def stats
    @group.group_stats
  end
end
