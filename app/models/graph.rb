# encoding: utf-8
# Graph Model
# Author:: Kazuko Ohmura
# Date:: 2013.07.25

# グラフモデル
# == 作成
# rails generate model graph name:string title:string graph_type:integer term:integer
#                             y:string  y_min:integer
#                             analysis_type:integer useval:interger usetip:integer
#                             linewidth:integer template:string
#                             y_unit:string 
# == 注意
# nameはTreasureData用データモデルのテーブル名とそろえる
class Graph < ActiveRecord::Base
  # グラフ用定数
  HOUR = 0
  DAY = 1
  WEEK = 2
  MONTH = 3
  
  # ----------------------------------------------------------- #
  # クラスメソッド
  class << self
    # ----------------------------------------------------------- #
    # テーブル名取得
    def get_td_tablename(name)
      return "td_" + name
    end
    # ----------------------------------------------------------- #
    # データの取得
    def get_table_data(graph,term,psday,peday)
      sday = psday.strftime("%Y-%m-%d 00:00:00")
      eday = peday.strftime("%Y-%m-%d 23:59:59")
      case term
      when 0 # hour
        td_name = "td_hour_"
        eday = psday.strftime("%Y-%m-%d 23:59:59")
      when 1 # day
        td_name = "td_day_"
      when 2 # week
        td_name = "td_week_"
      else # month
        td_name = "td_month_"
        sday = psday.strftime("%Y-%m-01 00:00:00")
        tmp1 = peday + 1.month
        tmp2 = tmp1.strftime("%Y-%m-01 00:00:00")
        tmp3 = DateTime.strptime(tmp2, "%Y-%m-%d %H:%M:%S") - 1.day
        eday = tmp3.strftime("%Y-%m-%d 23:59:59")
      end
      td_name << graph.name
      # テーブル名の設定
      Tdtable.table_name = td_name
      # データの取得
      tdtable = Tdtable.where("td_time >= ? and td_time <= ?",sday,eday).where(:analysis_type=>graph.analysis_type).order(:td_time)
      return tdtable
    end
    # ----------------------------------------------------------- #
    # グラフ表示用データ作成
    def set_graph_data(tdtable,graph_term)
      xdata = []
      ydata = []
      cnt   = 0
      tdtable.each{|row|
        date = DateTime.strptime(row.td_time.to_s, "%Y-%m-%d %H:%M:%S")
        case graph_term
        when 0 # hour
          xdata.push(date.strftime("%H").to_s)
        when 1 # day
          xdata.push(date.strftime("%d").to_s)
        when 2 # week
          xdata.push(date.strftime("%m/%d").to_s)
        else #month
          xdata.push(date.strftime("%m").to_s)
        end
        ydata.push(row.td_count.to_i.to_s)
        
      }
  
      # 戻り値の作成
      res = Hash.new
      res['xdata'] = xdata
      res['ydata'] = ydata
      return res
    end
    # ----------------------------------------------------------- #
    # 表示期間の取得
    def getStartDay # 開始日
      startday = $settings['base_start']
      if startday then
        res = Date.parse(startday)
      else
        # パラメーターが存在しない場合は今月の月初
        today = Date.today
        res = Date::new(today.year,today.month, 1)
      end
      return res
    end
    # ----------------------------------------------------------- #
    def getEndDay # 終了日
      endday = $settings['base_end']
      if endday then
        res = Date.parse(endday)
      else
        # パラメーターが存在しない場合は今月の月末
        today = Date.today + 1.month
        res = Date::new(today.year,today.month, 1) - 1.day
      end
      return res
    end
    # ----------------------------------------------------------- #
    # 時間別テーブルの更新
    def update_hour_table(graph,update_days)
      p "★★update_hour_table★★★★★★★★★★★★★★★★"
      td_name = "td_hour_"  
      td_name << graph.name
      
      # テーブル名の設定
      Tdtable.table_name = get_td_tablename(graph.name)
      
      # データの最小日と最大日の取得
      if update_days > 0
        eday = Date.today
        sday = Date.today - update_days.days
      else
        minrow = Tdtable.select("min(td_time) as td_time")
        sday = Date.parse(minrow[0].td_time.to_s)
        maxrow = Tdtable.select("max(td_time) as td_time")
        eday = Date.parse(maxrow[0].td_time.to_s)
      end
      
      # データの集計
      tday = sday
      tdtable = []
      while tday < eday
        # データの集計
        if graph.analysis_type == 0  # 合計
          tt = Tdtable.where("td_time >= ? and td_time < ?",tday.strftime("%Y-%m-%d %H:00:00"),(tday + 1.hour).strftime("%Y-%m-%d %H:00:00")).select("sum(td_count) as td_count")
        else # 平均
          tt = Tdtable.where("td_time >= ? and td_time < ?",tday.strftime("%Y-%m-%d %H:00:00"),(tday + 1.hour).strftime("%Y-%m-%d %H:00:00")).select("avg(td_count) as td_count")
        end
        tmp = Tdtable.new
        tmp.td_time = tday
        if tt[0].td_count.to_i.is_a?(Integer)
          tmp.td_count = tt[0].td_count
        else
          tmp.td_count = 0
        end
        tdtable.push(tmp)
        tday += 1.hour
      end
  
      # データ更新
      table_data_update(graph,td_name,tdtable,0)
    end
    # ----------------------------------------------------------- #
    # 日別テーブルの更新
    def update_day_table(graph,update_days)
      p "★★update_day_table★★★★★★★★★★★★★★★★"
      td_name = "td_day_"  
      td_name << graph.name
      
      # テーブル名の設定
      Tdtable.table_name = get_td_tablename(graph.name)
      
      # データの最小日と最大日の取得
      if update_days > 0
        eday = Date.today
        sday = Date.today - update_days.days
      else
        minrow = Tdtable.select("min(td_time) as td_time")
        sday = Date.parse(minrow[0].td_time.to_s)
        maxrow = Tdtable.select("max(td_time) as td_time")
        eday = Date.parse(maxrow[0].td_time.to_s)
      end
      # データの集計
      tday = sday
      tdtable = []
      while tday < eday
        # データの集計
        if graph.analysis_type == 0  # 合計
          tt = Tdtable.where("td_time >= ? and td_time < ?",tday.strftime("%Y-%m-%d 00:00:00"),(tday + 1.day).strftime("%Y-%m-%d 00:00:00")).select("sum(td_count) as td_count")
        else # 平均
          tt = Tdtable.where("td_time >= ? and td_time < ?",tday.strftime("%Y-%m-%d 00:00:00"),(tday + 1.day).strftime("%Y-%m-%d 00:00:00")).select("avg(td_count) as td_count")
        end
        tmp = Tdtable.new
        tmp.td_time = tday
        if tt[0].td_count.to_i.is_a?(Integer)
          tmp.td_count = tt[0].td_count
        else
          tmp.td_count = 0
        end
        tdtable.push(tmp)
        tday += 1.day
      end
  
      # データ更新
      table_data_update(graph,td_name,tdtable,1)
    end
    # ----------------------------------------------------------- #
    # 週別テーブルの更新
    def update_week_table(graph,update_days)
      p "★★update_week_table★★★★★★★★★★★★★★★★"
      td_name = "td_week_"  
      td_name << graph.name
      
      # テーブル名の設定
      Tdtable.table_name = get_td_tablename(graph.name)
      
      # データの最小日と最大日の取得
      if update_days > 0
        sday = Date.today
        eday = (Date.today - (update_days*7).days)
      else
        minrow = Tdtable.select("min(td_time) as td_time")
        maxrow = Tdtable.select("max(td_time) as td_time")
        sday = Date.parse(minrow[0].td_time.to_s)
        eday = Date.parse(maxrow[0].td_time.to_s)
      end
      
      if sday.wday < $settings['week_startday'].to_i
        sday = sday - (7 - $settings['week_startday'].to_i + sday.wday).day
      elsif sday.wday > $settings['week_startday'].to_i
        sday = sday - (sday.wday - $settings['week_startday'].to_i).day
      end
      
      
      tday = sday
      tdtable = []
      while tday < eday
        # データの集計
        if graph.analysis_type == 0  # 合計
          tt = Tdtable.where("td_time >= ? and td_time < ?",tday,(tday + 7.days)).select("sum(td_count) as td_count")
        else # 平均
          tt = Tdtable.where("td_time >= ? and td_time < ?",tday,(tday + 7.days)).select("avg(td_count) as td_count")
        end
        tmp = Tdtable.new
        tmp.td_time = tday
        if tt[0].td_count.to_i.is_a?(Integer)
          tmp.td_count = tt[0].td_count
        else
          tmp.td_count = 0
        end
        tdtable.push(tmp)
        tday += 7.days
      end
      
      # データ更新
      table_data_update(graph,td_name,tdtable,2)
    end
    # ----------------------------------------------------------- #
    # 月別テーブルの更新
    def update_month_table(graph,update_days)
      p "★★update_month_table★★★★★★★★★★★★★★★★"
      td_name = "td_month_"  
      td_name << graph.name
      
      # テーブル名の設定
      Tdtable.table_name = get_td_tablename(graph.name)
      
      # データの最小日と最大日の取得
      if update_days > 0
        eday = Date.new(Date.today.year,Date.today.month,-1)
        sday = Date.new((Date.today - update_days.days).year,(Date.today - update_days.days).month,1)
      else
        minrow = Tdtable.select("min(td_time) as td_time")
        maxrow = Tdtable.select("max(td_time) as td_time")
        tmp = Date.parse(minrow[0].td_time.to_s)
        sday = Date.new(tmp.year,tmp.month,1)
        tmp = Date.parse(maxrow[0].td_time.to_s)
        eday = Date.new(tmp.year,tmp.month,-1)
      end
      
      # データの集計
      tday = sday
      tdtable = []
      while tday < eday
        # データの集計
        if graph.analysis_type == 0  # 合計
          tt = Tdtable.where("td_time >= ? and td_time < ?",tday,(tday + 1.month)).select("sum(td_count) as td_count")
        else # 平均
          tt = Tdtable.where("td_time >= ? and td_time < ?",tday,(tday + 1.month)).select("avg(td_count) as td_count")
        end
        tmp = Tdtable.new
        tmp.td_time = tday
        if tt[0].td_count.to_i.is_a?(Integer)
          tmp.td_count = tt[0].td_count
        else
          tmp.td_count = 0
        end
        tdtable.push(tmp)
        tday += 1.month
      end
      
      # データ更新
      table_data_update(graph,td_name,tdtable,3)
    end
    # ----------------------------------------------------------- #
    # データの更新
    def table_data_update(graph,td_name,tdtable,term)
      p "★★table_data_update★★★★★★★★★★★★★★★★"
      # データの更新
      Tdtable.table_name = td_name
      tdtable.each{|row|
        tt = Tdtable.where(:analysis_type=>graph.analysis_type,:td_time=>row.td_time)
        if tt.size > 0
          tt[0].update_attribute(:td_count,row.td_count)
        else
          newrow = Tdtable.new
          newrow.td_time = row.td_time
          newrow.td_count = row.td_count
          newrow.analysis_type = graph.analysis_type
          newrow.save
        end
      }
      
      # 更新設定
      tu = Tableupdate.where(:graph_id=>graph.id,:term=>term,:analysis_type=>graph.analysis_type)
      if tu.size > 0
        tu[0].update_attribute(:cal_at,Date.today)
      else
        tu = Tableupdate.new
        tu.graph_id = graph.id
        tu.name = graph.name
        tu.term = term
        tu.analysis_type = graph.analysis_type
        tu.cal_at = Date.today
        tu.save
      end
    end
    # ----------------------------------------------------------- #
    # 集計テーブルの更新
    def update_table(graph,term)
      p "★★update_table★★★★★★★★★★★★★★★★"
      # 更新日のチェック
      tu = Tableupdate.where(:graph_id=>graph.id,:term=>term,:analysis_type=>graph.analysis_type)
      ud = $settings['update_days']
      if ud
        update_days = ud.to_i
      else
        update_days = 1
      end
      if tu.size == 0 || tu[0].cal_at.to_s < Date.today.to_s
        update_days = -1 if tu.size == 0
        # 更新
        case term
        when 0
          update_hour_table(graph,update_days)
        when 1
          update_day_table(graph,update_days)
        when 2
          update_week_table(graph,update_days)
        else
          update_month_table(graph,update_days)
        end
      end
    end
  end
end
