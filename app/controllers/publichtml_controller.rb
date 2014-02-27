# coding: utf-8
# PublichtmlController
# Author:: Kazuko Ohmura
# Date:: 2013.08.02

# グラフ表示用共通コントローラー
class PublichtmlController < ApplicationController
  # 通常ユーザ用-現在のアカウント設定
  def current_user
    if session[:user_id] && $settings && session[:servicename] == $settings['servicename']
      @current_user ||= User.find(session[:user_id])
    end
  end
  helper_method :current_user

  # ログインチェック
  def authorize
    unless current_user
      flash[:notice] = t('login.notice')
      session[:jumpto] = request.parameters
      redirect_to login_index_path
    end
  end

  #graphメニュー作成
  def current_menu
    if current_user
      mroot = Menu.where(:group_id=>current_user.group.id,:parent_id => 0).order(:vieworder)
      @current_menu = Array::new
      mroot.each{|rr|
        @current_menu.push(rr)
        res = search_child(rr.id)
        @current_menu.concat(res)
      }
      return @current_menu
    end
  end
  helper_method :current_menu

  def search_child(pid)
    mchild = Menu.where(:group_id=>current_user.group.id,:parent_id => pid).order(:vieworder)
    p mchild.size
    ary = Array::new
    mchild.each{|mm|
      ary.push(mm)
      res = search_child(mm.id)
      if res.size > 0
        ary.concat(res)
      end
    }
    return ary
  end
end