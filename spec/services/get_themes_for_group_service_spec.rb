require "rails_helper"

RSpec.describe GetThemesForGroupService do
  let(:group) { create(:group) }
  let(:themes) { [create(:theme, group: group)] }
  let(:options) { {group_id: group.id} }
  let(:expected_result) {
    {
      group: group,
      themes: themes
    }
  }
  subject { described_class.new(options).call }

  it { is_expected.to eq(expected_result) }
end
