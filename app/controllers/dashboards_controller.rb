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
  end
end
