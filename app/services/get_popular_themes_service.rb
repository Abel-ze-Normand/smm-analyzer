class GetPopularThemesService
  def initialize(options = {})
    @group_id = options.fetch(:group_id)
    @criteria = options[:criteria]
  end

  def call
    @group = Group.find(@group_id)
    @themes = @group.themes
    pick_top_10
  end

  private

  def pick_top_10
    case @criteria
    when :likes
      @themes.sort_by { |t| t.stats_likes_converged }.take(10)
    when :reposts
      @themes.sort_by { |t| t.stats_reposts_converged }.take(10)
    when :views
      @themes.sort_by { |t| t.stats_views_converged }.take(10)
    else
      @themes.sort_by { |t| t.stats_accumulated }.take(10)
    end
  end
end
