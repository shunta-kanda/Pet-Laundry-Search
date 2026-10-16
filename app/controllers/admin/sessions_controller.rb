# frozen_string_literal: true

class Admin::SessionsController < ApplicationController
  def new
    # ログイン画面表示
  end

  def create
    admin = Admin.find_by(email: params[:email]&.downcase)

    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_root_path, notice: 'ログインしました。'
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています。'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_id] = nil 
    redirect_to admin_login_path, notice: 'ログアウトしました。'
  end
end
