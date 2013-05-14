class ApplicationController < ActionController::Base
  protect_from_forgery

def authenticate
  authenticate_or_request_with_http_basic do |username, password|
    username == "geek" && password == "jock"
  end
end

end
