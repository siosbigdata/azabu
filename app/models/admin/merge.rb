# encoding: utf-8
# Merge Admin::Merge
# Author:: Kazuko Ohmura
# Date:: 2014.01.29

class Admin::Merge < Merge
  #入力チェック
    validates :name, :presence => true,:uniqueness=>true # 名前
    validates :title, :presence => true # 表示名
    validates :term,  :presence => true                           # 期間
end
