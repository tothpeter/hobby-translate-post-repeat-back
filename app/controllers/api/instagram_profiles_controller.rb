# frozen_string_literal: true

class Api::InstagramProfilesController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_instagram_profile, only: [:show, :update, :destroy]

  def index
    render json: InstagramProfile.all
  end

  def show
    render json: InstagramProfileSerializer.render(@instagram_profile)
  end

  def import
    user_name = params.require(:user_name)
    new_instagram_profile = Instagram.import_profile!(user_name)

    render json: InstagramProfileSerializer.render(new_instagram_profile), status: :created
  end

  def update
    if @instagram_profile.update(update_instagram_profile_params)
      render json: InstagramProfileSerializer.render(@instagram_profile)
    else
      render json: { errors: @instagram_profile.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @instagram_profile.destroy
  end

  private

  def set_instagram_profile
    @instagram_profile = InstagramProfile.find(params[:id])
  end

  def update_instagram_profile_params
    params
      .require(:instagram_profile)
      .permit(
        :external_id,
        :user_name,
        :full_name,
        :profile_pic_url,
        :full_info
      )
  end
end
