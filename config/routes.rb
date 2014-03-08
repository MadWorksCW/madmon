Madmon::Application.routes.draw do
  root to: "watches#index"
  resources :datapoints
  resources :watches do
    resources :datapoints
  end
end
