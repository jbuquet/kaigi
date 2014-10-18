Rails.application.routes.draw do
  resources :retrospectives do
    resources :users
  end

  root :to => 'retrospectives#new'
end
