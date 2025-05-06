Rails.application.routes.draw do
  root "boards#index"

  resources :boards, shallow: true

  get "up" => "rails/health#show", as: :rails_health_check
end
