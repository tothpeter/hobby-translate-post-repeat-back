class Api::TestAuthController < ApplicationController
  before_action :authenticate_api_user!

  def test
    head 200
  end
end
