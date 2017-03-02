module Vk
  class AuthenticatorService
    def initialize(options)
      @access_token = options[:access_token]
      @user_id = options[:user_id]
      @client = VkClient.new
    end

    def call
      user = get_user()
      return user, access_token
    end

    private

    def get_user
      if user_exists?
        get_existing_user
      else
        create_user
      end
    end

    def user_exists?
      @user = User.find_by_id(@user_id)
      !@user.nil?
    end

    def get_existing_user
      @user
    end

    def create_user
      user_data = @client.get_user(@user_id)
      @user = User.new(id: user_data["id"], name: construct_name(user_data))
      @user.save!
      @user
    end

    def construct_name(user_data)
      "#{user_data['first_name']} #{user_data['last_name']}"
    end
  end
end
