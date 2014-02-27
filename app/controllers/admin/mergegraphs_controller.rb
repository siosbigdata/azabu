# coding: utf-8
# Admin MergegraphsController
# Author:: Kazuko Ohmura
# Date:: 2014.01.29

class Admin::MergegraphsController < AdminController
  before_filter :admin_authorize, :except => :login #ログインしていない場合はログイン画面に移動
  before_action :set_mergegraph, only: [:show, :edit, :update]
  
  # 一覧表示
    def list
      merge_id = params[:id].to_i
      if Admin::Merge.exists?(merge_id)
        @merge = Admin::Merge.find(merge_id)
        @mergegraphs = Admin::Mergegraph.where(:merge_id => merge_id).order(:side,:vieworder)
      else
        redirect_to admin_merges_url
      end
    end

  # GET /mergegraphs/1
  # GET /mergegraphs/1.json
  def show
  end

  # GET /mergegraphs/new
  def new
    merge_id = params[:merge_id].to_i
        if Admin::Merge.exists?(merge_id)
          @merge = Admin::Merge.find(merge_id)
          @mergegraph = Admin::Mergegraph.new
        else
          redirect_to admin_merges_url
        end
  end

  # GET /mergegraphs/1/edit
  def edit
  end

  # POST /mergegraphs
  # POST /mergegraphs.json
  def create
    @mergegraph = Admin::Mergegraph.new(mergegraph_params)

    respond_to do |format|
      if @mergegraph.save
        format.html { redirect_to @mergegraph, notice: 'Mergegraph was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mergegraph }
      else
        @merge = Admin::Merge.find(@mergegraph.merge_id)
        format.html { render action: 'new' }
        format.json { render json: @mergegraph.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mergegraphs/1
  # PATCH/PUT /mergegraphs/1.json
  def update
    respond_to do |format|
      if @mergegraph.update(mergegraph_params)
        format.html { redirect_to @mergegraph, notice: 'Mergegraph was successfully updated.' }
        format.json { head :no_content }
      else
        @merge = Admin::Merge.find(@mergegraph.merge_id)
        format.html { render action: 'edit' }
        format.json { render json: @mergegraph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mergegraphs/1
  # DELETE /mergegraphs/1.json
  def destroy
    @mergegraph.destroy
    respond_to do |format|
      format.html { redirect_to admin_mergegraph_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mergegraph
      @mergegraph = Admin::Mergegraph.find(params[:id])
      merge_id = @mergegraph.merge_id
      @merge = Admin::Merge.find(merge_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mergegraph_params
      params.require(:admin_mergegraph).permit(:merge_id, :graph_id, :side, :y, :vieworder)
    end
end
