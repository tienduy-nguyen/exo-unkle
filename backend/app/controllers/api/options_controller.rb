class Api::OptionsController < ApplicationController
  before_action :set_option, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin

  # GET /options
  def index
    contract_id = params[:contract_id]
    if contract_id
      @options = Contract.find(contract_id).options
    else
      @options = Option.all
    end

    render json: @options
  end

  # Get /options/:id
  def show
    render json: @option
  end

  # POST /options
  def create
    @option = Option.new(option_params)

    if @option.save
      render json: @option, status: :created, location: @api_option
    else
      render json: @option.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /options/:id
  def update
    if @option.update(option_params)
      render json: @option
    else
      render json: @option.errors, status: :unprocessable_entity
    end
  end

  # DELETE /options/1
  def destroy
    @option.destroy
    return render json: { destroy: true }, status: 200
  end

  # ---------------private methods-----------------------------
  private

  def set_option
    @option = Option.find(params[:id])
  end

  def option_params
    params.require(:option).permit(:name, :description)
  end

  def is_admin
    return true if current_user&.is_admin
    render json: { error: "UnAuthorized", status: 401 }, status: 401
  end
end
