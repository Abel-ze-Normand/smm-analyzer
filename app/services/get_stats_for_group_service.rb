class GetStatsForGroupService
  def initialize(options = {})
    @group_id = options.fetch(:group_id)
  end

  def call
    {
      group: get_group,
      stats: get_stats
    }
  end

  private

  def get_group
    @group = Group.find(@group_id)
  end

  def get_stats
    @group.group_stats
  end
end
