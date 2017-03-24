module Vk
  class ParsePostsService
    def initialize(options = {})
      @raw_posts = options.fetch(:posts_list)
      @group_id = options.fetch(:group_id)
      @analyzer = options[:analyzer]
    end

    def call
      posts = @raw_posts.map { |r_p| GroupPost.new(**cons_group_post(r_p)) }
      posts_analyzed = analyze_posts(posts)
      posts_analyzed.map { |p| p.save! }
    end

    private

    def cons_group_post(raw_post)
      {
        id: raw_post["id"],
        text: raw_post["text"],
        likes_count: raw_post.dig("likes", "count"),
        reposts: raw_post.dig("reposts", "count"),
        date: Time.at(raw_post["date"]),
        group_id: @group_id
      }
    end

    def analyze_posts(posts)
      return posts unless @analyzer
      @analyzer.new(posts: posts, group_id: @group_id).call
    end
  end
end
