# encoding: utf-8
# Admin MenusController
# Author:: Kazuko Ohmura
# Date:: 2014.01.29

class Admin::MenusController < AdminController
  before_filter :admin_authorize, :except => :login #ログインしていない場合はログイン画面に移動
  before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :set_select, only: [:show, :edit, :list, :new,:create,:update]

  # 一覧表示
  def list
    group_id = params[:id].to_i
    if Admin::Group.exists?(group_id)
      @group = Admin::Group.find(group_id)
      @admin_menus = Admin::Menu.where(:group_id => group_id).order(:parent_id,:vieworder)
      @parent_menu = parent_menu(0)
    else
      redirect_to admin_groups_url
    end
  end

  # 詳細表示
  def show
    @parent_menu = parent_menu(0)
  end

  # 新規追加
  def new
    group_id = params[:group_id].to_i

    if Admin::Group.exists?(group_id)
      @group = Admin::Group.find(group_id)
      @admin_menu = Admin::Menu.new
      @parent_menu = parent_menu(0)
    else
      redirect_to admin_groups_url
    end
  end

  # GET /menus/1/edit
  def edit
    @parent_menu = parent_menu(@admin_menu.id)
  end

  # POST /menus
  # POST /menus.json
  def create
    @admin_menu = Admin::Menu.new(menu_params)

    respond_to do |format|
      if @admin_menu.save
        format.html { redirect_to @admin_menu, notice: 'Menu was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_menu }
      else
        @group = Admin::Group.find(@admin_menu.group_id)
        @parent_menu = parent_menu(0)
        format.html { render action: 'new' }
        format.json { render json: @admin_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @admin_menu.update(menu_params)
        format.html { redirect_to @admin_menu, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        @group = Admin::Group.find(@admin_menu.group_id)
        @parent_menu = parent_menu(@admin_menu.id)
        format.html { render action: 'edit' }
        format.json { render json: @admin_menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @admin_menu.destroy
    respond_to do |format|
      format.html { redirect_to admin_menus_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @admin_menu = Admin::Menu.find(params[:id])
      group_id = @admin_menu.group_id
      @group = Admin::Group.find(group_id)
    end

    def set_select
#      @select_level = {0 => t("admin.menu.level.root"),1=>t("admin.menu.level.level1"),2=>t("admin.menu.level.level2")}
      @select_type = {0 => t("admin.menu.type.label"),1 => t("admin.menu.type.dashboard"),2 => t("admin.menu.type.graph"),3 => t("admin.menu.type.merge")}
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:admin_menu).permit(:group_id, :parent_id, :child_id, :name, :title, :vieworder, :icon, :menutype)
    end
    
    def parent_menu(id)
      if id > 0
        p_menu = Admin::Menu.where("menutype <= 1 and id != ?",id).order(:vieworder)
      else
        p_menu = Admin::Menu.where("menutype <= 1").order(:vieworder)
      end
      res = Hash::new
      res[0] = t("admin.menu.parent.none")
      p_menu.each{|mm|
        res[mm.id] = mm.title
      }
      return res
    end
end
