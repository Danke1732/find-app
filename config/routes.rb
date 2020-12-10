Rails.application.routes.draw do
  root to: 'articles#index'
  devise_for :users
  resources :articles do
    resources :comments, only: [:create, :destroy]
    collection do
      get 'get_category_children/:id' => 'articles#get_category_children'
      get 'get_category_grandchildren/:id' => 'articles#get_category_grandchildren' 
    end
    collection do
      get 'search'
    end
  end
  get '/bookmarks/:id', to: 'bookmarks#like'
end
