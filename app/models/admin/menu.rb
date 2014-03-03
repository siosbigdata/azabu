# coding: utf-8
# Merge Admin::Menu
# Author:: Kazuko Ohmura
# Date:: 2014.01.29

class Admin::Menu < Menu
  #入力チェック
  validates :group_id,  :presence => true,:numericality=>true
  validates :parent_id,  :presence => true,:numericality=>true
  validates :name,  :presence => true,:uniqueness=>true
  validates :title,  :presence => true
  validates :vieworder,  :presence => true,:numericality=>true
  validates :icon,  :presence => true
  validates :menutype,  :presence => true,:numericality=>true
end
