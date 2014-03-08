Madmon::Application.routes.draw do
  root to: "datapoints#index"
  resources :datapoints
  resources :watches do
    resources :datapoints
  end
end
