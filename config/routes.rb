Rails.application.routes.draw do
  get '/book/search', to: 'books#search_form', as: 'search_form'
  get '/book/results', to: 'books#results_search', as: 'search_results'
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :book
  root 'welcome#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/book_api', to: 'api#get_info'
  get '/manage_users', to: 'management_users#manage_users'
  post '/users/change_role', to: 'management_users#change_role', as:'change_role'
  get '/manage_reservations', to: 'management_reservations#manage_reservations'
  get '/my_reservations', to: 'management_reservations#my_reservations'
  get '/reservation', to: 'reservations#book_reservations', as: 'book_reservations'
  post '/reservation', to: 'reservations#create', as:'create_reservation'
  put '/reservation/confirm_loan', to: 'reservations#confirm_loan', as: 'confirm_loan'
  put '/reservation/postpone_return', to: 'reservations#postpone_return', as: 'postpone_return'
  put '/reservation/confirm_return', to: 'reservations#confirm_return', as: 'confirm_return'
  delete '/reservation/delete', to: 'reservations#destroy', as: 'delete_reservation'
  devise_scope :user do
    get '/users/login_email', to: 'login#login_email'
  end
end
