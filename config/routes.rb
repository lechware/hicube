Hicube::Engine.routes.draw do
  
  root 'hicube/pages#show'

  devise_for :users,
    class_name: 'Hicube::User',
    path:        '',
    path_prefix: nil,
    failure_app: 'Hicube::Devise::FailureApp',
    module:      :devise

  resources :pages do
    resources :contents
  end

  resources :snippets
  
  resources :documents

  resource :tag

  resource :account
end

Rails.application.routes.draw do

  root 'hicube/public/pages#show', id: 'index'

  get ':id', to: 'hicube/public/pages#show', only: [:show]
  get ':id/edit', to: 'hicube/public/pages#edit', only: [:edit]
  post 'mail', to: 'hicube/public/pages#mail', only: [:mail]
  # get '/',        to: 'hicube/pages#show'
  # match '*path'   => 'hicube/pages#show', via: :all

  namespace :public do
    resources :pages, only: [:show, :edit]
  end

  get 'hicube/public/pages/:id', to: redirect('/%{id}')
end
