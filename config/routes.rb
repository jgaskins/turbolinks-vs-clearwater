Rails.application.routes.draw do
  namespace :turbolinks do
    resources :articles
  end

  get 'clearwater' => 'home#clearwater'
  get 'clearwater/*all' => 'home#clearwater'

  root to: 'home#index'
end
