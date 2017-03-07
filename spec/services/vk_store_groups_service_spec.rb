require "rails_helper"

RSpec.describe Vk::StoreGroupsService, "#call" do
  class MockLoader
    def initialize(options = {})
      @group_id = options[:group_id]
    end

    def call
      {
        "id" => @group_id,
        "name" => "test_group",
      }
    end
  end

  before(:all) {
    @user = create(:user)
  }
  let(:args) { { user_id: @user.id, action: :one, group_id: 1 } }
  subject { described_class.new(args.merge(groups_loader: MockLoader.new(args))) }

  it { expect(subject.call).to eq(true) }
  it "should store in database" do
    subject.call
    expect(Group.find_by_id(1)).not_to be(nil)
  end
end
