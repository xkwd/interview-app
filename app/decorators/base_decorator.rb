class BaseDecorator < SimpleDelegator
  def self.decorate(obj)
    new(obj)
  end

  def self.decorate_collection(collection)
    collection.map { |obj| new(obj) }
  end

  private

  def object
    __getobj__
  end
end
