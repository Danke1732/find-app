Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'ranking', to: 'articles#ranking'
    end
    collection do
      get 'get_category_children/:id', to: 'articles#get_category_children'
      get 'get_category_grandchildren/:id', to: 'articles#get_category_grandchildren' 
    end
    collection do
      get 'search'
    end
  end
  post '/bookmarks/:id', to: 'bookmarks#like'
  resources :users, only: [:index, :show] do
    get '/bookmarks', to: 'bookmarks#index'
    get '/notes', to: 'notes#index'
    get '/profiles', to: 'profiles#show'
    get '/profiles/edit', to: 'profiles#edit'
    patch '/profiles/update', to: 'profiles#update'
  end
  resources :profiles, only: [:new, :create]
  resources :notes, only: [:create, :destroy]
  resources :categories, only: [:index, :show]
end
