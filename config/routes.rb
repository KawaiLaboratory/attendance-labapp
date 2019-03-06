Rails.application.routes.draw do
  root 'pages#index'
  resources :laboratories, except: [:destroy, :new, :create]
  # ログイン/ログアウト用
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
