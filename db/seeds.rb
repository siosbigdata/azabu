#coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 管理者追加
User.create!(
  :name => "admin",
  :password => "admin",
  :password_confirmation => "admin",
  :title=>'管理者',
  :mail=>'admin@admin.com',
  :group_id=> 1,:admin=>true)

# 一般ユーザー追加
User.create!(
  :name => "user",
  :password => "user",
  :password_confirmation => "user",
  :title=>'一般ユーザー',
  :mail=>'user@user.com',
  :group_id=> 2,:admin=>false)

# 管理グループの追加
Group.create(:name => "admingroup", :title => "管理グループ")

# 一般グループの追加
Group.create(:name => "usergroup", :title => "一般グループ")

# 管理者メールアドレス
Setting.create(:name  => "admin_mail",  :title  =>  "管理者：メール", :parameter => "admin@sios.com",:vieworder => 1,:columntype => 0)

# アプリケーションタイトル（セッション管理に利用するので一意な名前を指定する。）
Setting.create(:name => "title" ,:title => "アプリケーションタイトル",:parameter => "OSS-DashBoard" ,:vieworder => 2,:columntype => 0)

# ダッシュボードに横に並べるグラフの数
Setting.create(:name => "dashboardnum" ,:title => "ダッシュボードに並べるグラフ数",:parameter => "3" ,:vieworder => 10,:columntype => 3)

# 同時ログインユーザー数
Setting.create(:name => "sessionnum" ,:title => "同時ログイン数",:parameter => "3" ,:vieworder => 0,:columntype => 3)

# 一意なservicenameを指定（管理画面で変更可能）
Setting.create(:name => "servicename" ,:title => "サービス名",:parameter => "sitename" ,:vieworder => 0,:columntype => 0)

# CSVのダウンロード容量（最大数を超えるとCSVダウンロードボタンが非表示）
Setting.create(:name => "csvdownloadsize" ,:title => "最大CSVダウンロード容量",:parameter => "32212254720" ,:vieworder => 0,:columntype => 3) # 上限30GB

# 登録可能ユーザー数
Setting.create(:name => "maxuser" ,:title => "最大ユーザ数",:parameter => "5" ,:vieworder => 0,:columntype => 3) #上限5

# グラフのマーカーの種類 "css-ring"か"css-maru"を選択
Setting.create(:name => "useMarker" ,:title => "マーカーの種類",:parameter => "css-ring" ,:vieworder => 0,:columntype => 0)

# マーカーの大きさ
Setting.create(:name => "markerWidth" ,:title => "マーカーの大きさ",:parameter => "1" ,:vieworder => 10,:columntype => 3)

# グラフの横幅（管理画面で変更可能）
Setting.create(:name => "graph_width" ,:title => "グラフの横",:parameter => "720" ,:vieworder => 3,:columntype => 3) # 720

# グラフの縦（管理画面で変更可能）
Setting.create(:name => "graph_height" ,:title => "グラフの縦",:parameter => "480" ,:vieworder => 4,:columntype => 3) # 480

# グラフの新規追加機能を利用できるかどうか
Setting.create(:name => "use_create_graph" ,:title => "グラフの新規追加機能の利用",:parameter => "1" ,:vieworder => 0,:columntype => 1) # 初期値：利用可

# 初期表示時点での表示期間の開始日
# todayを指定すると特別にシステムから１ヶ月前、それ以外はyyyy-mm-dd表示
Setting.create(:name => "base_start" ,:title => "基準開始日",:parameter => "2014-01-01" ,:vieworder => 90,:columntype => 4)

# 初期表示時点での表示期間の終了日
# todayを指定すると特別にシステム当日、それ以外はyyyy-mm-dd表示
Setting.create(:name => "base_end" ,:title => "基準終了日",:parameter => "2014-06-30" ,:vieworder => 91,:columntype => 4)

# 初期表示時点での表示期間
Setting.create(:name => "base_term" ,:title => "基準期間",:parameter => "2" ,:vieworder => 92,:columntype => 1) # termの値を指定

# 週の開始曜日
# 週の値0〜6で表す
Setting.create(:name => "week_startday" ,:title => "週の開始曜日",:parameter => "1" ,:vieworder => 93,:columntype => 1)
# データ更新間隔(日)
Setting.create(:name => "update_days" ,:title => "データの更新間隔(日数)",:parameter => "1" ,:vieworder => 0,:columntype => 0)

# 以下グラフテンプレート
Graphtemplate.create(:name=>'aliceblue-black',:linecolor => "#000000",:bgfrom => "#f0f8ff",:bgto => "#f0f8ff",:textcolor => "#000000",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b" )
Graphtemplate.create(:name=>'aliceblue-dimgray',:linecolor => "#696969",:bgfrom => "#f0f8ff",:bgto => "#f0f8ff",:textcolor => "#696969",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b" )
Graphtemplate.create(:name=>'black-red',:linecolor => "#ff0000",:bgfrom => "#687478",:bgto => "#222222",:textcolor => "#ff0000",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'black-white',:linecolor => "#ffffff",:bgfrom => "#687478",:bgto => "#222222",:textcolor => "#ffffff",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'cornsilk-dimgray',:linecolor => "#696969",:bgfrom => "#fff8dc",:bgto => "#fff8dc",:textcolor => "#696969",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'green-green',:linecolor => "#003300",:bgfrom => "#00ff99",:bgto => "#339933",:textcolor => "#003300",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'lavender-dimgray',:linecolor => "#696969",:bgfrom => "#e6e6fa",:bgto => "#e6e6fa",:textcolor => "#696969",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'lavenderblush-dimgray',:linecolor => "#696969",:bgfrom => "#fff0f5",:bgto => "#fff0f5",:textcolor => "#696969" ,:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'lightcyan-dimgray',:linecolor => "#696969",:bgfrom => "#e0ffff",:bgto => "#e0ffff",:textcolor => "#696969",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b" )
Graphtemplate.create(:name=>'lightsteelblue-dimgray',:linecolor => "#696969",:bgfrom => "#e0ffff",:bgto => "#b0c4de",:textcolor => "#696969" ,:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'mistyrose-dimgray',:linecolor => "#696969",:bgfrom => "#ffe4e1",:bgto => "#ffe4e1",:textcolor => "#696969" ,:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'snow-dimgray',:linecolor => "#696969",:bgfrom => "#fffafa",:bgto => "#fffafa",:textcolor => "#696969",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'white-black',:linecolor => "#000000",:bgfrom => "#ffffff",:bgto => "#ffffff",:textcolor => "#000000",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'white-dimgray',:linecolor => "#696969",:bgfrom => "#ffffff",:bgto => "#ffffff",:textcolor => "#696969" ,:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")
Graphtemplate.create(:name=>'yellow-orange',:linecolor => "#ff6600",:bgfrom => "#ffff66",:bgto => "#ffcc33",:textcolor => "#ff6600",:linecolor_pre => "#90ee90",:linecolor_last => "#bdb76b")


