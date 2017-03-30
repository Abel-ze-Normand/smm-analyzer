require "rails_helper"

RSpec.describe GetTargetAudienceService do
  before {
    @group = create(:group)
    @theme = create(:theme, group: @group)
    @stats = (0...10).map { |_| create(:group_stat, group: @group) }
    @stats.each { |s| create(:age_cluster, group_stat: s) }
    @posts = @stats.map { |s| create(:group_post, theme: @theme, group: @group, group_stat: s) }

    @expected_res = prepare_expected_result
  }

  subject { described_class.new(theme_id: @theme.id).call }

  it { is_expected.to eq(@expected_res) }

  def prepare_expected_result
    cluster = create(:age_cluster)
    audience = GetTargetAudienceService::RANGES.reduce({}) { |acc, r|
      acc.merge("from #{r.first} to #{r.last}" => cluster.send("from_#{r.first}_to_#{r.last}_count").to_f)
    }
    {
      :audience => audience,
      :top_audience => [ "from 12 to 18", cluster.from_12_to_18_count.to_f ]
    }
  end
end
