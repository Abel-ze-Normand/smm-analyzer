class ServiceResult
  attr_reader :result, :errors

  def initialize(options = {})
    @result = options[:result]
    @errors = options[:errors]
  end

  def successful?
    !@errors.present?
  end
end
