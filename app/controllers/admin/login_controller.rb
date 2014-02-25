# encoding: utf-8
# Admin LoginController
# Author:: Kazuko Ohmura
# Date:: 2013.07.25

# 管理画面のログイン
class Admin::LoginController < AdminController
  # ログイン画面
  def index
    # settingsの値取得
    get_settings
    if admin_current_user
      destroy
    end
  end

  # ユーザのログイン処理を行う
  def create
    user = Admin::User.find_by_mail params[:mail]

    if user && user.authenticate(params[:pass]) && user.admin
      session[:admin_user_id] = user.id
      session[:admin_servicename] = $settings['servicename']
      redirect_to admin_root_path
    else
      flash.now.alert = "Invalid"
      @errormsg = {'msg' => 'error'}
      render "index"
    end
  end

  # ユーザのログアウト処理を行う
  def destroy
    session[:admin_user_id] = nil
    session[:admin_servicename] = nil
    render "index"
  end
end
