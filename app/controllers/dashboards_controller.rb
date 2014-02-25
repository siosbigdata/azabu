# encoding: utf-8
# DashboardsController
# Author:: Kazuko Ohmura
# Date:: 2013.07.31

#ダッシュボード
class DashboardsController < PublichtmlController
  before_filter :authorize, :except => :login #ログインしていない場合はログイン画面に移動

  def show
    p "★★DashboardsController:show★★★★★★★★★★★★★★★★★★★"
    # チェック
    return redirect_to root_path if !Menu.exists?({:id=>params[:id],:group_id=>current_user.group.id,:menutype=>1})
    @menu_dashboard_id = params[:id]
    @dmenu = Menu.find(params[:id])              
    # 値設定
    @h_yesno = {0=>'no' , 1 => 'yes'}
    # グラフ選択枝
    @graph_types = ['line','bar']
    # 表示期間の設定
    # 開始日付
    @sday = getStartDay
    @sdayval = @sday.strftime("%Y-%m-%d")
    
    # 終了日付
    @eday = getEndDay
    @edayval = @eday.strftime("%Y-%m-%d")
      
    @gmenu = []
    @graphs = []
    @templates = []
    @xdatas = []
    @ydatas = []
    # 子グラフの取得
    cgraphs = Menu.where(:parent_id => params[:id],:menutype=>2).order(:vieworder)
    cgraphs.each{|mg|
      @gmenu.push(mg)
      # 指定グラフ情報
      graph = Graph.find_by_name(mg.name)
      @graphs.push(graph)
      p "★★DashboardsController:show2★★★★★★★★★★★★★★★★★★★" + mg.name
      # 指定テンプレート情報
      tmpl = Graphtemplate.find_by_name(graph.template)
      @templates.push(tmpl)
      # 集計テーブル更新
      update_table(graph,graph.term)
      # データの取得
      tdtable = get_table_data(graph,graph.term,@sday,@eday)
      # グラフ表示用データ作成
      res_graph_data = set_graph_data(tdtable,graph.term)
      @xdatas.push(res_graph_data['xdata'])
      @ydatas.push(res_graph_data['ydata'])
    }
    
    
        
  end
  # ダッシュボード用
  def index
=begin
    #グラフ選択枝
    @graph_types = ['line','bar','pie']
    @h_yesno = {0=>'no' , 1 => 'yes'}
    @h_analysis_types = {0 => t('analysis_types_sum'),1 => t('analysis_types_avg')}

    # ダッシュボード情報取得
    @dashboards = Groupgraph.where(:group_id=>current_user.group.id,:dashboard => true).order(:view_rank)
    @graphs = Array.new()
    @template = Array.new()
    @xdatas = Array.new()
    @ydatas = Array.new()
    @terms = Array.new()

    @dashboards.each do |db|
      if db.graph_id > 0
        # データの取得
        graph = Graph.find(db.graph_id)

        # 指定テンプレート情報
        template = Graphtemplate.find_by_name(graph.template)

        #期間移動分
        today = Date.today

        # 期間の設定
        res_graph_terms = set_graph_term(graph.term,today,0)
        today = res_graph_terms['today']
        oldday = res_graph_terms['oldday']

        # データ取得期間の設定
        today_s = today.to_s + " 23:59:59"
        oldday_s = oldday.to_s + " 00:00:00"
        # データの取得
        tdtable = td_graph_data(graph,graph.term,oldday_s,today_s)

        # グラフ表示用データ作成
        res_graph_data = set_graph_data(tdtable,graph.term,oldday,today,res_graph_terms['stime'])

        @graphs[db.graph_id.to_i] = graph
        @template[db.graph_id.to_i] = template
        @xdatas[db.graph_id.to_i] = res_graph_data['xdata']
        @ydatas[db.graph_id.to_i] = res_graph_data['ydata']
        @terms[db.graph_id.to_i] = res_graph_terms['term_s']
      end
    end
=end
  end
end
