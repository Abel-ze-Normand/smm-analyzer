module Vk
  class StoreGroupsService
    def initialize(options = {})
      @options = options
      @user_id = options.fetch(:user_id)
      @action = options.fetch(:action)
      @groups_loader = options.fetch(:groups_loader)
    end

    def call
      @raw_data = load_groups
      store_groups_in_db
    end

    private

    def load_groups
      @groups_loader.new(@options).call
    end

    def store_groups_in_db
      case @action
      when :one
        store_one_group
      when :many
        store_many_groups
      end
    end

    def store_one_group
      Group.new(**parse_raw_group(@raw_data)).save!
    end

    def store_many_groups
      @raw_data.map do |raw_group|
        Group.new(**parse_raw_group(raw_group)).save!
      end
    end

    def parse_raw_group(raw_group)
      {
        id: raw_group["id"],
        name: raw_group["name"],
        photo_link: raw_group["photo_200"],
        user_id: @user_id
      }
    end
  end
end
