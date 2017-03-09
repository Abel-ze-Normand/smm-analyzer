module Vk
  class ParsePostsService
    def initialize(options = {})
      @raw_posts = options.fetch(:posts_list)
      @group_id = options.fetch(:group_id)
    end

    def call
      @raw_posts.map do |r_p|
        GroupPost.new(**cons_group_post(r_p))
      end
    end

    private

    def cons_group_post(raw_post)
      {
        id: raw_post["id"],
        text: raw_post["text"],
        likes_count: raw_post.dig("likes", "count"),
        date: Time.at(raw_post["date"]),
        group_id: @group_id
      }
    end
  end
end
