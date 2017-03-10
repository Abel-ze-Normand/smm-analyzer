class DeleteThemeService
  def initialize(options = {})
    @theme_id = options.fetch(:theme_id)
  end

  def call
    ::Theme.find(@theme_id).destroy!
  end
end
