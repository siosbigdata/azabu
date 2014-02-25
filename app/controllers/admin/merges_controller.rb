# encoding: utf-8
# Admin MergesController
# Author:: Kazuko Ohmura
# Date:: 2014.01.29

class Admin::MergesController < AdminController
  before_filter :admin_authorize, :except => :login #ログインしていない場合はログイン画面に移動
  before_action :set_merge, only: [:show, :edit, :update, :destroy]
  before_action :set_select, only: [:show, :edit, :update, :index,:new,:create]

  # GET /merges
  # GET /merges.json
  def index
    @admin_merges = Admin::Merge.all
  end

  # GET /merges/1
  # GET /merges/1.json
  def show
  end

  # GET /merges/new
  def new
    @admin_merge = Admin::Merge.new
  end

  # GET /merges/1/edit
  def edit
  end

  # POST /merges
  # POST /merges.json
  def create
    @admin_merge = Admin::Merge.new(merge_params)

    respond_to do |format|
      if @admin_merge.save
        format.html { redirect_to @admin_merge, notice: 'Merge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_merge }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_merge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merges/1
  # PATCH/PUT /merges/1.json
  def update
    respond_to do |format|
      if @admin_merge.update(merge_params)
        format.html { redirect_to @admin_merge, notice: 'Merge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_merge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merges/1
  # DELETE /merges/1.json
  def destroy
    @admin_merge.destroy
    respond_to do |format|
      format.html { redirect_to admin_merges_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merge
      @admin_merge = Admin::Merge.find(params[:id])
    end
    
    def set_select
      @h_terms ={0=> t('datetime.prompts.hour'),1 => t('datetime.prompts.day'),2 => t('term.week'),3 => t('datetime.prompts.month')}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merge_params
      params.require(:admin_merge).permit(:name, :title, :term)
    end
end
