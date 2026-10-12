class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  private

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_admin

  def authenticate_admin!
    unless current_admin
      redirect_to admin_login_path, alert: "ログインしてください"
    end
  end
end