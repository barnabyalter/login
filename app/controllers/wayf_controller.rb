class WayfController < ApplicationController
  respond_to :html
  # Don't allow users to visit the logged_out page with GET, force a logout if that happens
  before_filter :redirect_to_logout, only: [:logged_out], if: -> { user_signed_in? }

  def index
    if cookies[:institution_from_url].present?
      institution = cookies.delete(:institution_from_url).downcase
      redirect_to login_path(institution: institution)
    end
  end

 private

  def redirect_to_logout
    redirect_to logout_path
  end

end
