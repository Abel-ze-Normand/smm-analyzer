module Vk
  class FullProcessPostsService
    def initialize(options = {})
      @group_id = options.fetch(:group_id)
      @loader = options.fetch(:loader)
      @parser = options.fetch(:parser)
      @analyzer = options[:analyzer]
      @options = options
    end

    def call
      raw_posts = load_posts
      posts = parse_posts(raw_posts)
      # posts = parse_and_save_posts(raw_posts)
      analyze(posts)
    end

    private

    def load_posts
      @loader.new(@options).call
    end

    def analyze(posts)
      return posts unless @analyzer
      @analyzer.new(posts_list: posts).call
    end

    def parse_posts(raw_posts)
      @parser.new(posts_list: raw_posts, group_id: @group_id).call
    end

    def parse_and_save_posts(raw_posts)
      posts = @parser.new(posts_list: raw_posts, group_id: @group_id).call
      ::GroupPost.transaction do
        posts.each { |p| p.save! }
      end
    end
  end
end
