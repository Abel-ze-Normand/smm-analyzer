module Vk
  class FullProcessStatsService
    def initialize(options = {})
      @loader = options.fetch(:loader)
      @parser = options.fetch(:parser)
      @analyzer = options.fetch(:analyzer)
      @options = options
    end

    def call
      raw_stats = @loader.new(@options).call
      stats = @parser.new(@options.merge(stats: raw_stats)).call
      @analyzer.new(@options.merge(stats: stats)).call
    end
  end
end
