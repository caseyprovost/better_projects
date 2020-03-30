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

  resources :projects do
    resource :message_board, controller: "message_board", module: "projects"
    resources :memberships, module: "projects"
    resources :todo_lists, module: "projects"

    resources :messages, module: "projects" do
      resources :comments, module: "messages"
      resources :copies, only: %i[new create], module: "messages"
      resources :moves, only: %i[new create], module: "messages"
    end
  end
end
