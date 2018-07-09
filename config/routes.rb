Rails.application.routes.draw do
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :book
  root 'welcome#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/book_api', to: 'api#get_info'
  get '/manage_users', to: 'management_users#manage_users'
  put '/manage_users/promote', to: 'management_users#promote', as: 'promote'
  put '/manage_users/demote', to: 'management_users#demote', as: 'demote'
  post '/manage_users/change_role', to: 'management_users#change_role', as:'change_role'
  get '/manage_reservations', to: 'management_reservations#manage_reservations'
  put '/loan/confirm_loan', to: 'reservations#confirm_loan', as: 'confirm_loan'
  put '/loan/postpone_return', to: 'reservations#postpone_return', as: 'postpone_return'
  put '/loan/confirm_return', to: 'reservations#confirm_return', as: 'confirm_return'
  devise_scope :user do
    get '/users/login_email', to: 'login#login_email'
  end
end
