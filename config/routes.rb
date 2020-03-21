Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      confirmations: 'user/confirmations',
      ominauth_callbacks: 'user/ominauth_callbacks',
      passwords: 'user/passwords',
      registrations: 'user/registrations',
      sessions: 'user/sessions',
      unlocks: 'user/unlocks',
    }

  devise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new"
    end

    authenticated do
      root to: "pages/landing_page#show", as: :unauthenticated_root
    end
  end
end
