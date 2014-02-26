OSS Dashboard - グラフマージ用
=========
shirokaneに複数グラフのマージ機能を追加したものです。  
過去データの表示機能は削除しました。
指定した期間のデータを表示します。時間別、日別、週別、月別の合計値か平均値を見ることができます。

インストール方法はshirokaneと同じです。

グラフの作成
=========
* テーブルの作成
  もし、「test01」というグラフを表示したい場合は下記のテーブルをデータベースに作成します。(ex. postgresql)

```
>create table td_test01 (td_time timestamp with time zone,td_count decimal);
>create table td_hour_test01 (td_time timestamp with time zone,td_count decimal,analysis_type integer);
>create table td_day_test01 (td_time timestamp with time zone,td_count decimal,analysis_type integer);
>create table td_week_test01 (td_time timestamp with time zone,td_count decimal,analysis_type integer);
>create table td_month_test01 (td_time timestamp with time zone,td_count decimal,analysis_type integer);
  
$ rails c
>Graph.create(:name=>"test01",:title=>"テスト０１",:analysis_type=>0,:graph_type=>0,:term=>1,:y=>"count",:y_min=>0,:useval=>0,:usetip => 0,:linewidth=>2,:linecolor=>"#FF0000",:template=>"white-dimgray")
```
注意
=========
* Ruby on Rails4で動作しています。
* 日本語のみ対応していますが、config/locales以下に他言語のファイルを作成することができます。
* config/database.ymlは作成してください。

ライセンス
=========
* Copyright &copy; 2014 SIOS Technology,Inc.  
* Distributed under the [MIT License][MIT]([Japanese][MIT_JP]).  

* Part of chart  :ccchart
[Copyright (c) 2013 Toshiro Takahashi][CCCHART]  
  
[MIT]: http://www.opensource.org/licenses/mit-license.php
[MIT_JP]: http://sourceforge.jp/projects/opensource/wiki/licenses%2FMIT_license
[CCCHART]: http://ccchart.com/  
