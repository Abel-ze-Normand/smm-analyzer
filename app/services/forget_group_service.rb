class ForgetGroupService
  def initialize(options = {})
    @group_id = options.fetch(:group_id)
  end

  def call
    Group.find(@group_id).destroy
  end
end
