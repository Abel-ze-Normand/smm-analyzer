class LoadDashboardDataService
  def initialize(options = {})
    @options = options
  end

  def call
    {
      groups: get_groups
    }
  end

  private

  def get_groups
    @options.fetch(:user).groups
  end
end
