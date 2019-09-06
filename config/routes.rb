Rails.application.routes.draw do
  resources :posts, only: [:create, :show]
  get '/status', to: 'status#status'
end
