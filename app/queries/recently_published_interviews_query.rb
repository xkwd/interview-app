class RecentlyPublishedInterviewsQuery
  def self.call
    Interview.where("published = ? AND published_at > ?", true, 1.month.ago)
  end
end
