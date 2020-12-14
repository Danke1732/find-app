Rails.application.routes.draw do
  root to: 'articles#index'
  devise_for :users
  resources :articles do
    resources :comments, only: [:create, :destroy]
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
  end
  resources :notes, only: [:create, :destroy]
end
