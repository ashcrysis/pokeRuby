class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :api_request?
  before_action :drop_session_cookie
  protect_from_forgery with: :null_session
  private

  def drop_session_cookie
    request.session_options[:skip] = true
  end

  def api_request?
    request.path.start_with?('/v2')
  end

end
