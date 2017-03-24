require "rails_helper"

RSpec.describe CalculateThemeStatsService do
  before do
    @theme = create(:theme)
    create(:group_post, theme: @theme, likes_count: 4, reposts: 5, views: 4)
    create(:group_post, theme: @theme, likes_count: 8, reposts: 5, views: 2)
    described_class.new(theme: @theme).call
  end
  it {
    expect(Theme.find(@theme.id)).to satisfy { |t|
      t.stat_mean_likes == 6.0 &&
        t.stat_var_likes == 4.0 &&
        t.stat_mean_reposts == 5.0 &&
        t.stat_var_reposts == 0.0 &&
        t.stat_mean_views == 3.0 &&
        t.stat_var_views == 1.0
    }
  }
end
