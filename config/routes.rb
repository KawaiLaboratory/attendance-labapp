Rails.application.routes.draw do
  devise_for :laboratories
  root 'laboratories#index'
  resources :laboratories, except: [:destroy, :new, :create], param: :name
  resource :members, only: [:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
