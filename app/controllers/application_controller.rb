# encoding: utf-8
# ApplicationController
# Author:: Kazuko Ohmura
# Date:: 2013.07.25

# ApplicationController
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery
  # ----------------------------------------------------------- #
  # Settingsの値取得
  def get_settings
    if $settings == nil
      ss = Setting.all
      $settings = Hash.new()
      ss.map{|s|
        $settings[s.name.to_s] = s.parameter.to_s
      }
    end
  end
end
