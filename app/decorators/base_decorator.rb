class BaseDecorator < SimpleDelegator
  def self.decorate(obj)
    new(obj)
  end

  def self.decorate_collection(collection)
    collection.map { |obj| new(obj) }
  end

  def decorated_class_name
    object.class.name
  end

  private

  def object
    __getobj__
  end

  def h
    @h ||= ActionController::Base.helpers
  end
end
