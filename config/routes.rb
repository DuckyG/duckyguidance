Guidance::Application.routes.draw do |map|
  get 'my_account' => 'counselors#my_account'
  put 'my_account_update' => 'counselors#my_account_update'
  match 'search' => 'notes#search'
  
  resources :groups do
    resources :notes
    collection do
      get :search
    end
  end
  resources :users
  constraints :subdomain => 'admin' do
    resources :schools
  end
  resources :categories do
    member do
      get :report
    end
  end

  resources :tags

  get "dashboard/index"
  match 'dashboard' => 'dashboard#index'
  resources :notes

  resources :students do
    resources :notes
    collection do
      get :search
    end
  end

  controller :meeting_requests do
    get 'request' => :new
    post 'request' => :create
  end

  controller :user_sessions do
    get  'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end
  resources :meeting_requests do
    collection do
      get :past
      get :future
      post :welcome_submit
    end
  end

  resources :counselors
  get 'thankyou' => 'thankyou#index'

  root :to => "meeting_requests#welcome"


end
