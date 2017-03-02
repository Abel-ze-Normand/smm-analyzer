class VkGroupPresenter
  attr_accessor :id, :name, :is_closed, :type, :photo_link

  def initialize(options = {})
    @id = options.fetch("id")
    @name = options.fetch("name")
    @is_closed = options.fetch("is_closed")
    @type = options.fetch("type")
    @photo_link = options.fetch("photo_200")
  end
end
