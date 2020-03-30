Rails.application.routes.draw do
  devise_for :laboratories
  root 'laboratories#index'
  resources :laboratories, except: [:destroy, :new, :create], param: :name do
    get "/all_logs", to: "laboratories#all_logs"
  end
  resource :members, only: [:update]
  namespace :laboratory do
    resources :events, only: [:index, :create, :update]
  end
  #雑ajax
  get "/ajax", to: "laboratories#ajax"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
