Rails.application.routes.draw do
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :posts
  root 'staticpages#index'
  get    'projects' =>  'staticpages/projects'

end
