require "rails_helper"

RSpec.describe GetStatsForGroupService do
  let(:group) { create(:group) }
  let(:stat) { create(:group_stat, group: group) }
  let(:options) { { group_id: group.id } }
  let(:expected_result) {
    {
      stats: [
        stat
      ],
      group: group
    }
  }

  subject { described_class.new(options).call }
  it { is_expected.to eq(expected_result) }
end
