Rails.application.routes.draw do
  resources :retrospectives,only: [:new, :create, :show]

  root :to => 'retrospectives#new'
end