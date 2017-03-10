class GetThemesForGroupService
  def initialize(options = {})
    @group_id = options.fetch(:group_id)
  end

  def call
    {
      group: group,
      themes: themes
    }
  end

  private

  def group
    @group = Group.find(@group_id)
  end

  def themes
    @group.themes
  end
end
