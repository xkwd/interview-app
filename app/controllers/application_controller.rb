class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :build_search

  private

  def build_search
    @search = Interview.published.order("created_at DESC").search(params[:q])
  end
end
