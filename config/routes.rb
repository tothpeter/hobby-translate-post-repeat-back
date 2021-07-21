# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/registrations'
    }

    resources :instagram_profiles, except: :create do
      post :import, on: :collection
    end

    namespace :instagram_posts do
      get :latest
    end

    resource :account, only: [:show]

    get 'test-auth' => 'test_auth#test'
  end

  get 'image-proxy/:requested_image_url' => 'image_proxy#show'
end
