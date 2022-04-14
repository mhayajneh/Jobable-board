# frozen_string_literal: true

class AdminController < ApplicationController
  skip_before_action :authorize_request, only: :create



  def create
    oneAdmin = User.where(admin: [true]).count
    if params.key?(:email) && User.where('email = ?', params[:email]).exists?
      if oneAdmin == 0
        User.where('email = ?', params[:email]).update(admin: true)
        response = { message: params[:email]  + ' user with this email is now admin' }
        json_response(response)
      else
        response = { message: 'You can only create one admin' }
        json_response(response)
      end
    else
      response = { message: 'Email dont exists' }
      json_response(response)
    end
  end

  private

  def user_params
    params.permit(
      :admin,
      :email
    )
  end
end
