Rails.application.routes.draw do
  resources :retrospectives do
    get :summary

    resources :users
    resources :statuses
  end

  root :to => 'retrospectives#new'
end
