# frozen_string_literal: true

module Admin
  class SessionsController < ApplicationController
    def new; end

    def create
      admin = Admin.find_by(email: params[:session][:email].downcase)
      if admin&.authenticate(params[:session][:password])
        session[:admin_id] = admin.id
        redirect_to admin_root_path, notice: 'ログインしました' # 適宜リダイレクト先を変更してください
      else
        flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています'
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session[:admin_id] = nil
      redirect_to admin_login_path, notice: 'ログアウトしました'
    end
  end
end
