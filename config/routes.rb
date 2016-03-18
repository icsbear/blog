Rails.application.routes.draw do
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :posts do
  	collection do
    get :tag
  end
  end	
  get    'tags'    =>  'posts#tag_cloud'
  root 'staticpages#index'
  get    'projects' =>  'spstaticpages#projects'

end
