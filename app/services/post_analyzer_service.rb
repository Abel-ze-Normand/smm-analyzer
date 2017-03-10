class PostAnalyzerService
  def initialize(options = {})
    @posts_list  = options.fetch(:posts_list)
  end

  def call
    @posts_list.each { |p| analyze(p) }
  end

  private

  def analyze(post)
    post
  end
end
