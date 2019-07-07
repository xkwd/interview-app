require 'rails_helper'

describe BaseDecorator do
  describe '.decorate' do
    before do
      allow(described_class)
        .to receive_messages(new: :decorated_object)
    end

    it 'decorates an object' do
      described_class.decorate(:object)

      expect(described_class)
        .to have_received(:new)
        .with(:object)
    end
  end

  describe '.decorate_collection' do
    before do
      allow(described_class)
        .to receive_messages(new: :decorated_object)
    end

    it 'decorates a collection' do
      described_class.decorate_collection([:object1, :object2])

      expect(described_class)
        .to have_received(:new)
        .with(:object1)
        .with(:object2)
    end
  end

  describe '#decorated_class_name' do
    let(:decorated_object) { described_class.decorate(Object.new) }

    it 'returns original class name' do
      expect(decorated_object.decorated_class_name).to eq 'Object'
    end
  end
end
