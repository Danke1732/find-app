Rails.application.routes.draw do
  root to: 'articles#index'
  devise_for :users
  resources :articles, only: [:new, :create, :show, :destroy] do
    collection do
      get 'get_category_children/:id' => 'articles#get_category_children'
      get 'get_category_grandchildren/:id' => 'articles#get_category_grandchildren' 
    end
  end
end
