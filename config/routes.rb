Rails.application.routes.draw do

  root 'orders#index'

  devise_for :users, only:[]
  as :user do
    get '/sign_in',       to: 'devise/sessions#new',             as: 'new_user_session'
    post '/sign_in',      to: 'devise/sessions#create',          as: 'user_session'
    delete '/sign_out',   to: 'devise/sessions#destroy',         as: 'destroy_user_session'
    get '/sign_up',       to: 'devise/registrations#new',        as: 'new_user_registration'
    post '/sign_up',      to: 'devise/registrations#create',     as: 'user_registration'
  end

  resource :orders do
    get :step1
    get :step2
    get :step3
    get :step4
    post :save_step
  end
end
