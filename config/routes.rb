require 'sidekiq/web'
Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

Rails.application.routes.draw do
  # get '/test/wechat' => 'wechat_supports#auth_wechat'
  # writer your routes here

  namespace :wechat do
    namespace :writer do
      resources :posts
    end

    namespace :reader do
      resources :posts
    end
  end

  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'
  #mount ActionCable.server => '/cable'
  root to: 'visitors#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
end
