# encoding: utf-8
# UsersController
# Author:: Kazuko Ohmura
# Date:: 2013.07.31

require 'csv'

#グラフ表示
class GraphsController < PublichtmlController
  before_filter :authorize, :except => :login #ログインしていない場合はログイン画面に移動
  
  # グラフ用画面
  def index
    # グラフIDの指定が無い場合はルートへ移動
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
    term = params[:term]
    redirect_to :action => "show",:flash=>{:sday=>sday,:eday=>eday,:term=>term}
  end
  
  # csv出力処理
  def csvexport
    # 表示可能グラフチェック
    return redirect_to root_path if !check_graph_permission(params[:id]) 
    # CSVダウンロード権限チェック
    return redirect_to graph_path if check_csv_size == false

    # 指定グラフ情報
    @graph = Graph.find(params[:id])
      
    # 表示テーブル名の設定
    Tdtable.table_name = "td_" + @graph.name
    
    # 取得期間
    @start_day = params[:sday];
    @end_day = params[:eday];
    
    # データ取得
    @tdtable = Tdtable.where(:td_time => @start_day .. @end_day).order(:td_time)
    data = CSV.generate do |csv|
      csv << ["time", "value"]
      @tdtable.each do |td|
        csv << [td.td_time, td.td_count]
      end
    end
    
    # ファイル名
    fname =  @graph.name.to_s + "_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}.csv"
      
    # 出力
    send_data(data, type: 'text/csv', filename: fname)
    
    # 出力データ容量記録
    today = Date.today # 今月の日付
    key = "csv_" + today.year.to_s + today.month.to_s
    tmp = Setting.find_by_name(key)
    if tmp 
      csize = tmp.parameter.to_i + data.size
      tmp.update_attribute(:parameter,csize)
    end
  end
  
  # 表示用処理
  def show
    p "★★show★★★★★★★★★★★★★★★★★★★"
    # 表示可能グラフチェック
    return redirect_to root_path if !check_graph_permission(params[:id])
    # 引数の取得
    flash = params[:flash]
      
    # 値設定
    @h_analysis_types = {0 => t('select.analysis_types.sum'),1 => t('select.analysis_types.avg')}
    @h_yesno = {0=>'no' , 1 => 'yes'}
    
    # CSVダウンロードボタン用フラグ
    @csvflg = check_csv_size
    
    # グラフ選択枝
    @graph_types = ['line','bar']
          
    # 指定グラフ情報
    @graph = Graph.find(params[:id])
    
    # graphのnameの取得
    @gmenu = Menu.find_by_name(@graph.name)

    # 指定テンプレート情報
    @template = Graphtemplate.find_by_name(@graph.template)
    
    # 表示期間指定
    if flash 
      @graph_term = flash[:term].to_i
    elsif params[:term] 
      @graph_term = params[:term].to_i
    else
      @graph_term = @graph.term
    end
    
    # 集計テーブル更新
    update_table(@graph,@graph_term)

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

    # データの取得
    tdtable = get_table_data(@graph,@graph_term,@sday,@eday)
    # グラフ表示用データ作成
    res_graph_data = set_graph_data(tdtable,@graph_term)
    @xdata = res_graph_data['xdata']
    @ydata = res_graph_data['ydata']
    case @graph_term
      when 0 # hour
      @graphx = t("datetime.prompts.hour")
      when 1 # day
      @graphx = t("datetime.prompts.day")
      when 2 # week
      @graphx = t("datetime.prompts.day")
      else #month
      @graphx = t("datetime.prompts.month")
    end
#    @graphx = res_graph_data['graphx']
p @xdata
p @ydata
  end


  private
  # グラフが利用可能かをチェックする
  def check_graph_permission(id)
    gf = Graph.find(id)
    return Menu.exists?({:group_id=>current_user.group.id,:name=>gf.name,:menutype=>2}) 
  end
  
  # 今月のCSVダウンロード容量チェック
  def check_csv_size
    if get_csv_size.to_i > $settings['csvdownloadsize'].to_i 
      res = false
    else
      res = true
    end
    return res
  end
  
  # 今月のCSVダウンロード容量取得
  def get_csv_size
    today = Date.today # 今月の日付
    key = "csv_" + today.year.to_s + today.month.to_s
    tmp = Setting.find_by_name(key)
    if tmp 
      # レコードが存在する
      res = tmp.parameter.to_i
    else
      # レコードが存在しない➡作成
      csvrow = Setting.new
      csvrow.name = key
      csvrow.title = key
      csvrow.parameter = 0
      csvrow.vieworder = 0
      csvrow.columntype = 0
      csvrow.save
      res = 0
    end
    return res
  end
  
  
end
