Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      confirmations: "user/confirmations",
      ominauth_callbacks: "user/ominauth_callbacks",
      passwords: "user/passwords",
      registrations: "user/registrations",
      sessions: "user/sessions",
      unlocks: "user/unlocks"
    }

  devise_scope :user do
    unauthenticated do
      root to: "user/sessions#new", as: :unauthenticated_root
    end

    authenticated do
      root to: "accounts/dashboard#show"
    end

    get "users/password/", to: "user/passwords#new"
    get "users/", to: "user/registrations#new"
  end

  resource :launch_pad, controller: "launch_pad", only: [:show] do
    collection do
      get "/choose", to: "launch_pad#choose"
    end
  end

  resources :accounts do
    resource :dashboard, controller: "dashboard", module: "accounts"
    resources :memberships, module: "accounts"
  end

  resources :buckets do
    resource :message_board, controller: "message_board", module: "buckets" do
      resources :messages, module: "message_boards", only: [:new, :create] do
        resources :comments, module: "messages"
      end
    end

    resources :recordings, module: "buckets" do
      resources :archivals, only: [:create], module: "recordings"
      resources :trashings, only: [:create], module: "recordings"
      resources :copies, only: %i[new create], module: "recordings"
      resources :moves, only: %i[new create], module: "recordings"
    end

    resources :todo_lists, module: "buckets"
    resources :todos, module: "buckets" do
      resource :completion, controller: "completion", only: [:create], module: "todos"
    end

    resources :messages, module: "buckets", only: [:show, :edit, :update]
    resources :todo_sets, module: "buckets", only: [:show]
  end

  resources :projects do
    # resource :message_board, controller: "message_board", module: "projects"
    resources :memberships, module: "projects"
    resources :todo_lists, module: "projects"

    # resources :messages, module: "projects" do
    #   resources :comments, module: "messages"
    #   resources :copies, only: %i[new create], module: "messages"
    #   resources :moves, only: %i[new create], module: "messages"
    # end
  end
end
