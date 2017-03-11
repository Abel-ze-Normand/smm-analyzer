require "rails_helper"

RSpec.describe Vk::StatsAnalyzerService do
  let!(:group) { create(:group) }
  let!(:stats) {
    [
      create(:group_stat, group: group)
    ]
  }
  let(:posts) {
    [
      create(:group_post, group_stat: nil, date: stats.first.day, group: group)
    ]
  }
  let!(:options) {
    {
      stats: stats,
      group_id: group.id
    }
  }
  subject { ->() { described_class.new(options).call } }

  it {
    expect(subject.call).to satisfy { |_|
      GroupPost.all.reduce(true) { |acc, p|
        acc && (p.group_stat == stats.first)
      }
    }
  }
end
