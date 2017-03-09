module Vk
  class FullProcessPostsService
    def initialize(options = {})
      @group_id = options.fetch(:group_id)
      @loader = options.fetch(:loader)
      @parser = options.fetch(:parser)
      @options = options
    end

    def call
      raw_posts = load_posts
      parse_and_save_posts(raw_posts)
    end

    private

    def load_posts
      @loader.new(@options).call
    end

    def parse_and_save_posts(raw_posts)
      posts = @parser.new(posts_list: raw_posts, group_id: @group_id).call
      ::GroupPost.transaction do
        posts.each { |p| p.save! }
      end
    end
  end
end
