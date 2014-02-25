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
  # アソシエーション
  has_many :groupgraph
end
