class LoadDashboardDataService
  def initialize(options = {})
    @options = options
    @user = options.fetch(:user)
  end

  def call
    {
      groups: get_groups,
      vk_groups: get_vk_groups
    }
  end

  private

  def get_groups
    @groups = @user.groups
    @groups_ids = @groups.pluck(:id)
    @groups
  end

  def get_vk_groups
    # filter yet available groups
    Vk::GroupScannerService
      .new(@options.merge(user_id: @user.id))
      .call
      .reject { |g| @groups_ids.include? g.id }
  end
end
