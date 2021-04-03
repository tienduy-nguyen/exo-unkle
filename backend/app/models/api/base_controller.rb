class Api::BaseController < ApplicationController
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { error: "Not found", status: 404 }, status: 404
  end
end
