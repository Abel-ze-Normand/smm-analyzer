module Vk
  class PostsAnalyzerService
    HASHTAG_REGEX = /(?<=#)[[^#\W][[:word:]]]+/

    def initialize(options = {})
      @posts = options.fetch(:posts_list)
      @group_id = options.fetch(:group_id)
      # domain values:
      #   :no_create - if theme not found, then do not create one
      #   :create_new - if theme not found, then new theme will be generated
      @undefined_theme_fallback = options.fetch(:undefined_theme_fallback, :no_create)
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
      post.save!
      post
    end

    def find_theme(hashtag)
      t = Theme.find_by(hashtag: hashtag, group_id: @group_id)
      return t if t

      case @undefined_theme_fallback
      when :no_create
        t
      when :create_new
        Theme.create!(name: hashtag, hashtag: hashtag)
      else
        raise :not_supported_undefined_theme_fallback
      end
    end
  end
end
