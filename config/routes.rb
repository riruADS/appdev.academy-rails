Rails.application.routes.draw do
  # Static pages
  root 'pages#home'
  get '/about', to: 'pages#about'
  get '/contacts', to: 'pages#contacts'
  get '/guides', to: 'pages#guides'
  get '/open-source', to: 'pages#open_source'
  
  # Blog
  resources :articles, only: [:index, :show], param: :slug
  
  # RSS feed
  get '/feed', to: 'articles#feed', defaults: { format: 'rss' }
  
  # Portfolio with projects
  namespace :portfolio do
    root to: 'projects#index'
    resources :projects, only: [:show], param: :slug
  end
  
  resources :screencasts, only: [:index, :show], param: :slug do
    resources :lessons, only: [:show], param: :slug
  end
  
  # JSON API
  namespace :api, shallow: true, constraints: { format: :json } do
    namespace :react do
      resources :articles, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
      end
      
      resources :dashboards, only: [] do
        get :main, on: :collection
      end
      
      resources :gallery_images, only: [:destroy] do
        collection do
          post :sort
        end
      end
      
      resources :images, only: [:index, :create, :destroy]
      
      resources :pages, only: [:index, :show, :update], param: :slug
      
      resources :projects, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
        
        resources :gallery_images, only: [:index, :create]
      end
      
      resources :sessions, only: [:create] do
        delete 'destroy', on: :collection
      end
      
      resources :tags, only: [:index]
      
      resources :topics, only: [:index, :show, :create, :update, :destroy] do
        post :publish, on: :member
        post :hide, on: :member
        post :sort, on: :collection
        
        resources :screencasts, only: [:index, :show, :create, :update, :destroy] do
          post :publish, on: :member
          post :hide, on: :member
          post :sort, on: :collection
          
          resources :lessons, only: [:index, :show, :create, :update, :destroy] do
            post :publish, on: :member
            post :hide, on: :member
            post :sort, on: :collection
          end
        end
      end
    end
  end
end
