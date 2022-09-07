Rails.application.routes.draw do
  namespace :api do
    resources :surveys
    resources :questions
    resources :answers
    # resources :answers, except: [:destroy]
  end

  root to: "home#index"
end
