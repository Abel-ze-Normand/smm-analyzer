module Vk
  class StoreGroupsService
    def initialize(raw_groups)
      @raw_groups_list = raw_groups
    end

    def call
      store_groups_in_db
    end

    private

    def store_groups_in_db
      @raw_groups_list.map do |raw_group|
        Group.new(**parse_raw_group(raw_group)).save!
      end
    end

    def parse_raw_group(raw_group)
      {
        id: raw_group["id"],
        name: raw_group["name"],
        photo_link: raw_group["photo_200"]
      }
    end
  end
end
