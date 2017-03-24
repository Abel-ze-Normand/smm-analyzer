require "rails_helper"

RSpec.describe GetPopularThemesService do
  before do
    @group = create(:group)
    @themes = 2.times.map { |_| create(:theme, group: @group) }
    @posts = 100.times.map { |_|
      create(
        :group_post,
        group: @group,
        theme: @themes.sample,
        likes_count: rand(0..100),
        reposts: rand(0..100),
        views: rand(0..100)
      )
    }
    @themes.each { |t| t.refresh_stats }
  end

  subject { described_class.new(group_id: @group.id).call }

  it {
    is_expected.to satisfy { |res|
      res.first == Theme.all.sort_by { |t| t.stats_accumulated }.first
    }
  }
end
