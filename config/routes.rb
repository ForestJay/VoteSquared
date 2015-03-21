VoteSquared::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :users do
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  resources :users do
    resources :voter_ratings
  end

  resources :politicians do
    resources :watches
    resources :voter_ratings do
      resources :votes
    end
  end

  resources :omniauth_callbacks, :devise

  match '/about/community' => 'about#community', via: [:get]
  match '/about/funding' => 'about#funding', via: [:get]
  match '/about/democratic_antipatterns' => 'about#democratic_antipatterns', via: [:get]
  match '/users/:id/edit', to: 'users#update_custom', via: [:patch]
  match '/politicians/:politician_id/voter_ratings/:id/edit', to: 'voter_ratings#update', via: [:patch]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
