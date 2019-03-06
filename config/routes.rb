Rails.application.routes.draw do
  root 'laboratories#index'
  resources :laboratories, except: [:destroy, :new, :create]
  # ログイン/ログアウト用
  get  "log_in", to: "sessions#new"
  post "log_in", to: "sessions#create"
  delete "log_out", to: "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
