#coding: utf-8
# GraphsController
# Author:: Kazuko Ohmura
# Date:: 2013.07.25

Shirokane::Application.routes.draw do
  root 'dashboards#index'
  resources :dashboards
  #get "password_resets/new"
  resources :password_resets
  
  resources :login
  resources :users
  resources :graphs do
    member do
      get 'csvexport'
      post 'setday'
    end
  end
  resources :merges do
  member do
    post 'setday'
  end
end
  
    # You can have the root of your site routed with "root"
    # root 'welcome#index'
    

  #管理画面用
  namespace :admin do
    resources :login
    resources :users
    resources :graphs
    resources :groups
    resources :home
    resources :settings
    resources :menus do
      member do
        get 'list'
      end
    end
    resources :merges
    resources :mergegraphs do
      member do
        get 'list'
      end
    end

    root 'home#index'
  end
end
