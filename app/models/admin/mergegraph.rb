# coding: utf-8
# Merge Admin::Mergegraph
# Author:: Kazuko Ohmura
# Date:: 2014.01.29

class Admin::Mergegraph < Mergegraph
  #入力チェック
  validates :merge_id,  :presence => true,:numericality=>true
  validates :graph_id,  :presence => true,:numericality=>true
  validates :side,  :presence => true,:numericality=>true
  validates :y,  :presence => true
  validates :vieworder,  :presence => true,:numericality=>true
end
