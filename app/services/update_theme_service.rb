class UpdateThemeService
  def initialize(options = {})
    @theme_data = options
  end

  def call
    @theme = Theme.find(@theme_data[:id])
    @theme.update_attributes(@theme_data)
    ServiceResult.new(result: @theme, errors: @theme.errors)
  end
end
