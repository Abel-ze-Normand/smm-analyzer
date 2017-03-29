module ApplicationRepository
  extend Forwardable
  def_delegators :@@entity, *methods

  class << self
    def entity(cls)
      raise Exception.new("entity must be class") if cls.class != Class
      @@entity = cls
    end

    def blank_new(*args)
      @@entity.new(*args)
    end

    def save(model)
      if model.id
        update model
      else
        create model
      end
    end

    def create(model)
    end
  end
end
