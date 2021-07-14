# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/registrations'
    }

    resource :account, only: [:show]

    get 'test-auth' => 'test_auth#test'
  end
end
