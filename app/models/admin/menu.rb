# encoding: utf-8
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

#Menu.create(:group_id=>1,:level => 1,:parent_id => 0,:name => "dashboard" , :title => "ダッシュボード",:vieworder => 1,:icon => "icon-desktop",:menutype => 1)
