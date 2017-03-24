class StartPopularThemesAnalyzerService
  def initialize(options = {})
    @options = options
  end

  def call
    Resque.enqueue(PopularThemesJob, @options)
  end
end
