Rails.application.routes.draw do
  resources :retrospectives

  root :to => 'retrospectives#new'
end
