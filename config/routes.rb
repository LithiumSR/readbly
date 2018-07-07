Rails.application.routes.draw do
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :book
  root 'welcome#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/book_api', to: 'api#get_info'
  get '/manage_users', to: 'management#manage_users'
  put '/manage_users/promote', to: 'management#promote', as: 'promote'
  put '/manage_users/demote', to: 'management#demote', as: 'demote'
  post '/manage_users/change_role', to: 'management#change_role', as:'change_role'
  devise_scope :user do
    get '/users/login_email', to: 'login#login_email'
  end
end
