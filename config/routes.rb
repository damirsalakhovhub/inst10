Rails.application.routes.draw do
  # Hotwire LiveReload (development only)
  mount Hotwire::Livereload::Engine, at: "/hotwire-livereload" if Rails.env.development?

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path - landing for unauthenticated, home for authenticated
  root "landing#index"
  
  # Landing page (alias for root)
  get "landing", to: "landing#index"
  
  # Home page (for authenticated users)
  get "home", to: "home#index"

  # UI Kit
  scope path: "kit", module: "ui_kit", as: "ui_kit" do
    root "pages#index"
    get "buttons", to: "pages#buttons"
    get "selects", to: "pages#selects"
    get "inputs", to: "pages#inputs"
    get "checkboxes", to: "pages#checkboxes"
    get "dialogs", to: "pages#dialogs"
    get "typography", to: "pages#typography"
  end

  # User management (authorization, caching)
  # Exclude Devise reserved paths to avoid route conflicts
  resources :users, only: [ :index, :show ], constraints: { id: /[0-9]+/ }

  resources :projects, except: [ :destroy ]
end
