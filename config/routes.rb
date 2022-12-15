Rails.application.routes.draw do

  root "members#index"
    
  resources :members do
    resources :loans
    
    collection do 
      post 'import'
      get  'upload'
    end 
  end
    
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
