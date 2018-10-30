Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: 'pages#home'

  resources 'companies', only: [:index, :show, :new, :create, :edit, :update] do
    resources 'invoices', only: [:show, :new, :create, :edit, :update] do
      post 'paid', to: 'invoices#mark_as_paid'
      post 'send', to: 'invoices#send_via_email'
      resource 'email_message', only: [:edit, :update]
      resources 'tasks', only: [:create, :destroy]
      resource 'estimate', only: :show
    end
  end

  resources :partners, only: [:index, :show, :new, :create, :edit, :update] do
    resources :subcontracts, only: [:new, :create, :edit, :update]
  end

  resource 'profile',   only: [:edit, :update]
  resource 'dashboard', only: [:show]
  resource 'bank_account_statement', only: [:new, :create, :edit, :update]

  resources 'invoices', only: [:index]
end
