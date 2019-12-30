require 'rails_helper'

describe InterviewsController::IndexFacade do
  let(:facade) { described_class.new(params, search) }
  let(:search) { instance_double(Ransack::Search) }
  let(:params) { { page: 2 } }
  let(:found_interviews) { object_double(Interview.all) }

  describe '#interviews' do
    before do
      allow(search).to receive_messages(result: found_interviews)
      allow(found_interviews).to receive_messages(includes: interviews)
    end

    context 'with a search query' do
      let(:params) { { page: 2, q: 'search text' } }

      # rubocop:disable RSpec/VerifiedDoubles
      let(:interviews) { double(page: double(per: :interviews)) }
      # rubocop:enable RSpec/VerifiedDoubles

      it 'returns interviews' do
        expect(facade.interviews).to eq :interviews
      end
    end

    context 'without a search query' do
      # rubocop:disable RSpec/VerifiedDoubles
      let(:interviews) do
        double(page: double(per: double(padding: :interviews)))
      end
      # rubocop:enable RSpec/VerifiedDoubles

      it 'returns interviews' do
        expect(facade.interviews).to eq :interviews
      end
    end
  end

  describe '#top_interviews' do
    before do
      allow(Interview).to receive_messages(published: found_interviews)
      allow(found_interviews).to receive_messages(last: :top_interviews)
    end

    it 'returns top interviews' do
      expect(facade.top_interviews).to eq :top_interviews
    end
  end
end
