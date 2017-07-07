
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def configure_charsets
    response.headers["Content-Type"] = "text/html; charset=utf8mb4"
    suppress(ActiveRecord::StatementInvalid) do
      ActiveRecord::Base.connection.execute 'SET NAMES UTF8MB4'
    end
  end

  def dashboard
  end

  include SessionsHelper

end
