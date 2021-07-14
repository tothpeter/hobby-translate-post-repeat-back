# frozen_string_literal: true

class Api::AccountsController < ApplicationController
  before_action :authenticate_api_user!

  def show
    render json: UserSerializer.render(current_api_user)
  end
end
