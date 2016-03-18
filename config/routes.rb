Rails.application.routes.draw do
  root 'staticpages#index'
  get    'projects' =>  'staticpages#projects'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :posts do
  	collection do
      get :tag
    end
  end	
  get    'tags'    =>  'posts#tag_cloud'
  

end
