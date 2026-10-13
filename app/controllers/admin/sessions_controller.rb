# frozen_string_literal: true

class Admin::SessionsController < ApplicationController
  def new
    # ログイン画面表示
  end

  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)

    if admin&.authenticate(params[:session][:password])
      log_in admin
      redirect_to admin_root_path, notice: 'ログインしました。'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています。'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to admin_login_path, notice: 'ログアウトしました。'
  end
end
