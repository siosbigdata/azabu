# encoding: utf-8
# Merge Menu
# Author:: Kazuko Ohmura
# Date:: 2014.01.28

# メニューを設定（グループごとに設定）
# group_id:利用グループ
# parent_id:親ID (トップレベルは0)
# name:メニューの名前（グラフの場合はグラフ名のtd_抜き）
# title:表示名
# vieworder:並び順（あくまで同じ親、同レベルの中で）
# icon:利用アイコン
# menutype:メニューのタイプ(0:ラベル、1:dashboard、2:グラフ、3:マージグラフ）
#
# 例
# Menu.create(:group_id=>1,:parent_id => 0,:name => "dashboard" , :title => "ダッシュボード",:vieworder => 1,:icon => "icon-desktop",:menutype => 1)
# Menu.create(:group_id=>1,:parent_id => 1,:name => "graph1" , :title => "グラフ１",:vieworder => 2,:icon => "icon-picture",:menutype => 2)

class Menu < ActiveRecord::Base
end
