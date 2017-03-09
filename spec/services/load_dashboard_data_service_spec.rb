require 'rails_helper'

RSpec.describe LoadDashboardDataService, "#call" do
  before(:all) do
    @group1 = create(:group)
    @group2 = create(:group)
    @user = create(:user, groups: [@group1, @group2])
  end

  subject { described_class.new(user: @user, entries: [:groups]).call }

  let(:expected_responce) do
    {
      groups: [@group1, @group2],
    }
  end

  # assertions
  it { is_expected.to eq(expected_responce)}
end
