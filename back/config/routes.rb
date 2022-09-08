Rails.application.routes.draw do
  namespace :api do
    resources :surveys
    resources :questions
    resources :answers
  end

  # root to: "home#index"
end
