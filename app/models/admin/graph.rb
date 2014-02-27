# coding: utf-8
# Admin::Graph Model
# Author:: Kazuko Ohmura
# Date:: 2013.07.25

# 管理用グラフモデル
class Admin::Graph < Graph
  #入力チェック
  # 名前
  validates :name,
    :presence => true,
    :uniqueness=>true,
    :length=>{:maximum=>20},
    :format=>{:with => /^[a-zA-Z0-9]+$/,:multiline=>true,:message=> I18n.t('message.error.graph.name.format.message')},
      :Graphstable=>true
  
  
  validates :title,           :presence => true                 # 表示名
  validates :analysis_type,  :presence => true                  # 分析タイプ（集計、平均）
  validates :graph_type,  :presence => true                     # グラフタイプ（折線、縦棒）
  validates :term,  :presence => true                           # 期間
  validates :y,  :presence => true                              # y
  validates :y_min,  :presence => true,:numericality => true                          # y最小値
  validates :useval, :presence => true,:numericality => true    # グラフに値を表示するかどうか
  validates :usetip, :presence => true,:numericality => true    # グラフにチップをつけるかどうか
  validates :linewidth, :presence => true,:numericality => {:only_integer => true} # 線の太さ
  validates :template, :presence => true                        # テンプレート名
  
  class << self
    # グラフの新規追加機能を利用させるかどうか
    def get_use_create_graph
      res = false
      if $settings['use_create_graph'] 
        if $settings['use_create_graph'].to_i == 1
          res = true
        end
      end
      return res
    end
  end
end

