class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :api_request?

  private

  def api_request?
    request.path.start_with?('/v2')
  end
end
