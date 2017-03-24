module Vk
  class PostsAnalyzerService
    HASHTAG_REGEX = /(?<=#)[^#\W]+/
    def initialize(options = {})
      @posts = options.fetch(:posts)
      @group_id = options.fetch(:group_id)
    end

    def call
      @posts.map do |post|
        analyze(post)
      end
    end

    private

    def analyze(post)
      hashtags = post.text.scan(HASHTAG_REGEX)
      # for now save only first
      post.theme = find_theme(hashtags.first)
      post
    end

    def find_theme(hashtag)
      Theme.find_by(hashtag: hashtag, group_id: @group_id)
    end
  end
end
