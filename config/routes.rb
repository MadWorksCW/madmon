Madmon::Application.routes.draw do
  root 'datapoints#index'
  resources :datapoints
  resources :watches
end
