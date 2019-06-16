require 'rails_helper'

describe User::InterviewsController::IndexFacade do
  let(:facade) { described_class.new(user) }
  let(:user) { instance_double(User, interviews: interviews) }
  let(:interviews) { object_double(Interview.all) }

  describe '#intervews' do
    before do
      allow(interviews).to receive_messages(order: interviews)
      allow(InterviewDecorator)
        .to receive_messages(decorate_collection: :decorated_interviews)
    end

    it 'returns decorated interviews' do
      expect(facade.interviews).to eq :decorated_interviews
    end
  end
end
