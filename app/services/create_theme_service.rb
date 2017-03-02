class CreateThemeService
  def initialize(params)
    @params = params
  end

  def call
    save_theme
    produce_result
  end

  private

  def save_theme
    @theme = Theme.new(@params)
    @theme.save
    ServiceResult.new(result: @theme, errors: @theme.errors)
  end
end
