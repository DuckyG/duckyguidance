Guidance::Application.routes.draw do 
  get 'my_account' => 'counselors#my_account'
  put 'my_account_update' => 'counselors#my_account_update'
  match 'search' => 'notes#search'

  resources :smart_groups do
    member do
      post :snapshot
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
    resources :students
  end

  resources :students do
    resources :notes
    collection do
      get :search
      get :all
      get :graduated
    end
  end

  devise_for  :counselors do
    get "/" => "devise/sessions#new", as: "login"
    get "/logout" => "devise/sessions#destroy", as: "logout"
  end

  get 'thankyou' => 'thankyou#index'

  root :to => "devise/sessions#new"
end
