Rails.application.routes.draw do
  mount LetsencryptHttpChallenge::Engine => "/" unless ENV['LE_HTTP_CHALLENGE_RESPONSE'].blank?
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: 'pages#home'

  resources 'companies', only: [:index, :show, :new, :create, :edit, :update] do
    resources 'invoices', only: [:show, :new, :create, :edit, :update] do
      post 'paid', to: 'invoices#mark_as_paid'
      post 'send', to: 'invoices#send_via_email'
      resource 'email_message', only: [:edit, :update]
      resources 'tasks', only: [:create, :destroy]
    end
  end

  resource 'profile', only: [:edit, :update]
  resource 'bank_account_statement', only: [:new, :create, :edit, :update]

  resources 'invoices', only: [:index]
end
