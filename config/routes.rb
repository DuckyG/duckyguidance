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

  controller :user_sessions do
    get  'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  resources :counselors do
  end

  get 'thankyou' => 'thankyou#index'

  root :to => "user_sessions#new"
end
