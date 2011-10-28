Guidance::Application.routes.draw do 
  get 'my_account' => 'users#my_account'
  put 'my_account_update' => 'users#my_account_update'
  match 'search' => 'notes#search'

  resources :counselors, controller: "users" do

  end
  resource :users do

  end
  resources :smart_groups do
    member do
      post :snapshot
    end
    collection do
      get "new_field/:count", action: :new_field, as: :new_field
    end
  end

  resources :groups do
    resources :notes
    collection do
      get :search
    end
  end

  resources :categories do
    member do
      get :report
    end
    resources :notes
  end

  resources :tags, only: [:index, :show]

  match 'dashboard' => 'dashboard#index'

  resources :notes do
    collection do 
      get :unassigned
    end
    resources :students
  end

  resources :students do
    resources :notes
    collection do
      get :search
      get :all
      get :inactive
    end
  end

  devise_for  :users do
    get "/" => "devise/sessions#new", as: "login"
    get "/logout" => "devise/sessions#destroy", as: "logout"
  end


  match "/login" => redirect("/")

  root :to => "devise/sessions#new"
end
