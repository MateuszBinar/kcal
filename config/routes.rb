Rails.application.routes.draw do
  devise_for :users
  get 'archives/weeks'
  get 'archives/index'
  get 'archive/index'

  get "entries/comment" => 'entries#comment', :as => :comment
  get "archives/week"

  resources :entries
  root to: "entries#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
