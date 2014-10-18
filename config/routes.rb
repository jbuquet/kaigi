Rails.application.routes.draw do
  resources :retrospectives do
    resources :users
    resources :statuses
  end

  root :to => 'retrospectives#new'
end
