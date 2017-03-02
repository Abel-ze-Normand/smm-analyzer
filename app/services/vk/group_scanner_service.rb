module Vk
  class GroupScannerService
    def initialize(options = {})
      @owner_id = options.fetch(:user_id)
      @access_token = options.fetch(:access_token)
      @vk_app = VkClient.new
    end

    def call
      vk_authorize
      groups = vk_find_groups
      parse_groups(groups)
    end

    private

    def vk_authorize
      @vk_app.authorize(access_token: @access_token)
    end

    def vk_find_groups
      @vk_app.find_groups(@owner_id)
    end

    def parse_groups(raw_groups)
      raw_groups.map do |raw_group|
        VkGroupPresenter.new(raw_group)
      end
    end
  end
end
