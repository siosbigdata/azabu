# encoding: utf-8
# UsersController
# Author:: Kazuko Ohmura
# Date:: 2014.02.24

class MergesController < PublichtmlController
  before_filter :authorize, :except => :login #ログインしていない場合はログイン画面に移動

  # マージ用画面
    def index
      # マージIDの指定が無い場合はルートへ移動
      redirect_to root_path
    end
    
  def setday
    begin
      sday = Date.parse(params[:sday])
      eday = Date.parse(params[:eday])
    rescue => e
      # 引数付と認められなかった場合は空白
      sday = ""
      eday = ""
    end
    p "★★setday★★★★★★★★★★★★★★★★★★★"
    p sday
    p eday
    term = params[:term]
    redirect_to :action => "show",:flash=>{:sday=>sday,:eday=>eday,:term=>term}
  end
  
  # マージ表示
  def show
  p "★★merge:show★★★★★★★★★★★★★★★★★★★"
  # 表示可能グラフチェック
  return redirect_to root_path if !check_merge_permission(params[:id])
  
  # 引数の取得
  flash = params[:flash]
    
  # 値設定
  @h_analysis_types = {0 => t('select.analysis_types.sum'),1 => t('select.analysis_types.avg')}
#@h_terms ={0=> t('datetime.prompts.day'),1 => t('week'),2 => t('datetime.prompts.month'),3 => t('datetime.prompts.year')}
  @h_yesno = {0=>'no' , 1 => 'yes'}
  
  # グラフ選択枝
  @graph_types = ['line','bar']
  # マージ情報
  @merge = Merge.find(params[:id])
        
  # 指定グラフ情報
  @graph = Graph.find(params[:id])
  
  # graphのnameの取得
  @gmenu = Menu.find_by_name(@merge.name)
  
  # 表示期間指定
  if flash 
    @merge_term = flash[:term].to_i
  elsif params[:term] 
    @merge_term = params[:term].to_i
  else
    @merge_term = @merge.term
  end
  
  # マージグラフ取得
  mergegraphs = Mergegraph.where(:merge_id => @merge.id).order(:side,:vieworder)

  @graphsL = []
  @graphsR = []
  @template = ""
    
  # 集計テーブル更新
  mergegraphs.each_with_index{|mg,i|
    graph = Graph.find(mg.graph_id)
    update_table(graph,@merge_term)
    
    if mg.side === 0
      @graphsL.push(graph)
    else
      @graphsR.push(graph)
    end
    if i === 0
      @template = Graphtemplate.find_by_name(graph.template)
    end
  }
  # 表示期間の設定
  @sdayval = ""  # 開始日付
  @edayval = ""  # 終了日付
  # 開始日付
  if flash && flash[:sday].to_s.length > 0 then
    @sday = Date.parse(flash[:sday].to_s)
  elsif params[:sday] then
    @sday = Date.parse(params[:sday].to_s)
  else
    @sday = getStartDay
  end
  @sdayval = @sday.strftime("%Y-%m-%d")
  
  # 終了日付
  if flash && flash[:eday].to_s.length > 0 then
    @eday = Date.parse(flash[:eday].to_s)
  elsif params[:eday] then
    @eday = Date.parse(params[:eday].to_s)
  else
    @eday = getEndDay
  end
  @edayval = @eday.strftime("%Y-%m-%d")
  
  # データの取得と成形
  xdata = []
  @ydataL = []
  @ydataR = []
  # 左側グラフ
  @graphsL.each{|gl|
    # データの取得
    tdtable = get_table_data(gl,@merge_term,@sday,@eday)
    # グラフ表示用データ作成
    res_graph_data = set_graph_data(tdtable,@merge_term)
    
    xdata.push(res_graph_data['xdata'])
    @ydataL.push(res_graph_data['ydata'])
  }
  @graphsR.each{|gl|
    # データの取得
    tdtable = get_table_data(gl,@merge_term,@sday,@eday)
    # グラフ表示用データ作成
    res_graph_data = set_graph_data(tdtable,@merge_term)
    
    xdata.push(res_graph_data['xdata'])
    @ydataR.push(res_graph_data['ydata'])
  }

  @xdata = xdata[0]
  # データの取得
#  tdtable = get_table_data(@graph,@merge_term,@sday,@eday)
  # グラフ表示用データ作成
#  res_graph_data = set_graph_data(tdtable,@merge_term)
#  @xdata = res_graph_data['xdata']
#  @ydata = res_graph_data['ydata']
#  @graphx = res_graph_data['graphx']
#p @xdata
#p @ydata
    case @merge_term
      when 0 # hour
      @graphx = t("datetime.prompts.hour")
      when 1 # day
      @graphx = t("datetime.prompts.day")
      when 2 # week
      @graphx = t("datetime.prompts.day")
      else #month
      @graphx = t("datetime.prompts.month")
    end
end



  private
# マージが利用可能かをチェックする
  def check_merge_permission(id)
    mf = Merge.find(id)
    return Menu.exists?({:group_id=>current_user.group.id,:name=>mf.name,:menutype=>3}) 
  end
end
