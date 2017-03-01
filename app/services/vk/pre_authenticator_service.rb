module Vk
  class PreAuthenticatorService
    def initialize
      @client = VkClient.new
    end

    def call
      @client.auth_url
    end
  end
end
