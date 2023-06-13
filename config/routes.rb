Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace 'api' do
    scope 'categories' do
      post 'create', to: 'category#create'
      get 'index', to: 'category#index'
      get 'show/:id', to: 'category#show'
      patch 'update/:id', to: 'category#update'
      delete 'delete/:id', to: 'category#delete'
    end
    
    scope 'posts' do
      post 'create', to: 'post#create'
      get 'index', to: 'post#index'
      get 'show/:id', to: 'post#show'
      patch 'update/:id', to: 'post#update'
      delete 'delete/:id', to: 'post#delete'
    end
    
    scope 'feedbacks' do
      post 'create', to: 'feedback#create'
      get 'index', to: 'feedback#index'
      get 'show/:id', to: 'feedback#show'
      patch 'update/:id', to: 'feedback#update'
      delete 'delete/:id', to: 'feedback#delete'
    end
    
    scope 'commentaries' do
      post 'create', to: 'commentary#create'
      get 'index', to: 'commentary#index'
      get 'show/:id', to: 'commentary#show'
      patch 'update/:id', to: 'commentary#update'
      delete 'delete/:id', to: 'commentary#delete'
    end
    
    scope 'post_categories' do
      post 'create', to: 'post_category#create'
      get 'index', to: 'post_category#index'
      get 'show/:id', to: 'post_category#show'
      patch 'update/:id', to: 'post_category#update'
      delete 'delete/:id', to: 'post_category#delete'
    end
  end
end
