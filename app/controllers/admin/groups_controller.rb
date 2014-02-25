# encoding: utf-8
# GroupsController
# Author:: Kazuko Ohmura
# Date:: 2013.07.25

# グループ管理用クラス
class Admin::GroupsController < AdminController
  before_filter :admin_authorize, :except => :login #ログインしていない場合はログイン画面に移動
  before_action :set_admin_group, only: [:show, :edit, :update, :destroy]

  # グループ一覧画面
  def index
    @admin_groups = Admin::Group.all.order(:id)
    @maxuser = get_maxuser

    #削除ボタンの表示制御--ユーザーが存在するグループの削除不可
    @delete_hash = Hash::new
    @admin_groups.each do |gg|
      users = Admin::User.where(:group_id=>gg.id).exists?;
      @delete_hash[gg.id] = users
    end
  end

  # グループ詳細画面
  def show
  end

  # グループ新規追加画面
  def new
    admin_groups = Admin::Group.all
    if admin_groups.length < get_maxuser
      @admin_group = Admin::Group.new
    else
      redirect_to admin_groups_url
    end
  end

  # グループ編集画面
  def edit
  end

  # グループ新規作成
  def create
    @admin_group = Admin::Group.new(admin_group_params)

    respond_to do |format|
      if @admin_group.save
        format.html { redirect_to @admin_group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # グループ更新
  def update
    respond_to do |format|
      if @admin_group.update(admin_group_params)
        format.html { redirect_to @admin_group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # グループ削除
  def destroy
    # 削除前に関連するテーブルの削除を行う
    #Admin::Groupgraph.delete_all(:group_id => @admin_group.id)     #グループ-グラフ

    @admin_group.destroy
    respond_to do |format|
      format.html { redirect_to admin_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_group
      @admin_group = Admin::Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_group_params
      params.require(:admin_group).permit(:name, :title)
    end
end
