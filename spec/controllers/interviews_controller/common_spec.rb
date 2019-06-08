require 'rails_helper'

describe InterviewsController::Common do
  let(:object) { Object.new }

  before do
    object.extend(described_class)
    allow(Country).to receive_messages(pluck: [[:name, :id], [:name, :id]])
  end

  describe '#countries' do
    it 'returns countries for a select' do
      expect(object.countries).to eq [[:name, :id], [:name, :id]]
    end

    it 'memoizes countries' do
      2.times { object.countries }

      expect(Country).to have_received(:pluck).once
    end
  end
end
