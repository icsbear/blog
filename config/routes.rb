Rails.application.routes.draw do
  resources :posts
  root 'staticpages#index'
  get 'staticpages/projects'

end
