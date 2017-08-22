Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/auth/github', as: :github_login
  get '/auth/github/callback', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  namespace :authorized do
    get '/profile', to: "profile#show"
    get '/repos', to: "repositories#index"
    get '/activity', to: "activity#index"
    get '/following_activity', to: "following_activity#index"
    get '/organizations', to: "organizations#index"
  end
end
