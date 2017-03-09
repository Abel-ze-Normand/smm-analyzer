class LoadDashboardDataService
  KEYS_DB = {
    groups: ->(i) { i.get_groups },
    vk_groups: ->(i) { i.get_vk_groups }
  }

  def initialize(options = {})
    @options = options
    @user = options.fetch(:user)
    @entries = options.fetch(:entries)
    @groups_ids = []
  end

  def call
    @entries.reduce({}) do |acc, e|
      acc.merge(e => KEYS_DB[e].call(self))
    end
  end

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
