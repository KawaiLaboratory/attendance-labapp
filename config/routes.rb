Rails.application.routes.draw do
  get 'laboratories/index'
  get 'laboratories/show'
  get 'laboratories/new'
  get 'laboratories/edit'
  get 'laboratories/update'
  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
