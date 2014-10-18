Rails.application.routes.draw do
  resources :retrospectives, except: :show

  get 'retrospectives/:public_key', :to => 'retrospectives#show'

  root :to => 'retrospectives#new'
end
