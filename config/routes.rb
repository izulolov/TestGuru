Rails.application.routes.draw do
  get 'users/new'
  #resources :answers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'tests#index'

  get :signup, to: 'users#new'

  resources :users, only: :create

  resources :tests do
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end

    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
  end
end
