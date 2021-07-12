class TestAuthController < ApplicationController
  before_action :authenticate_user!

  def test
    head 200
  end
end
