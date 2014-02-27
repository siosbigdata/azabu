# coding: utf-8
# Merge Mergegraph
# Author:: Kazuko Ohmura
# Date:: 2014.01.29

class Mergegraph < ActiveRecord::Base
  SIDE = {
    0 => I18n.t("admin.mergegraph.side.left"),
    1 => I18n.t("admin.mergegraph.side.right"),
  }
end
