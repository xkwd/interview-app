class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :build_search

  helper_method :current_or_guest_user

  def current_or_guest_user
    current_user || guest_user
  end

  private

  def build_search
    @search = Interview.published.order("created_at DESC").ransack(params[:q])
  end

  def guest_user
    @guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  end

  def create_guest_user
    guest_user = User.new(name: "guest", email: "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    guest_user.save!(validate: false)
    session[:guest_user_id] = guest_user.id
    guest_user
  end
end
