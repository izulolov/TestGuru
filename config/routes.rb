Rails.application.routes.draw do

  root to: 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
    end
    resources :gists, only: %i[create]
  end

  namespace :admin do
    resources :tests do
      member do
        patch :status
      end
      patch :update_inline, on: :member
      resources :questions, shallow: true do
        resources :answers, shallow: true
      end
    end
    resources :gists
    resources :badges
  end

  resources :feedbacks, only: %i[new create]
  resources :badges, only: %i[index]
end
