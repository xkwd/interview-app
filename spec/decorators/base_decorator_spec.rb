require 'rails_helper'

describe BaseDecorator do
  before do
    allow(described_class)
      .to receive_messages(new: :decorated_object)
  end

  describe '.decorate' do
    it 'decorates an object' do
      described_class.decorate(:object)

      expect(described_class)
        .to have_received(:new)
        .with(:object)
    end
  end

  describe '.decorate_collection' do
    it 'decorates a collection' do
      described_class.decorate_collection([:object1, :object2])

      expect(described_class)
        .to have_received(:new)
        .with(:object1)
        .with(:object2)
    end
  end
end
