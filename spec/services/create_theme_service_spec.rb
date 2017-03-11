require "rails_helper"

RSpec.describe CreateThemeService do
  let(:group) { create(:group) }
  let(:valid_params) {
    {
      id: nil,
      name: "test",
      group_id: group.id,
      hashtag: "hashtag"
    }
  }
  let(:invalid_params) {
    {
      id: nil,
      name: "test",
    }
  }

  subject { ->(p) { described_class.new(p).call } }
  it { expect(subject.call(invalid_params)).to satisfy { |result_obj| not result_obj.successful? } }
  it { expect(subject.call(valid_params)).to satisfy { |result_obj| result_obj.successful? } }
end
