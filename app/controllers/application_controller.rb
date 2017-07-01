class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_cache

  private

  def set_cache
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
  end
end
