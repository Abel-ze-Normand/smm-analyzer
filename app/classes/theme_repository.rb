class ThemeRepository
  def new(*args)
    ::Theme.new(*args)
  end

  def create(*args)
    theme = ::Theme.new(*args)
    theme.save
    ServiceResult.new(result: theme, errors: theme.errors)
  end

  def destroy(id)
    ::Theme.find(id).destroy!
  end

  def find(id)
    ::Theme.find(id)
  end

  def update(id, attrs = {})
    theme = ::Theme.find(id)
    theme.update_attributes(atts)
    ServiceResult.new(result: theme, errors: theme.errors)
  end
end
