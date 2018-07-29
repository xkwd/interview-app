require 'rails_helper'

RSpec.describe RecentlyPublishedInterviewsQuery do
  let!(:interview_old) { create(:interview, published_at: 2.month.ago) }
  let!(:interview_recent) { create(:interview, published_at: 2.weeks.ago) }
  let!(:interview_unpublished) { create(:interview, published: false) }

  describe '.call' do
    it 'returns interviews published within last month' do
      expect(described_class.call).to contain_exactly(interview_recent)
    end
  end
end
